import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/tx_store.dart';
import '../domain/models.dart';

// Phase 3: reads flow from Drift via TxStore (seeded once on first launch).
// Widgets use `.valueOrNull ?? const []` (+ LoadingState while waiting).

// --- Spending math (confirmed = SUCCESSFUL only, §53) ---

double confirmed(List<Tx> txs, {DateTime? from, DateTime? to}) => txs
    .where((t) => t.status.isConfirmed)
    .where((t) => (from == null || !t.time.isBefore(from)) && (to == null || !t.time.isAfter(to)))
    .fold(0, (a, t) => a + t.amount);

DateTime monthStart(DateTime n) => DateTime(n.year, n.month);
DateTime monthEnd(DateTime n) =>
    DateTime(n.year, n.month + 1).subtract(const Duration(seconds: 1));
DateTime weekStart(DateTime n) {
  final d = DateTime(n.year, n.month, n.day);
  return d.subtract(Duration(days: d.weekday - 1)); // Monday
}
DateTime weekEnd(DateTime n) =>
    weekStart(n).add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Per-category confirmed totals (insertion order = Category.values order).
Map<Category, double> categoryTotals(List<Tx> txs, {DateTime? from, DateTime? to}) {
  final m = {for (final c in Category.values) c: 0.0};
  for (final t in txs) {
    if (!t.status.isConfirmed) continue;
    if (from != null && t.time.isBefore(from)) continue;
    if (to != null && t.time.isAfter(to)) continue;
    m[t.category] = m[t.category]! + t.amount;
  }
  return m;
}

/// 7 confirmed-spending buckets, Monday..Sunday of [now]'s week.
List<double> weeklyBuckets(List<Tx> txs, DateTime now) {
  final mon = weekStart(now);
  final out = List.filled(7, 0.0);
  for (final t in txs) {
    if (!t.status.isConfirmed) continue;
    final d = DateTime(t.time.year, t.time.month, t.time.day).difference(mon).inDays;
    if (d >= 0 && d < 7) out[d] += t.amount;
  }
  return out;
}

// --- History filtering (§25–26) ---

enum DateFilter { all, today, week, month, custom }

/// Custom range as (start, end) record. Single-shot state, cleared on chip change.
final txListProvider = StreamProvider<List<Tx>>((_) => txStore.watchAll());
final savingsListProvider = Provider<List<SavingEntry>>((_) => seedSavings);
final savingsTargetProvider = Provider<double>((_) => 5000);

final searchQueryProvider = StateProvider<String>((_) => '');
final categoryFilterProvider = StateProvider<Category?>((_) => null);
final dateFilterProvider = StateProvider<DateFilter>((_) => DateFilter.all);
final customRangeProvider = StateProvider<(DateTime, DateTime)?>((_) => null);

List<Tx> filterTx(List<Tx> txs, DateTime now,
    {String query = '', Category? category, DateFilter date = DateFilter.all, (DateTime, DateTime)? custom}) {
  final q = query.trim().toLowerCase();
  return txs.where((t) {
    if (category != null && t.category != category) return false;
    switch (date) {
      case DateFilter.today:
        if (!isSameDay(t.time, now)) return false;
      case DateFilter.week:
        if (t.time.isBefore(weekStart(now)) || t.time.isAfter(weekEnd(now))) return false;
      case DateFilter.month:
        if (t.time.isBefore(monthStart(now)) || t.time.isAfter(monthEnd(now))) return false;
      case DateFilter.custom:
        if (custom == null) return false;
        if (t.time.isBefore(custom.$1) || t.time.isAfter(custom.$2)) return false;
      case DateFilter.all:
        break;
    }
    if (q.isEmpty) return true;
    return t.merchant.toLowerCase().contains(q) ||
        (t.description?.toLowerCase().contains(q) ?? false) ||
        (t.upiId?.toLowerCase().contains(q) ?? false) ||
        (t.reference?.toLowerCase().contains(q) ?? false) ||
        t.category.label.toLowerCase().contains(q);
  }).toList()
    ..sort((a, b) => b.time.compareTo(a.time));
}

List<Tx> _txs(Ref ref) => ref.watch(txListProvider).valueOrNull ?? const [];

final filteredTxProvider = Provider<List<Tx>>((ref) => filterTx(
      _txs(ref), DateTime.now(),
      query: ref.watch(searchQueryProvider),
      category: ref.watch(categoryFilterProvider),
      date: ref.watch(dateFilterProvider),
      custom: ref.watch(customRangeProvider),
    ));

/// Day-grouped entries, newest day first. Map preserves insertion order.
final groupedTxProvider = Provider<List<MapEntry<DateTime, List<Tx>>>>((ref) {
  final groups = <DateTime, List<Tx>>{};
  for (final t in ref.watch(filteredTxProvider)) {
    final day = DateTime(t.time.year, t.time.month, t.time.day);
    (groups[day] ??= []).add(t);
  }
  return groups.entries.toList();
});

// --- Dashboard sums (real clock) ---

final totalSpendingProvider =
    Provider<double>((ref) => confirmed(_txs(ref)));
final monthSpendingProvider = Provider<double>((ref) {
  final now = DateTime.now();
  return confirmed(_txs(ref), from: monthStart(now), to: monthEnd(now));
});
final weekSpendingProvider = Provider<double>((ref) {
  final now = DateTime.now();
  return confirmed(_txs(ref), from: weekStart(now), to: weekEnd(now));
});
final savedMonthProvider = Provider<double>(
    (ref) => ref.watch(savingsListProvider).fold(0, (a, s) => a + s.amount));

final onboardingDoneProvider = StateProvider<bool>((_) => false);
final navIndexProvider = StateProvider<int>((_) => 0);

/// Tx + attempt awaiting post-UPI-app reconcile. In-memory only: a process
/// death before return is recovered by the Phase 6 pending inbox.
final awaitingReturnProvider =
    StateProvider<({String txId, String attemptId})?>((_) => null);
