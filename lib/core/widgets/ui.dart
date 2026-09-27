import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../format/inr.dart';
import '../../domain/models.dart';
import '../theme/app_theme.dart';

// Reusable components (§56 subset). One file in Phase 1; split only when a
// widget grows its own state/logic (ponytail: fewest files).

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton({super.key, required this.label, this.onPressed, this.icon});
  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed == null ? null : () { HapticFeedback.lightImpact(); onPressed!(); },
        style: FilledButton.styleFrom(
          backgroundColor: EqColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min,
          children: [if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)], Text(label)]),
      );
}

class AmountDisplay extends StatelessWidget {
  final num value;
  final double size;
  final Color? color;
  const AmountDisplay(this.value, {super.key, this.size = 40, this.color});
  @override
  Widget build(BuildContext context) => Text(inr(value),
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w700,
        color: color ?? EqColors.ink, letterSpacing: -1));
}

class EmptyState extends StatelessWidget {
  final String title, subtitle, cta;
  final VoidCallback onCta;
  const EmptyState({super.key, required this.title, required this.subtitle, required this.cta, required this.onCta});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.qr_code_scanner, size: 56, color: EqColors.primary),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          PrimaryButton(label: cta, icon: Icons.qr_code_scanner, onPressed: onCta),
        ]),
      );
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: EqColors.primary));
}

class EqFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const EqFilterChip({super.key, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) => ChoiceChip(
      label: Text(label), selected: selected,
      selectedColor: EqColors.primary.withValues(alpha: 0.15),
      onSelected: (_) => onTap());
}

class TransactionRow extends StatelessWidget {
  final Tx tx;
  final VoidCallback? onTap;
  const TransactionRow(this.tx, {super.key, this.onTap});
  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        leading: CircleAvatar(
            backgroundColor: EqColors.primary.withValues(alpha: 0.12),
            child: Icon(tx.category.icon, color: EqColors.primary)),
        title: Text(tx.merchant, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${tx.category.label}${tx.description != null ? ' · ${tx.description}' : ''} · ${tx.status.label}'),
        trailing: Text(inr(tx.amount),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      );
}

class CategorySelector extends StatelessWidget {
  final Category? selected;
  final ValueChanged<Category> onSelect;
  const CategorySelector({super.key, required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8, runSpacing: 8,
        children: Category.values.map((c) {
          final sel = c == selected;
          return AnimatedScale(
            scale: sel ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: ChoiceChip(
              label: Row(mainAxisSize: MainAxisSize.min,
                children: [Icon(c.icon, size: 18), const SizedBox(width: 6), Text(c.label)]),
              selected: sel,
              selectedColor: EqColors.primary.withValues(alpha: 0.15),
              onSelected: (_) { HapticFeedback.selectionClick(); onSelect(c); },
            ),
          );
        }).toList(),
      );
}

class SavingsProgress extends StatelessWidget {
  final double saved, target;
  const SavingsProgress({super.key, required this.saved, required this.target});
  @override
  Widget build(BuildContext context) {
    final p = target <= 0 ? 0.0 : (saved / target).clamp(0.0, 1.0);
    final remaining = (target - saved).clamp(0, double.infinity);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${inr(saved)} / ${inr(target)}', style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(pct(p), style: const TextStyle(color: EqColors.primary, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 8),
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: p),
        duration: const Duration(milliseconds: 600),
        builder: (_, v, child) => LinearProgressIndicator(
            value: v, color: EqColors.primary,
            backgroundColor: EqColors.primary.withValues(alpha: 0.15)),
      ),
      const SizedBox(height: 4),
      Text('${inr(remaining)} remaining', style: Theme.of(context).textTheme.bodyMedium),
    ]);
  }
}

class SpendingCard extends StatelessWidget {
  final String title;
  final num value;
  const SpendingCard({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value.toDouble()),
              duration: const Duration(milliseconds: 500),
              builder: (_, v, child) => AmountDisplay(v),
            ),
          ]),
        ),
      );
}

/// Static 7-bar week chart (CustomPainter, no new dependency). Phase 4
/// replaces it with the interactive touch chart (§29).
class SpendingChart extends StatelessWidget {
  final List<double> buckets; // Mon..Sun confirmed sums
  const SpendingChart({super.key, required this.buckets});
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  @override
  Widget build(BuildContext context) {
    final max = buckets.fold<double>(0, (a, b) => a > b ? a : b);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (_, t, child) => SizedBox(
        height: 150,
        child: CustomPaint(
          painter: _Bars(buckets, max <= 0 ? 1 : max, t),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Expanded(child: Container()),
                    Text(_days[i], style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bars extends CustomPainter {
  final List<double> buckets;
  final double max, t;
  _Bars(this.buckets, this.max, this.t);
  @override
  void paint(Canvas canvas, Size size) {
    const days = 7;
    final slot = size.width / days;
    final paint = Paint()..color = EqColors.primary;
    final faint = Paint()..color = EqColors.primary.withValues(alpha: 0.25);
    for (var i = 0; i < days; i++) {
      final h = (buckets[i] / max) * (size.height - 28) * t;
      final x = i * slot + slot * 0.22;
      final w = slot * 0.56;
      final today = DateTime.now().weekday - 1 == i;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, size.height - 24 - h, w, h), const Radius.circular(6)),
        today ? paint : faint,
      );
    }
  }
  @override
  bool shouldRepaint(covariant _Bars old) => old.t != t || old.buckets != buckets;
}

/// Full transaction detail (§24) as a bottom sheet: no nav stack needed.
class TxDetailSheet extends StatelessWidget {
  final Tx tx;
  const TxDetailSheet(this.tx, {super.key});
  @override
  Widget build(BuildContext context) {
    final rows = <(String, String?)>[
      ('Merchant', tx.merchant),
      ('Amount', inr2(tx.amount)),
      ('Category', tx.category.label),
      ('Description', tx.description),
      ('UPI ID', tx.upiId),
      ('Payment app', tx.upiApp),
      ('Date', '${tx.time.day} ${_month(tx.time.month)} ${tx.time.year}'),
      ('Time', TimeOfDay.fromDateTime(tx.time).format(context)),
      ('Location', tx.locationLabel),
      ('Reference', tx.reference),
      ('Status', tx.status.label),
    ];
    return SafeArea(
      child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: const Color(0xFFE0E1E8), borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Row(children: [
            CircleAvatar(backgroundColor: EqColors.primary.withValues(alpha: 0.12),
                child: Icon(tx.category.icon, color: EqColors.primary)),
            const SizedBox(width: 12),
            Expanded(child: Text(tx.merchant, style: Theme.of(context).textTheme.titleLarge)),
            Text(inr(tx.amount), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          ]),
          const SizedBox(height: 16),
          for (final (k, v) in rows)
            if (v != null && v.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(width: 110, child: Text(k, style: Theme.of(context).textTheme.bodyMedium)),
                  Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.w500))),
                ]),
              ),
        ]),
      ),
      ),
    );
  }
}

String _month(int m) => const [
      '', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'][m];

void showTxDetail(BuildContext context, Tx tx) =>
    showModalBottomSheet(context: context, builder: (_) => TxDetailSheet(tx));
