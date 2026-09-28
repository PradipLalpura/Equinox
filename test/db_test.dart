// DAO + index tests against real SQLite (§53–54).
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:equinox/data/db/app_db.dart';
import 'package:flutter_test/flutter_test.dart';

AppDb openTestDb() => AppDb.forTesting(NativeDatabase.memory());

Future<void> seedDb(AppDb db) async {
  Future<void> add(
    String id,
    double amount,
    String cat,
    String status,
    DateTime ts, {
    String merchant = 'M',
    String? vpa,
    String? desc,
    String? ref,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            amount: amount,
            category: cat,
            paymentTimestamp: ts,
            paymentStatus: Value(status),
            merchantName: Value(merchant),
            merchantVpa: Value(vpa),
            description: Value(desc),
            transactionReference: Value(ref),
          ),
        );
  }

  await add(
    'a',
    100,
    'food',
    'successful',
    DateTime(2026, 9, 27, 10),
    merchant: 'Cafe',
    vpa: 'cafe@upi',
    ref: 'R1',
  );
  await add(
    'b',
    200,
    'petrol',
    'successful',
    DateTime(2026, 9, 20, 9),
    merchant: 'Shell',
  );
  await add(
    'c',
    999,
    'food',
    'pending',
    DateTime(2026, 9, 27, 11),
    merchant: 'Cafe',
  );
  await add(
    'd',
    999,
    'food',
    'failed',
    DateTime(2026, 9, 27, 12),
    merchant: 'Cafe',
  );
  await add(
    'e',
    999,
    'food',
    'cancelled',
    DateTime(2026, 9, 27, 13),
    merchant: 'Cafe',
  );
  await add(
    'f',
    50,
    'home',
    'successful',
    DateTime(2026, 8, 5, 9),
    merchant: 'Power',
    desc: 'bill',
  );
}

void main() {
  late AppDb db;
  setUp(() async {
    db = openTestDb();
    await seedDb(db);
  });
  tearDown(() => db.close());

  test('confirmedTotal excludes pending/failed/cancelled', () async {
    expect(await db.confirmedTotal(), 350);
    expect(await db.confirmedTotal(from: DateTime(2026, 9, 1)), 300);
  });

  test('daoCategoryTotals groups confirmed rows only', () async {
    final m = await db.daoCategoryTotals();
    expect(m, {'food': 100, 'petrol': 200, 'home': 50});
  });

  test('searchTransactions matches merchant/vpa/desc/ref/category', () async {
    expect((await db.searchTransactions('Caf')).length, 4);
    expect((await db.searchTransactions('cafe@upi')).single.id, 'a');
    expect((await db.searchTransactions('bill')).single.id, 'f');
    expect((await db.searchTransactions('R1')).single.id, 'a');
    expect((await db.searchTransactions('petrol')).single.id, 'b');
  });

  test('pagedTransactions orders newest-first with limit/offset', () async {
    final p1 = await db.pagedTransactions(limit: 2);
    final p2 = await db.pagedTransactions(limit: 2, offset: 2);
    expect(p1.length, 2);
    expect(p1.first.paymentTimestamp.isAfter(p1.last.paymentTimestamp), isTrue);
    expect(p2.length, 2);
    expect(
      p1.map((t) => t.id).toSet().intersection(p2.map((t) => t.id).toSet()),
      isEmpty,
    );
  });

  test('§54 indexes exist', () async {
    final rows = await db
        .customSelect('SELECT name FROM sqlite_master WHERE type=\'index\'')
        .get();
    final names = rows.map((r) => r.data['name'] as String).toSet();
    for (final i in [
      'idx_tx_time',
      'idx_tx_cat',
      'idx_tx_merchant',
      'idx_tx_status',
      'idx_sav_date',
      'idx_rep_my',
    ]) {
      expect(names, contains(i));
    }
  });
}
