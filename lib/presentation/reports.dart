import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import '../application/providers.dart';
import '../core/format/inr.dart';
import '../core/widgets/ui.dart';
import '../domain/models.dart';
import '../domain/reports/report.dart';
import '../platform/report_pdf.dart';

// Phase 5: archive + detail + export/share. Reports are derived live from
// transactions/savings — opening a month IS generating it (§31).

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    final savings = ref.watch(savingsListProvider).valueOrNull ?? const [];
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final now = DateTime.now();
    final months = reportMonths(txs, savings, now);
    return Scaffold(
      appBar: AppBar(title: const Text('REPORTS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (months.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Your first monthly report will appear here, automatically, once a month has spending.',
                ),
              ),
            ),
          for (final m in months)
            _monthCard(context, ref, txs, savings, target, m, now),
        ],
      ),
    );
  }

  Widget _monthCard(
    BuildContext context,
    WidgetRef ref,
    List<Tx> txs,
    List<SavingEntry> savings,
    double target,
    DateTime m,
    DateTime now,
  ) {
    final r = buildReport(txs, savings, target, m.year, m.month);
    final live = m.year == now.year && m.month == now.month;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Row(
          children: [
            Text(monthLabel(m), style: Theme.of(context).textTheme.titleLarge),
            if (live) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF20B26B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Color(0xFF20B26B),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${inr(r.total)} spent · ${inr(r.saved)} saved · ${r.count} txns',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReportDetailScreen(year: m.year, month: m.month),
          ),
        ),
      ),
    );
  }
}

class ReportDetailScreen extends ConsumerWidget {
  final int year, month;
  const ReportDetailScreen({
    super.key,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(txListProvider).valueOrNull ?? const <Tx>[];
    final savings = ref.watch(savingsListProvider).valueOrNull ?? const [];
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final r = buildReport(txs, savings, target, year, month);
    final label = monthLabel(DateTime(year, month));
    final maxW = r.weeks.fold<double>(0, (a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text(label.toUpperCase())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'EXPORT PDF',
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: () => _export(context, r, label),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: PrimaryButton(
                  label: 'SHARE',
                  icon: Icons.share_outlined,
                  onPressed: () => _share(context, r, label),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _section(context, 'SUMMARY', [
            _kv(context, 'Total spending', inr(r.total)),
            _kv(context, 'Total savings', inr(r.saved)),
            _kv(context, 'Transactions', '${r.count}'),
            _kv(context, 'Average transaction', inr(r.avg)),
            _kv(
              context,
              'Largest',
              r.largest == null
                  ? '—'
                  : '${inr(r.largest!.amount)} · ${r.largest!.merchant}',
            ),
          ]),
          _section(context, 'CATEGORY BREAKDOWN', [
            for (final c in r.categories)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(c.category.icon, color: const Color(0xFF5B5CE2)),
                title: Text(c.category.label),
                subtitle: Text('${c.count} txns · ${pct(c.pct)}'),
                trailing: Text(
                  inr(c.total),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
          ]),
          _section(context, 'WEEKLY SPENDING', [
            for (var i = 0; i < 5; i++)
              if (i < 4 || r.weeks[i] > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(width: 64, child: Text('Week ${i + 1}')),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: maxW <= 0 ? 0.0 : r.weeks[i] / maxW,
                          color: const Color(0xFF5B5CE2),
                          backgroundColor: const Color(0xFF5B5CE2)
                              .withValues(alpha: 0.15),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        inr(r.weeks[i]),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
          ]),
          _section(context, 'DAILY SPENDING', [
            DailyStrip(daily: r.daily),
            Text(
              'Day 1 – ${r.daily.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ]),
          _section(context, 'LARGEST EXPENSES', [
            if (r.largestN.isEmpty) const Text('No spending this month.'),
            for (final t in r.largestN)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t.merchant),
                subtitle: Text('${t.category.label} · ${formatDay(t.time)}'),
                trailing: Text(
                  inr(t.amount),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
          ]),
          _section(context, 'TOP MERCHANTS', [
            if (r.merchants.isEmpty) const Text('No merchant activity.'),
            for (final m in r.merchants)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(m.merchant),
                subtitle: Text('${m.count} payments'),
                trailing: Text(
                  inr(m.total),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
          ]),
          _section(context, 'SAVINGS', [
            SavingsProgress(saved: r.saved, target: r.target),
          ]),
          _section(context, 'MONTH COMPARISON', [
            _kv(
              context,
              'Spending',
              '${inr(r.total)} (was ${inr(r.prevTotal)}) · ${_signed(r.total - r.prevTotal)}',
            ),
            _kv(
              context,
              'Savings',
              '${inr(r.saved)} (was ${inr(r.prevSaved)}) · ${_signed(r.saved - r.prevSaved)}',
            ),
            _kv(
              context,
              'Transactions',
              '${r.count} (was ${r.prevCount}) · ${_signedNum(r.count - r.prevCount)}',
            ),
          ]),
        ],
      ),
    );
  }

  String _signed(double d) =>
      d == 0 ? 'no change' : '${d > 0 ? '+' : '−'}${inr(d.abs())}';
  String _signedNum(int d) => d == 0 ? 'no change' : '${d > 0 ? '+' : ''}$d';

  Widget _section(BuildContext context, String title, List<Widget> children) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      );

  Widget _kv(BuildContext context, String k, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(k, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );

  Future<void> _export(
    BuildContext context,
    MonthlyReport r,
    String label,
  ) async {
    try {
      final bytes = await buildMonthlyPdf(r, DateTime.now());
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/equinox-report-${r.year}-${r.month.toString().padLeft(2, '0')}.pdf',
      );
      await file.writeAsBytes(bytes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved: $label report → ${file.path}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<void> _share(
    BuildContext context,
    MonthlyReport r,
    String label,
  ) async {
    try {
      final bytes = await buildMonthlyPdf(r, DateTime.now());
      await Printing.sharePdf(
        bytes: bytes,
        filename:
            'equinox-report-${r.year}-${r.month.toString().padLeft(2, '0')}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Share failed: $e')));
      }
    }
  }
}

/// Thin daily bars for the report detail (31 values max).
class DailyStrip extends StatelessWidget {
  final List<double> daily;
  const DailyStrip({super.key, required this.daily});
  @override
  Widget build(BuildContext context) {
    final max = daily.fold<double>(0, (a, b) => a > b ? a : b);
    return SizedBox(
      height: 90,
      child: CustomPaint(painter: _Strip(daily, max <= 0 ? 1 : max)),
    );
  }
}

class _Strip extends CustomPainter {
  final List<double> daily;
  final double max;
  _Strip(this.daily, this.max);
  @override
  void paint(Canvas canvas, Size size) {
    final n = daily.length;
    final slot = size.width / n;
    final paint = Paint()..color = const Color(0xFF5B5CE2);
    final empty = Paint()..color = const Color(0xFFE4E5F2);
    for (var i = 0; i < n; i++) {
      final h = daily[i] <= 0 ? 4.0 : 8.0 + 70 * (daily[i] / max);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(i * slot + 1, size.height - h, slot - 2, h),
          const Radius.circular(2),
        ),
        daily[i] > 0 ? paint : empty,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _Strip old) => old.daily != daily;
}
