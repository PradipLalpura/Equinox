import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';

import 'db/app_db.dart';

// Local backup & restore (§44–45). Whole DB → one JSON string; transactions →
// CSV. Restore validates FIRST, then wipes + inserts atomically — a corrupt
// file can never half-wipe the database. Manual share only, never uploaded.
const backupVersion = 1;

Future<String> exportJson(AppDb db) async {
  final tx = await db.select(db.transactions).get();
  final att = await db.select(db.paymentAttempts).get();
  final sav = await db.select(db.savings).get();
  final goals = await db.select(db.savingsGoals).get();
  final reps = await db.select(db.monthlyReports).get();
  final set = await db.select(db.appSettings).get();
  return jsonEncode({
    'app': 'equinox',
    'version': backupVersion,
    'exportedAt': DateTime.now().toIso8601String(),
    'transactions': [for (final r in tx) r.toJson()],
    'paymentAttempts': [for (final r in att) r.toJson()],
    'savings': [for (final r in sav) r.toJson()],
    'savingsGoals': [for (final r in goals) r.toJson()],
    'monthlyReports': [for (final r in reps) r.toJson()],
    'appSettings': [for (final r in set) r.toJson()],
  });
}

Future<void> importJson(AppDb db, String raw) async {
  final m = jsonDecode(raw);
  if (m is! Map || m['app'] != 'equinox' || m['version'] != backupVersion) {
    throw const FormatException('Not an Equinox backup');
  }
  // Validate everything BEFORE touching the live tables.
  List<T> rows<T>(String key, T Function(Map<String, dynamic>) from) {
    final list = m[key];
    if (list is! List) throw FormatException('Bad section: $key');
    return [for (final e in list) from((e as Map).cast<String, dynamic>())];
  }

  final tx = rows('transactions', Transaction.fromJson);
  final att = rows('paymentAttempts', PaymentAttempt.fromJson);
  final sav = rows('savings', Saving.fromJson);
  final goals = rows('savingsGoals', SavingsGoal.fromJson);
  final reps = rows('monthlyReports', MonthlyReport.fromJson);
  final set = rows('appSettings', AppSetting.fromJson);

  await db.transaction(() async {
    await db.delete(db.paymentAttempts).go();
    await db.delete(db.monthlyReports).go();
    await db.delete(db.savings).go();
    await db.delete(db.savingsGoals).go();
    await db.delete(db.transactions).go();
    await db.delete(db.appSettings).go();
    for (final r in set) {
      await db.into(db.appSettings).insert(r.toCompanion(false));
    }
    for (final r in goals) {
      await db.into(db.savingsGoals).insert(r.toCompanion(false));
    }
    for (final r in tx) {
      await db.into(db.transactions).insert(r.toCompanion(false));
    }
    for (final r in att) {
      await db.into(db.paymentAttempts).insert(r.toCompanion(false));
    }
    for (final r in sav) {
      await db.into(db.savings).insert(r.toCompanion(false));
    }
    for (final r in reps) {
      await db.into(db.monthlyReports).insert(r.toCompanion(false));
    }
  });
}

Future<String> exportCsv(AppDb db) async {
  final tx = await (db.select(
    db.transactions,
  )..orderBy([(t) => OrderingTerm.desc(t.paymentTimestamp)])).get();
  return const CsvEncoder().convert([
    [
      'id',
      'amount',
      'currency',
      'category',
      'description',
      'merchant',
      'upi_id',
      'upi_app',
      'status',
      'timestamp',
      'reference',
    ],
    for (final r in tx)
      [
        r.id,
        r.amount,
        r.currency,
        r.category,
        r.description ?? '',
        r.merchantName,
        r.merchantVpa ?? '',
        r.upiApp ?? '',
        r.paymentStatus,
        r.paymentTimestamp.toIso8601String(),
        r.transactionReference ?? '',
      ],
  ]);
}
