import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers.dart';
import '../core/format/inr.dart';
import '../core/widgets/ui.dart';
import '../data/tx_store.dart';
import '../domain/models.dart';
import 'pay.dart';
import 'reports.dart';
import 'savings.dart';
import 'settings.dart';

// Phase 1 shell: onboarding → 5-tab nav (Home/History/Scan/Analytics/Profile).
// Scan/Analytics/Profile are honest placeholders until Phases 3–4.

class EquinoxApp extends ConsumerWidget {
  const EquinoxApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = ref.watch(onboardingDoneProvider);
    return done ? const NavShell() : const OnboardingScreen();
  }
}

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'EQUINOX',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5B5CE2),
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your payments.\nRemembered.',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Scan once. Equinox remembers the details. Understand your spending. Build your savings. Your data stays on your phone.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'GET STARTED',
              onPressed: () =>
                  ref.read(onboardingDoneProvider.notifier).state = true,
            ),
          ],
        ),
      ),
    ),
  );
}

class NavShell extends ConsumerStatefulWidget {
  const NavShell({super.key});
  @override
  ConsumerState<NavShell> createState() => _NavShellState();
}

class _NavShellState extends ConsumerState<NavShell>
    with WidgetsBindingObserver {
  static const tabs = [
    HomeScreen(),
    HistoryScreen(),
    ScanScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];
  bool _reconciling = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _maybeReconcile();
  }

  /// External UPI apps return no result (§22): on return, ask explicitly.
  Future<void> _maybeReconcile() async {
    if (_reconciling || !mounted) return;
    final pending = ref.read(awaitingReturnProvider);
    if (pending == null) return;
    Tx? match;
    for (final t in await txStore.awaitingReturn()) {
      if (t.id == pending.txId) {
        match = t;
        break;
      }
    }
    if (match == null) {
      ref.read(awaitingReturnProvider.notifier).state = null;
      return;
    }
    _reconciling = true;
    if (mounted) {
      await showModalBottomSheet(
        context: context,
        builder: (_) => ReconcileSheet(
          txId: match!.id,
          attemptId: pending.attemptId,
          merchant: match.merchant,
          amount: match.amount,
        ),
      );
    }
    _reconciling = false;
  }

  @override
  Widget build(BuildContext context) {
    final i = ref.watch(navIndexProvider);
    return Scaffold(
      body: tabs[i],
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (v) {
          HapticFeedback.selectionClick();
          ref.read(navIndexProvider.notifier).state = v;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'HOME',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'HISTORY',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: 'SCAN',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'ANALYTICS',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalSpendingProvider);
    final month = ref.watch(monthSpendingProvider);
    final week = ref.watch(weekSpendingProvider);
    final saved = ref.watch(savedMonthProvider);
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    final now = TimeOfDay.now().hour;
    final greet = now < 12
        ? 'Good morning'
        : now < 17
        ? 'Good afternoon'
        : 'Good evening';
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'EQUINOX',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(letterSpacing: 3, fontWeight: FontWeight.w700),
          ),
          Text(greet, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          SpendingCard(title: 'TOTAL SPENDING', value: total),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SpendingCard(title: 'THIS MONTH', value: month),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SpendingCard(title: 'THIS WEEK', value: week),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SavingsScreen())),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SAVINGS',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'OPEN ›',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFF5B5CE2),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SavingsProgress(saved: saved, target: target),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORY BREAKDOWN',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  for (final e in categoryTotals(txs).entries)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(e.key.icon, color: const Color(0xFF5B5CE2)),
                      title: Text(e.key.label),
                      trailing: Text(
                        inr(e.value),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THIS WEEK',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  SpendingChart(buckets: weeklyBuckets(txs, DateTime.now())),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MONTHLY REPORT',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'September 2026',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '${inr(month)} spent · ${inr(saved)} saved',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'VIEW REPORT',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ReportsScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECENT TRANSACTIONS',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  for (final t in (List<Tx>.from(
                    txs,
                  )..sort((a, b) => b.time.compareTo(a.time))).take(4))
                    TransactionRow(t, onTap: () => showTxDetail(context, t)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupedTxProvider);
    final cat = ref.watch(categoryFilterProvider);
    final date = ref.watch(dateFilterProvider);
    final loading = ref.watch(txListProvider).isLoading;
    if (loading) {
      return const SafeArea(child: LoadingState());
    }
    if (ref.watch(txListProvider).valueOrNull?.isEmpty ?? true) {
      return SafeArea(
        child: Center(
          child: EmptyState(
            title: 'Your spending story starts here.',
            subtitle: 'Scan your first payment QR to automatically record an expense.',
            cta: 'SCAN YOUR FIRST QR',
            onCta: () => ref.read(navIndexProvider.notifier).state = 2,
          ),
        ),
      );
    }
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('HISTORY', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          SearchBar(
            hintText: 'Search merchant, UPI ID, note…',
            leading: const Icon(Icons.search),
            elevation: const WidgetStatePropertyAll(0),
            onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              EqFilterChip(
                label: 'All',
                selected: cat == null,
                onTap: () =>
                    ref.read(categoryFilterProvider.notifier).state = null,
              ),
              for (final c in Category.values)
                EqFilterChip(
                  label: c.label,
                  selected: cat == c,
                  onTap: () =>
                      ref.read(categoryFilterProvider.notifier).state = c,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final d in DateFilter.values)
                EqFilterChip(
                  label: _dateLabel(d),
                  selected: date == d,
                  onTap: () async {
                    if (d == DateFilter.custom) {
                      final r = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (r == null) return;
                      ref.read(customRangeProvider.notifier).state = (
                        r.start,
                        r.end,
                      );
                    }
                    ref.read(dateFilterProvider.notifier).state = d;
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (groups.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No transactions match. Try clearing search or filters.',
                ),
              ),
            )
          else
            for (final g in groups) ...[
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4, left: 4),
                child: Text(
                  _dayLabel(g.key),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              for (final t in g.value)
                Card(
                  child: TransactionRow(
                    t,
                    onTap: () => showTxDetail(context, t),
                  ),
                ),
            ],
        ],
      ),
    );
  }
}

