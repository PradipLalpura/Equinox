import 'package:equinox/domain/models.dart';
import 'package:equinox/domain/reports/report.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('September seed report matches dashboard (§58)', () {
    final r = buildReport(seedTx, seedSavings, 5000, 2026, 9);
    expect(r.total, 8420);
    expect(r.count, 9);
    expect(r.avg, 8420 / 9);
    expect(r.largest!.merchant, 'Shell Ranip');
    expect(r.largest!.amount, 2000);
    expect(r.saved, 3580);
    final food = r.categories.firstWhere((c) => c.category == Category.food);
    expect(food.total, 3240);
    expect(food.count, 5);
    expect(food.pct, closeTo(3240 / 8420, 0.0001));
  });

  test('daily + weekly buckets tile the month', () {
    final r = buildReport(seedTx, seedSavings, 5000, 2026, 9);
    expect(r.daily.length, 30);
    expect(r.daily[26], 450); // Sep 27
    expect(r.daily.reduce((a, b) => a + b), 8420);
    // W1: 1–7 → 960 · W2: 8–14 → 940+1280+1090 · W3: 15–21 → 2000
    // W4: 22–28 → 700+680+320+450 · W5: 29–30 → 0
    expect(r.weeks, [960, 3310, 2000, 2150, 0]);
  });

  test('merchants ranked by spend with counts', () {
    final r = buildReport(seedTx, seedSavings, 5000, 2026, 9);
    expect(r.merchants.first.merchant, 'Shell Ranip');
    expect(r.merchants.first.total, 2000);
    expect(r.merchants.length, 5);
    final honest = r.merchants.firstWhere(
      (m) => m.merchant == 'Honest Restaurant',
    );
    expect(honest.total, 1090);
    expect(honest.count, 1);
    expect(r.largestN.length, 5);
    expect(r.largestN.first.amount, 2000);
  });

  test('month comparison looks back exactly one month', () {
    final r = buildReport(seedTx, seedSavings, 5000, 2026, 9);
    expect(r.prevTotal, 9300);
    expect(r.prevCount, 8);
    expect(r.prevSaved, 0);
    final aug = buildReport(seedTx, seedSavings, 5000, 2026, 8);
    expect(aug.prevTotal, 7140); // July
  });

  test('empty month is all zeros, leap February has 29 days', () {
    final r = buildReport(const [], const [], 5000, 2020, 2);
    expect(r.total, 0);
    expect(r.count, 0);
    expect(r.avg, 0);
    expect(r.largest, isNull);
    expect(r.merchants, isEmpty);
    expect(r.largestN, isEmpty);
    expect(r.daily.length, 29);
    expect(r.weeks, [0, 0, 0, 0, 0]);
    expect(r.prevTotal, 0);
  });

  test('5th week captures days 29–31', () {
    final txs = [
      Tx(
        id: 'x',
        amount: 111,
        category: Category.home,
        merchant: 'M',
        status: PayStatus.successful,
        time: DateTime(2026, 8, 31, 10),
      ),
    ];
    final r = buildReport(txs, const [], 5000, 2026, 8);
    expect(r.daily.length, 31);
    expect(r.weeks[4], 111);
    expect(r.weeks.sublist(0, 4), [0, 0, 0, 0]);
  });

  test('non-confirmed rows never enter reports', () {
    final txs = [
      Tx(
        id: 'p',
        amount: 9999,
        category: Category.food,
        merchant: 'M',
        status: PayStatus.pending,
        time: DateTime(2026, 9, 10),
      ),
      Tx(
        id: 'f',
        amount: 9999,
        category: Category.food,
        merchant: 'M',
        status: PayStatus.failed,
        time: DateTime(2026, 9, 11),
      ),
      Tx(
        id: 'c',
        amount: 9999,
        category: Category.food,
        merchant: 'M',
        status: PayStatus.cancelled,
        time: DateTime(2026, 9, 12),
      ),
      Tx(
        id: 'u',
        amount: 9999,
        category: Category.food,
        merchant: 'M',
        status: PayStatus.unknown,
        time: DateTime(2026, 9, 13),
      ),
    ];
    final r = buildReport(txs, const [], 5000, 2026, 9);
    expect(r.total, 0);
    expect(r.count, 0);
    expect(r.daily.reduce((a, b) => a + b), 0);
    expect(r.merchants, isEmpty);
    expect(r.weeks, [0, 0, 0, 0, 0]);
  });

  test('reportMonths derives archive, newest first, with live month', () {
    final months = reportMonths(seedTx, seedSavings, DateTime(2026, 9, 27));
    expect(months, [DateTime(2026, 9), DateTime(2026, 8), DateTime(2026, 7)]);
  });
}
