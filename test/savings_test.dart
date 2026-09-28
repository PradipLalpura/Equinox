import 'package:equinox/application/providers.dart';
import 'package:equinox/domain/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sept = DateTime(2026, 9, 15);
  final septSavings = [
    SavingEntry(id: 'a', amount: 2000, date: DateTime(2026, 9, 5)),
    SavingEntry(id: 'b', amount: 1580, goalId: 'g1', date: DateTime(2026, 9, 18)),
    SavingEntry(id: 'c', amount: 500, date: DateTime(2026, 8, 30)),
  ];

  test('savedInMonth sums explicit contributions in-month only (§9–10)', () {
    expect(savedInMonth(septSavings, sept), 3580);
    expect(savedInMonth(septSavings, DateTime(2026, 8, 1)), 500);
    expect(savedInMonth(const [], sept), 0);
  });

  test('§9 dashboard math: 3580/5000 = 71.6%, 1420 left', () {
    const saved = 3580.0, target = 5000.0;
    expect(saved / target, closeTo(0.716, 0.0005));
    expect(target - saved, 1420);
  });

  test('goal progress clamps, remaining floors at zero (§11)', () {
    const g = SavingGoal(id: 'g', name: 'Laptop', target: 80000, current: 32000);
    expect(g.progress, 0.4);
    expect(g.remaining, 48000);
    const over = SavingGoal(id: 'o', name: 'X', target: 100, current: 150);
    expect(over.progress, 1.0);
    expect(over.remaining, 0);
    const zero = SavingGoal(id: 'z', name: 'X', target: 0);
    expect(zero.progress, 0);
  });

  test('analytics aggregations ignore non-confirmed rows', () {
    final big = largestTx(seedTx)!;
    expect(big.amount, 2400); // D-Mart, August
    expect(confirmedCount(seedTx), 23);
    expect(avgTx(seedTx), 24860 / 23);
    final top = topCategory(seedTx)!;
    expect(top.key, Category.food);
    expect(top.value, 3240 + 1200 + 650 + 980 + 1000);
    expect(topCategory(const []), isNull);
    expect(largestTx(const []), isNull);
  });

  test('avgDaily divides month total by calendar days', () {
    expect(avgDaily(seedTx, DateTime(2026, 9, 1)), 8420 / 30);
    expect(avgDaily(seedTx, DateTime(2026, 2, 1)), 0);
  });

  test('weeklyCounts aligns Mon..Sun with weeklyBuckets', () {
    final now = DateTime(2026, 9, 27, 12);
    final sums = weeklyBuckets(seedTx, now);
    final counts = weeklyCounts(seedTx, now);
    expect(sums.reduce((a, b) => a + b), 2150);
    expect(counts.reduce((a, b) => a + b), 4); // confirmed only
    expect(counts[6], 1); // Sun: 450 (pending 350 excluded)
    expect(counts[5], 1); // Sat: 320 (cancelled 1200 excluded)
  });

  test('monthLabel + DateTime stepping cross year boundaries', () {
    expect(monthLabel(DateTime(2026, 9, 1)), 'September 2026');
    expect(monthLabel(DateTime(2026, 1, 1)), 'January 2026');
    expect(DateTime(2026, 1, 15).month - 1, 0); // sanity
    expect(DateTime(2026, 1, 1).subtract(const Duration(days: 1)).month, 12);
  });
}