String _dateLabel(DateFilter d) => switch (d) {
  DateFilter.all => 'All',
  DateFilter.today => 'Today',
  DateFilter.week => 'This Week',
  DateFilter.month => 'This Month',
  DateFilter.custom => 'Custom',
};

String _dayLabel(DateTime day) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  return '${day.day} ${_monthName(day.month)} ${day.year}';
}

String _monthName(int m) => const [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
][m];

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedMonthProvider);
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    final savings = ref.watch(savingsListProvider).valueOrNull ?? const [];
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final now = DateTime.now();
    final from = monthStart(month);
    final to = monthEnd(month);
    final mTotal = confirmed(txs, from: from, to: to);
    final count = confirmedCount(txs, from: from, to: to);
    final big = largestTx(
      txs.where((t) => !t.time.isBefore(from) && !t.time.isAfter(to)).toList(),
    );
    final top = topCategory(txs, from: from, to: to);
    final stats = categoryTotals(txs, from: from, to: to);
    final mSaved = savedInMonth(savings, month);

    void step(int delta) => ref.read(selectedMonthProvider.notifier).state =
        DateTime(month.year, month.month + delta);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('ANALYTICS', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    tooltip: 'Previous month',
                    onPressed: () => step(-1),
                  ),
                  Text(
                    monthLabel(month),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    tooltip: 'Next month',
                    onPressed: () => step(1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.6,
            children: [
              _stat(context, 'Spent', inr(mTotal)),
              _stat(context, 'Transactions', '$count'),
              _stat(context, 'Avg / day', inr(avgDaily(txs, month))),
              _stat(context, 'Avg txn', inr(avgTx(txs, from: from, to: to))),
              _stat(
                context,
                'Largest',
                big == null ? '—' : '${inr(big.amount)} · ${big.merchant}',
              ),
              _stat(
                context,
                'Top category',
                top == null ? '—' : '${top.key.label} · ${inr(top.value)}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THIS WEEK',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  InteractiveChart(
                    buckets: weeklyBuckets(txs, now),
                    counts: weeklyCounts(txs, now),
                    monday: weekStart(now),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORIES · ${monthLabel(month)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  for (final e in stats.entries)
                    if (e.value > 0)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          e.key.icon,
                          color: const Color(0xFF5B5CE2),
                        ),
                        title: Text(e.key.label),
                        subtitle: Text(
                          '${txs.where((t) => t.category == e.key && t.status.isConfirmed && !t.time.isBefore(from) && !t.time.isAfter(to)).length} txns · ${pct(mTotal <= 0 ? 0 : e.value / mTotal)}',
                        ),
                        trailing: Text(
                          inr(e.value),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          ref.read(categoryFilterProvider.notifier).state =
                              e.key;
                          ref.read(dateFilterProvider.notifier).state =
                              DateFilter.all;
                          ref.read(navIndexProvider.notifier).state = 1;
                        },
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SAVINGS · ${monthLabel(month)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  SavingsProgress(saved: mSaved, target: target),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, String title, String value) => Card(
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final pending = ref.watch(pendingCountProvider);
    void openSavings() =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SavingsScreen()));
    void openPending() =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const PendingScreen()));
    void openData() =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const DataScreen()));
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('PROFILE', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Local profile'),
              subtitle: Text('No account · data stays on this phone'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.savings_outlined),
              title: const Text('Savings & goals'),
              subtitle: Text('Target ${inr(target)} · tap to manage'),
              trailing: const Icon(Icons.chevron_right),
              onTap: openSavings,
            ),
          ),
          if (pending > 0)
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.pending_actions_outlined,
                  color: Color(0xFFF3A83B),
                ),
                title: Text('Pending review ($pending)'),
                subtitle: const Text('Payments still needing a verdict'),
                trailing: const Icon(Icons.chevron_right),
                onTap: openPending,
              ),
            ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: const Text('Data management'),
              subtitle: const Text('Export · import · delete — all on-device'),
              trailing: const Icon(Icons.chevron_right),
              onTap: openData,
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('App version'),
              subtitle: Text('1.0.0+1'),
            ),
          ),
        ],
      ),
    );
  }
}
