import '../models.dart';
import '../../application/providers.dart'
    show confirmed, confirmedCount, avgTx, categoryTotals, savedInMonth;

// Monthly report model (§32). Built live from transactions + savings every
// time it is viewed or exported — never snapshotted, so it can never go
// stale, needs no background worker, and trivially survives reboot/upgrade.
// ponytail: a WorkManager monthly trigger would add manifest receivers, Doze
// exemptions and snapshot-sync bugs for zero user-visible gain at this scale
// (even 10k rows aggregate in milliseconds). Revisit when reports must exist
// for months whose source rows were deleted.

class CategorySlice {
  final Category category;
  final double total;
  final int count;
  final double pct; // of month total
  const CategorySlice(this.category, this.total, this.count, this.pct);
}

class MerchantStat {
  final String merchant;
  final double total;
  final int count;
  const MerchantStat(this.merchant, this.total, this.count);
}

class MonthlyReport {
  final int year, month;
  final double total;
  final int count;
  final double avg;
  final Tx? largest;
  final List<CategorySlice> categories;
  final List<double> daily; // per calendar day, len = days in month
  final List<double> weeks; // W1..W5 (days 1–7, 8–14, 15–21, 22–28, 29–31)
  final List<Tx> largestN; // top 5 confirmed
  final List<MerchantStat> merchants; // top 5 by spend
  final double saved;
  final double target;
  final double prevTotal, prevSaved;
  final int prevCount;
  const MonthlyReport({
    required this.year, required this.month, required this.total,
    required this.count, required this.avg, required this.largest,
    required this.categories, required this.daily, required this.weeks,
    required this.largestN, required this.merchants, required this.saved,
    required this.target, required this.prevTotal, required this.prevSaved,
    required this.prevCount,
  });
}

MonthlyReport buildReport(
    List<Tx> txs, List<SavingEntry> savings, double target, int year, int month) {
  final from = DateTime(year, month);
  final to = DateTime(year, month + 1).subtract(const Duration(seconds: 1));
  bool inMonth(Tx t) =>
      t.status.isConfirmed && !t.time.isBefore(from) && !t.time.isAfter(to);
  final rows = txs.where(inMonth).toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));

  final total = confirmed(txs, from: from, to: to);
  final count = confirmedCount(txs, from: from, to: to);
  final totals = categoryTotals(txs, from: from, to: to);
  final counts = <Category, int>{for (final c in Category.values) c: 0};
  for (final t in rows) {
    counts[t.category] = counts[t.category]! + 1;
  }

  final days = to.day;
  final daily = List.filled(days, 0.0);
  for (final t in rows) {
    daily[t.time.day - 1] += t.amount;
  }
  final weeks = List.filled(5, 0.0);
  for (var d = 1; d <= days; d++) {
    final w = ((d - 1) ~/ 7).clamp(0, 4);
    weeks[w] += daily[d - 1];
  }

  final byMerchant = <String, List<Tx>>{};
  for (final t in rows) {
    (byMerchant[t.merchant] ??= []).add(t);
  }
  final merchants = byMerchant.entries
      .map((e) => MerchantStat(e.key,
          e.value.fold(0.0, (a, t) => a + t.amount), e.value.length))
      .toList()
    ..sort((a, b) => b.total.compareTo(a.total));

  final prev = DateTime(year, month - 1);
  return MonthlyReport(
    year: year,
    month: month,
    total: total,
    count: count,
    avg: avgTx(txs, from: from, to: to),
    largest: rows.isEmpty ? null : rows.first,
    categories: [
      for (final c in Category.values)
        CategorySlice(c, totals[c]!, counts[c]!,
            total <= 0 ? 0 : totals[c]! / total),
    ],
    daily: daily,
    weeks: weeks,
    largestN: rows.take(5).toList(),
    merchants: merchants.take(5).toList(),
    saved: savedInMonth(savings, from),
    target: target,
    prevTotal: confirmed(txs,
        from: DateTime(prev.year, prev.month),
        to: DateTime(prev.year, prev.month + 1)
            .subtract(const Duration(seconds: 1))),
    prevSaved: savedInMonth(savings, prev),
    prevCount: confirmedCount(txs,
        from: DateTime(prev.year, prev.month),
        to: DateTime(prev.year, prev.month + 1)
            .subtract(const Duration(seconds: 1))),
  );
}

/// Months that have any activity, newest first, plus the current month
/// (LIVE) so the archive is complete without any generation step.
List<DateTime> reportMonths(
    List<Tx> txs, List<SavingEntry> savings, DateTime now) {
  final set = <String, DateTime>{};
  void add(DateTime d) =>
      set.putIfAbsent('${d.year}-${d.month}', () => DateTime(d.year, d.month));
  for (final t in txs) {
    add(t.time);
  }
  for (final s in savings) {
    add(s.date);
  }
  add(DateTime(now.year, now.month));
  final out = set.values.toList()
    ..sort((a, b) => b.compareTo(a));
  return out;
}
