// Backup round-trip tests (§44–46) on throwaway SQLite.
import 'package:drift/native.dart';
import 'package:equinox/data/backup.dart';
import 'package:equinox/data/db/app_db.dart';
import 'package:equinox/data/tx_store.dart';
import 'package:equinox/domain/models.dart';
import 'package:equinox/domain/upi/upi.dart';
import 'package:flutter_test/flutter_test.dart';

Future<(AppDb, TxStore)> _seeded() async {
  final db = AppDb.forTesting(NativeDatabase.memory());
  final store = TxStore(db);
  await store.seedOnce();
  return (db, store);
}

void main() {
  test('export → wipe → import round-trips losslessly', () async {
    final (db, store) = await _seeded();
    final p = UpiPayload.parse('upi://pay?pa=a@b&pn=Shop');
    final txId = await store.createInitiated(
      payload: p,
      amount: 42,
      category: Category.food,
      upiApp: 'Google Pay',
    );
    await store.recordLaunch(txId: txId, app: 'Google Pay');
    final goalId = await store.addGoal(name: 'G', target: 100);
    await store.contribute(goalId: goalId, amount: 10);
    await store.setTarget(7000);

    final json = await exportJson(db);
    final csv = await exportCsv(db);
    expect(csv.split('\n').first, contains('merchant'));
    expect(csv, contains('Shop'));
    expect(csv, contains('42'));

    await store.wipeAll();
    expect(await db.confirmedTotal(), 0);
    expect(await store.watchSavings().first, isEmpty);

    await importJson(db, json);
    expect(await db.confirmedTotal(), 24860); // initiated 42 stays out
    expect((await store.watchSavings().first).length, 3);
    final goals = await store.watchGoals().first;
    expect(goals.single.current, 10);
    expect(await store.watchTarget().first, 7000);
    expect((await db.select(db.paymentAttempts).get()).length, 1);
    await db.close();
  });

  test('import rejects garbage WITHOUT wiping', () async {
    final (db, _) = await _seeded();
    final bad = [
      '{"nope":true}',
      '{"app":"equinox","version":999}',
      '{"app":"equinox","version":1,"transactions":"oops"}',
      'not json at all',
    ];
    for (final b in bad) {
      expect(() => importJson(db, b), throwsA(isA<Exception>()), reason: b);
    }
    expect(await db.confirmedTotal(), 24860); // untouched
    await db.close();
  });

  test('wipeAll removes everything and blocks reseed', () async {
    final (db, store) = await _seeded();
    var flag = true; // simulate: this device already seeded once
    await store.wipeAll(markSeeded: () async {});
    expect(await store.watchAll().first, isEmpty);
    expect(await store.watchGoals().first, isEmpty);
    await store.seedOnce(isSeeded: () async => flag, markSeeded: () async {});
    expect(await store.watchAll().first, isEmpty); // stays deleted
    flag = false;
    await store.seedOnce(
      isSeeded: () async => flag,
      markSeeded: () async => flag = true,
    );
    expect(await store.watchAll().first, hasLength(26)); // fresh seed works
    await db.close();
  });
}
