import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../domain/models.dart';
import '../domain/upi/upi.dart';
import 'db/app_db.dart';

// Write path for user transactions (Phase 3). One seam: UI talks to
// TxStore, never to Drift directly. Reads stay reactive via watchAll().
// ponytail: global lazy singletons, no DI framework — one app, one DB.
class TxStore {
  final AppDb db;
  TxStore(this.db);

  Stream<List<Tx>> watchAll() =>
      (db.select(db.transactions)
            ..orderBy([(t) => OrderingTerm.desc(t.paymentTimestamp)]))
          .watch()
          .map((rows) => rows.map(_toTx).toList());

  Future<List<Tx>> awaitingReturn() async {
    final rows =
        await (db.select(db.transactions)
              ..where((t) => t.paymentStatus.equals(PayStatus.initiated.name))
              ..orderBy([(t) => OrderingTerm.desc(t.paymentTimestamp)])
              ..limit(1))
            .get();
    return rows.map(_toTx).toList();
  }

  Tx _toTx(Transaction r) => Tx(
    id: r.id,
    amount: r.amount,
    category: CategoryX.fromName(r.category),
    merchant: r.merchantName.isEmpty
        ? (r.merchantVpa ?? 'Unknown merchant')
        : r.merchantName,
    description: r.description,
    status: PayStatusX.fromName(r.paymentStatus),
    time: r.paymentTimestamp,
    upiId: r.merchantVpa,
    upiApp: r.upiApp,
    locationLabel: r.locationLabel,
    reference: r.transactionReference,
  );

