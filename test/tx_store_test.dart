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
        payload: p, amount: 99, category: Category.food, upiApp: 'Google Pay');
    final attemptId = await store.recordLaunch(txId: txId, app: 'Google Pay');

    final waiting = await store.awaitingReturn();
    expect(waiting.single.id, txId);

    await store.reconcile(txId: txId, attemptId: attemptId, to: PayStatus.successful);
    expect(await store.awaitingReturn(), isEmpty);
    expect(await db.confirmedTotal(), 99);

    final attempts = await db.select(db.paymentAttempts).get();
    expect(attempts.single.returnedAt, isNotNull);
    expect(attempts.single.callbackStatus, 'successful');
  });

  test('illegal transitions throw, terminal states stick', () async {
    final p = UpiPayload.parse('upi://pay?pa=shop@upi');
    final txId = await store.createInitiated(
        payload: p, amount: 10, category: Category.home);
    final attemptId = await store.recordLaunch(txId: txId, app: 'Paytm');
    await store.reconcile(
        txId: txId, attemptId: attemptId, to: PayStatus.successful);
    expect(
        () => store.reconcile(
            txId: txId, attemptId: attemptId, to: PayStatus.pending),
        throwsStateError); // terminal: no exits
  });

  test('pending stays out of confirmed totals until resolved', () async {
    final p = UpiPayload.parse('upi://pay?pa=shop@upi');
    final txId = await store.createInitiated(
        payload: p, amount: 50, category: Category.college);
    final attemptId = await store.recordLaunch(txId: txId, app: 'PhonePe');
    await store.reconcile(
        txId: txId, attemptId: attemptId, to: PayStatus.pending);
    expect(await db.confirmedTotal(), 0);
    expect((await store.awaitingReturn()), isEmpty);
  });
}
