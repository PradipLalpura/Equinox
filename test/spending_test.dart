// Spending-math unit tests (§53): confirmed = SUCCESSFUL only.
import 'package:equinox/application/providers.dart';
import 'package:equinox/domain/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Clock anchor matching the seed's "today".
  final now = DateTime(2026, 9, 27, 12);

  test('seed totals match §58', () {
    expect(confirmed(seedTx), 24860);
    expect(confirmed(seedTx, from: monthStart(now), to: monthEnd(now)), 8420);
    expect(confirmed(seedTx, from: weekStart(now), to: weekEnd(now)), 2150);
  });

  test('pending/failed/cancelled never count', () {
    final bad = seedTx.where((t) => !t.status.isConfirmed).toList();
    expect(bad, isNotEmpty);
    expect(confirmed(bad), 0);
  });

  test('category totals match §58 September split', () {
    final m = categoryTotals(seedTx, from: monthStart(now), to: monthEnd(now));
    expect(m[Category.food], 3240);
    expect(m[Category.petrol], 2000);
    expect(m[Category.personal], 1280);
    expect(m[Category.college], 940);
    expect(m[Category.home], 960);
  });

  test('weekly buckets cover Mon..Sun and sum to week total', () {
    final b = weeklyBuckets(seedTx, now);
    expect(b.length, 7);
    expect(b.reduce((a, x) => a + x), 2150);
    expect(b[6], 450); // Sunday Sep 27
    expect(b[5], 320); // Saturday Sep 26
  });

  test('filterTx searches merchant, UPI ID, note, reference, category', () {
    expect(
      filterTx(seedTx, now, query: 'shell').length,
      greaterThanOrEqualTo(3),
    );
    expect(filterTx(seedTx, now, query: 'shreekrishna@upi').length, 3);
    expect(
      filterTx(seedTx, now, query: 'notebook').single.merchant,
      'College Bookstore',
    );
    expect(filterTx(seedTx, now, query: 'UPI-20260927-01').single.amount, 450);
    expect(
      filterTx(
        seedTx,
        now,
        query: 'petrol',
      ).every((t) => t.category == Category.petrol),
      isTrue,
    );
  });

  test('filterTx date + category filters compose', () {
    final septFood = filterTx(
      seedTx,
      now,
      category: Category.food,
      date: DateFilter.month,
    );
    expect(septFood.length, 6); // 5 successful + 1 pending (history shows both)
    final week = filterTx(seedTx, now, date: DateFilter.week);
    expect(week.length, 7); // 4 successful + pending + cancelled + failed
    final custom = filterTx(
      seedTx,
      now,
      date: DateFilter.custom,
      custom: (DateTime(2026, 8, 1), DateTime(2026, 8, 31, 23, 59)),
    );
    expect(custom.length, 8);
  });
}
