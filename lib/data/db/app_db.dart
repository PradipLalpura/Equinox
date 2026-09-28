import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_db.g.dart';

// Local-only SQLite via Drift (§6). Tables mirror spec; indexes per §54.
// Codegen: `dart run build_runner build --delete-conflicting-outputs`.

class Transactions extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  TextColumn get category => text()(); // Category.name, exactly 5 (§17)
  TextColumn get description => text().nullable()();
  TextColumn get merchantName => text().withDefault(const Constant(''))();
  TextColumn get merchantVpa => text().nullable()();
  TextColumn get merchantCode => text().nullable()();
  TextColumn get transactionReference => text().nullable()();
  TextColumn get transactionNote => text().nullable()();
  TextColumn get qrRawData => text().nullable()();
  TextColumn get upiApp => text().nullable()();
  TextColumn get paymentStatus => text().withDefault(const Constant('draft'))();
  DateTimeColumn get paymentTimestamp => dateTime()();
  TextColumn get timezone => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get locationAccuracy => real().nullable()();
  TextColumn get locationLabel => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class PaymentAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get transactionId => text().references(Transactions, #id)();
  TextColumn get upiApp => text()();
  DateTimeColumn get launchedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get returnedAt => dateTime().nullable()();
  TextColumn get callbackStatus => text().nullable()();
  TextColumn get responseCode => text().nullable()();
  TextColumn get externalTransactionId => text().nullable()();
  TextColumn get rawResponse => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class Savings extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  TextColumn get goalId => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get savingDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class SavingsGoals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get targetAmount => real()();
  RealColumn get currentAmount => real().withDefault(const Constant(0))();
  DateTimeColumn get targetDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class MonthlyReports extends Table {
  TextColumn get id => text()();
  IntColumn get reportMonth => integer()();
  IntColumn get reportYear => integer()();
  RealColumn get totalSpending => real().withDefault(const Constant(0))();
  RealColumn get totalSavings => real().withDefault(const Constant(0))();
  IntColumn get transactionCount => integer().withDefault(const Constant(0))();
  TextColumn get reportData => text().withDefault(const Constant('{}'))();
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get preferredUpiApp => text().nullable()();
  RealColumn get monthlySavingsTarget =>
      real().withDefault(const Constant(5000))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get locationEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Transactions,
    PaymentAttempts,
    Savings,
    SavingsGoals,
    MonthlyReports,
    AppSettings,
  ],
)
class AppDb extends _$AppDb {
  AppDb() : super(driftDatabase(name: 'equinox'));
  AppDb.forTesting(super.executor);
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Indexes (§54). ponytail: raw SQL, one place, no extra DAO files yet.
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_tx_time ON transactions (payment_timestamp)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_tx_cat ON transactions (category)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_tx_merchant ON transactions (merchant_name)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_tx_status ON transactions (payment_status)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_sav_date ON savings (saving_date)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_rep_my ON monthly_reports (report_month, report_year)',
      );
    },
    onUpgrade: (m, from, to) async {
      // Safe forward migrations only; Phase 6 adds recovery paths.
      await m.createAll();
    },
  );

  // Confirmed-spending query (§53): SUCCESSFUL only. Used from Phase 2 on.
  Future<double> confirmedTotal({DateTime? from, DateTime? to}) async {
    final sum = transactions.amount.sum();
    final q = selectOnly(transactions)
      ..addColumns([sum])
      ..where(transactions.paymentStatus.equals('successful'));
    if (from != null) {
      q.where(transactions.paymentTimestamp.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      q.where(transactions.paymentTimestamp.isSmallerOrEqualValue(to));
    }
    return (await q.getSingle()).read(sum) ?? 0;
  }

  // Phase 2 query surface (§25–28, §53–54). UI binds to these in Phase 3
  // once user-created rows exist; db_test.dart proves them against real SQLite.
  Future<List<Transaction>> pagedTransactions({
    DateTime? from,
    DateTime? to,
    String? category,
    int limit = 50,
    int offset = 0,
  }) {
    final q = select(transactions)
      ..orderBy([(t) => OrderingTerm.desc(t.paymentTimestamp)])
      ..limit(limit, offset: offset);
    if (from != null) {
      q.where((t) => t.paymentTimestamp.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      q.where((t) => t.paymentTimestamp.isSmallerOrEqualValue(to));
    }
    if (category != null) {
      q.where((t) => t.category.equals(category));
    }
    return q.get();
  }

  Future<List<Transaction>> searchTransactions(String query) {
    final like = '%$query%';
    return (select(transactions)
          ..where(
            (t) =>
                t.merchantName.like(like) |
                t.merchantVpa.like(like) |
                t.description.like(like) |
                t.transactionReference.like(like) |
                t.category.like(like),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.paymentTimestamp)])
          ..limit(100))
        .get();
  }

  Future<Map<String, double>> daoCategoryTotals({
    DateTime? from,
    DateTime? to,
  }) async {
    final sum = transactions.amount.sum();
    final q = selectOnly(transactions)
      ..addColumns([transactions.category, sum])
      ..where(transactions.paymentStatus.equals('successful'))
      ..groupBy([transactions.category]);
    if (from != null) {
      q.where(transactions.paymentTimestamp.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      q.where(transactions.paymentTimestamp.isSmallerOrEqualValue(to));
    }
    final rows = await q.get();
    return {
      for (final r in rows) r.read(transactions.category)!: r.read(sum) ?? 0,
    };
  }
}
