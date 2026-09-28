// TxStore tests: seed, create, reconcile — against real SQLite.
import 'package:drift/native.dart';
import 'package:equinox/data/db/app_db.dart';
import 'package:equinox/data/tx_store.dart';
import 'package:equinox/domain/models.dart';
import 'package:equinox/domain/upi/upi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDb db;
  late TxStore store;
  setUp(() {
    db = AppDb.forTesting(NativeDatabase.memory());
    store = TxStore(db);
  });
  tearDown(() => db.close());

  test('seedOnce inserts seed data exactly once', () async {
    await store.seedOnce();
    await store.seedOnce();
    expect(await store.watchAll().first, hasLength(26));
    expect(await db.confirmedTotal(), 24860);
  });

  test('create → awaiting → reconcile happy path', () async {
    final p = UpiPayload.parse('upi://pay?pa=shop@upi&pn=Shop&am=99');
    final txId = await store.createInitiated(
      payload: p,
      amount: 99,
      category: Category.food,
      upiApp: 'Google Pay',
    );
    final attemptId = await store.recordLaunch(
      txId: txId,
      app: 'Google Pay',
      sentUri: 'upi://pay?pa=shop@upi&am=99.00&tr=EQ123',
    );

    final waiting = await store.awaitingReturn();
    expect(waiting.single.id, txId);

    await store.reconcile(
      txId: txId,
      attemptId: attemptId,
      to: PayStatus.successful,
    );
    expect(await store.awaitingReturn(), isEmpty);
    expect(await db.confirmedTotal(), 99);

    final attempts = await db.select(db.paymentAttempts).get();
    expect(attempts.single.returnedAt, isNotNull);
    expect(attempts.single.callbackStatus, 'successful');
    expect(attempts.single.rawResponse, contains('upi://pay'));
  });

  test('illegal transitions throw, terminal states stick', () async {
    final p = UpiPayload.parse('upi://pay?pa=shop@upi');
    final txId = await store.createInitiated(
      payload: p,
      amount: 10,
      category: Category.home,
    );
    final attemptId = await store.recordLaunch(txId: txId, app: 'Paytm');
    await store.reconcile(
      txId: txId,
      attemptId: attemptId,
      to: PayStatus.successful,
    );
    expect(
      () => store.reconcile(
        txId: txId,
        attemptId: attemptId,
        to: PayStatus.pending,
      ),
      throwsStateError,
    ); // terminal: no exits
  });

  test('pending stays out of confirmed totals until resolved', () async {
    final p = UpiPayload.parse('upi://pay?pa=shop@upi');
    final txId = await store.createInitiated(
      payload: p,
      amount: 50,
      category: Category.college,
    );
    final attemptId = await store.recordLaunch(txId: txId, app: 'PhonePe');
    await store.reconcile(
      txId: txId,
      attemptId: attemptId,
      to: PayStatus.pending,
    );
    expect(await db.confirmedTotal(), 0);
    expect((await store.awaitingReturn()), isEmpty);
  });

  test('savings writes never touch spending totals and vice versa', () async {
    await store.addSaving(amount: 2000, description: 'Sept');
    expect(await db.confirmedTotal(), 0);
    final savings = await store.watchSavings().first;
    expect(savings.single.amount, 2000);
    expect(() => store.addSaving(amount: 0), throwsArgumentError);
    expect(() => store.addSaving(amount: -5), throwsArgumentError);
  });

  test('contribute bumps goal atomically; paused goals refuse', () async {
    final goalId = await store.addGoal(name: 'Emergency Fund', target: 80000);
    await store.contribute(goalId: goalId, amount: 32000);
    var goals = await store.watchGoals().first;
    expect(goals.single.current, 32000);
    expect(goals.single.progress, closeTo(0.4, 0.0001));

    await store.setGoalStatus(id: goalId, status: GoalStatus.paused);
    expect(
      () => store.contribute(goalId: goalId, amount: 100),
      throwsStateError,
    );
    goals = await store.watchGoals().first;
    expect(goals.single.current, 32000); // unchanged

    await store.setGoalStatus(id: goalId, status: GoalStatus.active);
    await store.contribute(goalId: goalId, amount: 1000);
    goals = await store.watchGoals().first;
    expect(goals.single.current, 33000);
  });

  test('deleteGoal keeps history as General', () async {
    final goalId = await store.addGoal(name: 'Trip', target: 10000);
    await store.contribute(goalId: goalId, amount: 500);
    await store.deleteGoal(goalId);
    expect(await store.watchGoals().first, isEmpty);
    final savings = await store.watchSavings().first;
    expect(savings.single.goalId, isNull);
    expect(savings.single.amount, 500);
  });

  test('target persists with validation', () async {
    expect(await store.watchTarget().first, 5000); // column default
    await store.setTarget(8000);
    expect(await store.watchTarget().first, 8000);
    expect(() => store.setTarget(-1), throwsArgumentError);
  });

  test('goal validation rejects blanks', () async {
    expect(() => store.addGoal(name: '  ', target: 100), throwsArgumentError);
    expect(() => store.addGoal(name: 'X', target: 0), throwsArgumentError);
  });
}
