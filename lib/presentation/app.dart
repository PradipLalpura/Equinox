import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/providers.dart';
import '../core/format/inr.dart';
import '../core/widgets/ui.dart';
import '../data/tx_store.dart';
import '../domain/models.dart';
import 'pay.dart';

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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('EQUINOX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF5B5CE2), letterSpacing: 3)),
              const SizedBox(height: 12),
              Text('Your payments.\nRemembered.', style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 12),
              Text('Scan once. Equinox remembers the details. Understand your spending. Build your savings. Your data stays on your phone.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 32),
              PrimaryButton(label: 'GET STARTED',
                  onPressed: () => ref.read(onboardingDoneProvider.notifier).state = true),
            ]),
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
    AnalyticsPlaceholder(),
    ProfileScreen()
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
        onDestinationSelected: (v) => ref.read(navIndexProvider.notifier).state = v,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'HOME'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'HISTORY'),
          NavigationDestination(icon: Icon(Icons.qr_code_scanner), label: 'SCAN'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'ANALYTICS'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'PROFILE'),
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
    final target = ref.watch(savingsTargetProvider);
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    final now = TimeOfDay.now().hour;
    final greet = now < 12 ? 'Good morning' : now < 17 ? 'Good afternoon' : 'Good evening';
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        Text('EQUINOX', style: Theme.of(context).textTheme.bodyMedium?.copyWith(letterSpacing: 3, fontWeight: FontWeight.w700)),
        Text(greet, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        SpendingCard(title: 'TOTAL SPENDING', value: total),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: SpendingCard(title: 'THIS MONTH', value: month)),
          const SizedBox(width: 8),
          Expanded(child: SpendingCard(title: 'THIS WEEK', value: week)),
        ]),
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('SAVINGS', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            SavingsProgress(saved: saved, target: target),
          ]))),
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('CATEGORY BREAKDOWN', style: Theme.of(context).textTheme.bodyMedium),
            for (final e in categoryTotals(txs).entries)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(e.key.icon, color: const Color(0xFF5B5CE2)),
                title: Text(e.key.label),
                trailing: Text(inr(e.value),
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
          ]))),
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('THIS WEEK', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            SpendingChart(buckets: weeklyBuckets(txs, DateTime.now())),
          ]))),
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MONTHLY REPORT', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('September 2026', style: Theme.of(context).textTheme.titleLarge),
            Text('${inr(month)} spent · ${inr(saved)} saved',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            PrimaryButton(label: 'VIEW REPORT', onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Monthly reports land in Phase 5. Your data is safe until then.')));
            }),
          ]))),
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('RECENT TRANSACTIONS', style: Theme.of(context).textTheme.bodyMedium),
            for (final t in (List<Tx>.from(txs)..sort((a, b) => b.time.compareTo(a.time))).take(4))
              TransactionRow(t, onTap: () => showTxDetail(context, t)),
          ]))),
      ]),
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
      return SafeArea(child: Center(child: EmptyState(
        title: 'Your spending story starts here.',
        subtitle: 'Scan your first payment QR to automatically record an expense.',
        cta: 'SCAN YOUR FIRST QR',
        onCta: () => ref.read(navIndexProvider.notifier).state = 2)));
    }
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        Text('HISTORY', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        SearchBar(
          hintText: 'Search merchant, UPI ID, note…',
          leading: const Icon(Icons.search),
          elevation: const WidgetStatePropertyAll(0),
          onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          EqFilterChip(label: 'All', selected: cat == null,
              onTap: () => ref.read(categoryFilterProvider.notifier).state = null),
          for (final c in Category.values)
            EqFilterChip(label: c.label, selected: cat == c,
                onTap: () => ref.read(categoryFilterProvider.notifier).state = c),
        ]),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
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
                  ref.read(customRangeProvider.notifier).state = (r.start, r.end);
                }
                ref.read(dateFilterProvider.notifier).state = d;
              },
            ),
        ]),
        const SizedBox(height: 8),
        if (groups.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(24),
              child: Text('No transactions match. Try clearing search or filters.')))
        else
          for (final g in groups) ...[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4, left: 4),
              child: Text(_dayLabel(g.key),
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            for (final t in g.value)
              Card(child: TransactionRow(t, onTap: () => showTxDetail(context, t))),
          ],
      ]),
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
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul',
      'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m];

class AnalyticsPlaceholder extends ConsumerWidget {
  const AnalyticsPlaceholder({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
      Text('ANALYTICS', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 8),
      SpendingCard(title: 'Total Spending', value: confirmed(txs)),
      const SizedBox(height: 8),
      SpendingCard(title: 'Transactions', value: txs.where((t) => t.status.isConfirmed).length),
      const SizedBox(height: 8),
      const Card(child: Padding(padding: EdgeInsets.all(20),
        child: Text('Weekly chart, category drill-down and monthly view land in Phase 4.'))),
    ]));
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('PROFILE', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Card(child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Local profile'), subtitle: Text('No account · data stays on this phone'))),
          const Card(child: ListTile(
              leading: Icon(Icons.savings_outlined),
              title: Text('Monthly savings target'), subtitle: Text('₹5,000'))),
          const Card(child: ListTile(
              leading: Icon(Icons.folder_outlined),
              title: Text('Data management'),
              subtitle: Text('Export / import / delete land in Phase 6 · Settings'))),
          const Card(child: ListTile(
              leading: Icon(Icons.info_outline), title: Text('App version'), subtitle: Text('1.0.0+1'))),
        ]),
      );
}