  /// Persists the payment as INITIATED *before* leaving Equinox (§23).
  Future<String> createInitiated({
    required UpiPayload payload,
    required double amount,
    required Category category,
    String? description,
    String? upiApp,
    FixCoords? fix,
  }) async {
    final id = const Uuid().v4();
    final now = DateTime.now();
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            amount: amount,
            category: category.name,
            paymentTimestamp: now,
            paymentStatus: const Value('initiated'),
            currency: const Value('INR'),
            description: Value(description),
            merchantName: Value(payload.payeeName ?? payload.vpa),
            merchantVpa: Value(payload.vpa),
            merchantCode: Value(payload.merchantCode),
            transactionReference: Value(payload.reference),
            transactionNote: Value(description ?? payload.note),
            qrRawData: Value(payload.raw),
            upiApp: Value(upiApp),
            timezone: Value(now.timeZoneName),
            latitude: Value(fix?.lat),
            longitude: Value(fix?.lng),
            locationAccuracy: Value(fix?.accuracy),
          ),
        );
    return id;
  }

  Future<String> recordLaunch({
    required String txId,
    required String app,
  }) async {
    final id = const Uuid().v4();
    await db
        .into(db.paymentAttempts)
        .insert(
          PaymentAttemptsCompanion.insert(
            id: id,
            transactionId: txId,
            upiApp: app,
          ),
        );
    return id;
  }

  /// Latest attempt for a tx (pending inbox needs it to reconcile).
  Future<String?> attemptFor(String txId) async {
    final row =
        await (db.select(db.paymentAttempts)
              ..where((t) => t.transactionId.equals(txId))
              ..orderBy([(t) => OrderingTerm.desc(t.launchedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row?.id;
  }

  /// Explicit wipe (§46). Sets the seed flag so demo data never comes back.
  Future<void> wipeAll({Future<void> Function()? markSeeded}) async {
    await db.transaction(() async {
      await db.delete(db.paymentAttempts).go();
      await db.delete(db.monthlyReports).go();
      await db.delete(db.savings).go();
      await db.delete(db.savingsGoals).go();
      await db.delete(db.transactions).go();
      await db.delete(db.appSettings).go();
    });
    await (markSeeded ?? _secureMarkSeeded)();
  }

  /// Explicit user reconcile — the ONLY path out of initiated/pending/unknown.
  Future<void> reconcile({
    required String txId,
    required String attemptId,
    required PayStatus to,
  }) async {
    final row = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals(txId))).getSingle();
    final from = PayStatusX.fromName(row.paymentStatus);
    if (!canTransition(from, to)) {
      throw StateError('Illegal transition ${from.name} → ${to.name}');
    }
    final now = DateTime.now();
    await db.transaction(() async {
      await (db.update(db.transactions)..where((t) => t.id.equals(txId))).write(
        TransactionsCompanion(
          paymentStatus: Value(to.name),
          updatedAt: Value(now),
        ),
      );
      await (db.update(
        db.paymentAttempts,
      )..where((t) => t.id.equals(attemptId))).write(
        PaymentAttemptsCompanion(
          returnedAt: Value(now),
          callbackStatus: Value(to.name),
        ),
      );
    });
  }

  // --- Savings (§9–13): explicit contributions only, never inferred ---

  Stream<List<SavingEntry>> watchSavings() =>
      (db.select(
        db.savings,
      )..orderBy([(t) => OrderingTerm.desc(t.savingDate)])).watch().map(
        (rows) => rows
            .map(
              (r) => SavingEntry(
                id: r.id,
                amount: r.amount,
                goalId: r.goalId,
                description: r.description,
                date: r.savingDate,
              ),
            )
            .toList(),
      );

  Stream<List<SavingGoal>> watchGoals() =>
      (db.select(
        db.savingsGoals,
      )..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch().map(
        (rows) => rows
            .map(
              (r) => SavingGoal(
                id: r.id,
                name: r.name,
                target: r.targetAmount,
                current: r.currentAmount,
                targetDate: r.targetDate,
                status: GoalStatusX.fromName(r.status),
              ),
            )
            .toList(),
      );

  Stream<double> watchTarget() =>
      (db.select(db.appSettings)
            ..where((t) => t.id.equals(1))
            ..limit(1))
          .watchSingleOrNull()
          .map((r) => r?.monthlySavingsTarget ?? 5000);

  Future<void> setTarget(double v) async {
    if (v < 0) throw ArgumentError('target must be >= 0');
    final existing = await (db.select(
      db.appSettings,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (existing == null) {
      await db
          .into(db.appSettings)
          .insert(AppSettingsCompanion.insert(monthlySavingsTarget: Value(v)));
    } else {
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        AppSettingsCompanion(
          monthlySavingsTarget: Value(v),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<String> addSaving({
    required double amount,
    String? goalId,
    String? description,
    DateTime? date,
  }) async {
    if (amount <= 0) throw ArgumentError('amount must be > 0');
    final id = const Uuid().v4();
    final now = DateTime.now();
    await db
        .into(db.savings)
        .insert(
          SavingsCompanion.insert(
            id: id,
            amount: amount,
            savingDate: date ?? now,
            goalId: Value(goalId),
            description: Value(description),
          ),
        );
    return id;
  }

  Future<String> addGoal({
    required String name,
    required double target,
    DateTime? targetDate,
  }) async {
    final n = name.trim();
    if (n.isEmpty) throw ArgumentError('name required');
    if (target <= 0) throw ArgumentError('target must be > 0');
    final id = const Uuid().v4();
    await db
        .into(db.savingsGoals)
        .insert(
          SavingsGoalsCompanion.insert(
            id: id,
            name: n,
            targetAmount: target,
            targetDate: Value(targetDate),
          ),
        );
    return id;
  }

  Future<void> updateGoal({
    required String id,
    String? name,
    double? target,
    DateTime? targetDate,
  }) async {
    if (name != null && name.trim().isEmpty) {
      throw ArgumentError('name required');
    }
    if (target != null && target <= 0) {
      throw ArgumentError('target must be > 0');
    }
    await (db.update(db.savingsGoals)..where((t) => t.id.equals(id))).write(
      SavingsGoalsCompanion(
        name: name == null ? const Value.absent() : Value(name.trim()),
        targetAmount: target == null ? const Value.absent() : Value(target),
        targetDate: Value(targetDate),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Contribution = savings row + goal bump, atomically. The ONLY writer of
  /// currentAmount — it can never drift from explicit contributions.
  Future<void> contribute({
    required String goalId,
    required double amount,
    String? description,
    DateTime? date,
  }) async {
    if (amount <= 0) throw ArgumentError('amount must be > 0');
    final goal = await (db.select(
      db.savingsGoals,
    )..where((t) => t.id.equals(goalId))).getSingleOrNull();
    if (goal == null) throw StateError('goal not found');
    if (goal.status != GoalStatus.active.name) {
      throw StateError('goal is not active');
    }
    final now = DateTime.now();
    await db.transaction(() async {
      await db
          .into(db.savings)
          .insert(
            SavingsCompanion.insert(
              id: const Uuid().v4(),
              amount: amount,
              savingDate: date ?? now,
              goalId: Value(goalId),
              description: Value(description),
            ),
          );
      await (db.update(
        db.savingsGoals,
      )..where((t) => t.id.equals(goalId))).write(
        SavingsGoalsCompanion(
          currentAmount: Value(goal.currentAmount + amount),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> setGoalStatus({
    required String id,
    required GoalStatus status,
  }) async {
    await (db.update(db.savingsGoals)..where((t) => t.id.equals(id))).write(
      SavingsGoalsCompanion(
        status: Value(status.name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete keeps history: linked savings rows become General (goalId null).
  Future<void> deleteGoal(String id) async {
    await db.transaction(() async {
      await (db.update(db.savings)..where((t) => t.goalId.equals(id))).write(
        const SavingsCompanion(goalId: Value(null)),
      );
      await (db.delete(db.savingsGoals)..where((t) => t.id.equals(id))).go();
    });
  }

  /// First-run seed so Phase 1–2 numbers survive the DB swap unchanged.
  /// Guarded by a secure-storage flag (NOT row count) so DELETE ALL DATA
  /// stays deleted. The gate is injectable so unit tests (no platform
  /// channels) can prove the no-reseed behavior with an in-memory flag.
  static const _seedKey = 'equinox_seeded_v1';

  static Future<bool> _secureSeeded() async {
    try {
      return await const FlutterSecureStorage().read(key: _seedKey) != null;
    } catch (_) {
      return false; // unit tests: flag unavailable → treat as unseeded
    }
  }

  static Future<void> _secureMarkSeeded() async {
    try {
      await const FlutterSecureStorage().write(key: _seedKey, value: '1');
    } catch (_) {
      // unit tests: nowhere to persist — caller injects its own gate.
    }
  }

  Future<void> seedOnce({
    Future<bool> Function()? isSeeded,
    Future<void> Function()? markSeeded,
  }) async {
    isSeeded ??= _secureSeeded;
    markSeeded ??= _secureMarkSeeded;
    if (await isSeeded()) return;
    final n = await db
        .customSelect('SELECT COUNT(*) AS c FROM transactions')
        .getSingle();
    if ((n.data['c'] as int) > 0) {
      await markSeeded();
      return;
    }
    final now = DateTime.now();
    for (final t in seedTx) {
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: t.id,
              amount: t.amount,
              category: t.category.name,
              paymentTimestamp: t.time,
              paymentStatus: Value(t.status.name),
              description: Value(t.description),
              merchantName: Value(t.merchant),
              merchantVpa: Value(t.upiId),
              upiApp: Value(t.upiApp),
              locationLabel: Value(t.locationLabel),
              transactionReference: Value(t.reference),
              timezone: Value(now.timeZoneName),
            ),
          );
    }
    for (final s in seedSavings) {
      await db
          .into(db.savings)
          .insert(
            SavingsCompanion.insert(
              id: s.id,
              amount: s.amount,
              savingDate: s.date,
              description: Value(s.description),
            ),
          );
    }
    await markSeeded();
  }
}

/// Minimal coords carrier so the store doesn't import geolocator.
class FixCoords {
  final double lat, lng, accuracy;
  const FixCoords(this.lat, this.lng, this.accuracy);
}

AppDb? _db;
AppDb get appDb => _db ??= AppDb();
TxStore? _store;
TxStore get txStore => _store ??= TxStore(appDb);
