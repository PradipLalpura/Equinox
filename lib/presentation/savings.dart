import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers.dart';
import '../core/format/inr.dart';
import '../core/widgets/ui.dart';
import '../data/tx_store.dart';
import '../domain/models.dart';

// Phase 4: savings as first-class citizens (§9–13). One file: dashboard,
// add-sheet, goal CRUD, history. Reached from Home savings card + Profile.

Future<void> _sheet(BuildContext context, Widget child) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: SingleChildScrollView(child: child),
  ),
);

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savings = ref.watch(savingsListProvider).valueOrNull ?? const [];
    final goals = ref.watch(goalsProvider).valueOrNull ?? const [];
    final target = ref.watch(savingsTargetProvider).valueOrNull ?? 5000;
    final now = DateTime.now();
    final saved = savedInMonth(savings, now);
    final names = {for (final g in goals) g.id: g.name};
    final active = goals.where((g) => g.status == GoalStatus.active).toList();
    final done = goals.where((g) => g.status != GoalStatus.active).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('SAVINGS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SAVED IN ${monthLabel(now).toUpperCase()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  SavingsProgress(saved: saved, target: target),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'ADD SAVINGS',
                          icon: Icons.add,
                          onPressed: () =>
                              _sheet(context, AddSavingSheet(goals: active)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _targetDialog(context, ref, target),
                        child: const Text('TARGET'),
                      ),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GOALS',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => _sheet(context, const GoalSheet()),
                        child: const Text('+ NEW GOAL'),
                      ),
                    ],
                  ),
                  if (active.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'No active goals. Create one — Emergency Fund, Trip, anything.',
                      ),
                    ),
                  for (final g in active) GoalCard(goal: g),
                  if (done.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'PAUSED / COMPLETED',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    for (final g in done) GoalCard(goal: g),
                  ],
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
                    'HISTORY',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (savings.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Start building your savings. Record your first contribution.',
                      ),
                    ),
                  for (final s in savings.take(20))
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: Color(0x1A20B26B),
                        child: Icon(
                          Icons.savings_outlined,
                          color: Color(0xFF20B26B),
                        ),
                      ),
                      title: Text(
                        inr(s.amount),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${s.goalId == null ? 'General' : (names[s.goalId] ?? 'Goal')}${s.description != null ? ' · ${s.description}' : ''}',
                      ),
                      trailing: Text(formatDay(s.date)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _targetDialog(
    BuildContext context,
    WidgetRef ref,
    double current,
  ) async {
    final ctrl = TextEditingController(text: current.toStringAsFixed(0));
    final v = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Monthly savings target'),
        content: TextField(
          controller: ctrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            prefixText: '₹ ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, double.tryParse(ctrl.text.trim())),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
    if (v != null && v >= 0 && context.mounted) {
      await txStore.setTarget(v);
    }
  }
}

class GoalCard extends ConsumerWidget {
  final SavingGoal goal;
  const GoalCard({super.key, required this.goal});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  goal.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                pct(goal.progress),
                style: const TextStyle(
                  color: Color(0xFF5B5CE2),
                  fontWeight: FontWeight.w700,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (a) => _action(context, ref, goal, a),
                itemBuilder: (_) => [
                  if (goal.status == GoalStatus.active)
                    const PopupMenuItem(
                      value: 'contribute',
                      child: Text('Add contribution'),
                    ),
                  const PopupMenuItem(value: 'edit', child: Text('Edit goal')),
                  if (goal.status == GoalStatus.active) ...[
                    const PopupMenuItem(
                      value: 'pause',
                      child: Text('Pause goal'),
                    ),
                    const PopupMenuItem(
                      value: 'complete',
                      child: Text('Complete goal'),
                    ),
                  ],
                  if (goal.status == GoalStatus.paused)
                    const PopupMenuItem(
                      value: 'resume',
                      child: Text('Resume goal'),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete goal'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${inr(goal.current)} / ${inr(goal.target)} · ${inr(goal.remaining)} left',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: goal.progress),
            duration: const Duration(milliseconds: 600),
            builder: (_, v, child) => LinearProgressIndicator(
              value: v,
              color: goal.status == GoalStatus.completed
                  ? const Color(0xFF20B26B)
                  : const Color(0xFF5B5CE2),
              backgroundColor: const Color(0xFF5B5CE2).withValues(alpha: 0.15),
            ),
          ),
          if (goal.targetDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'by ${formatDay(goal.targetDate!)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    ),
  );

  Future<void> _action(
    BuildContext context,
    WidgetRef ref,
    SavingGoal g,
    String a,
  ) async {
    switch (a) {
      case 'contribute':
        await _sheet(context, ContributeSheet(goal: g));
      case 'edit':
        await _sheet(context, GoalSheet(existing: g));
      case 'pause':
        await txStore.setGoalStatus(id: g.id, status: GoalStatus.paused);
      case 'resume':
      case 'complete':
        await txStore.setGoalStatus(
          id: g.id,
          status: a == 'resume' ? GoalStatus.active : GoalStatus.completed,
        );
      case 'delete':
        final ok = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete goal?'),
            content: Text(
              '“${g.name}” goes away. Past contributions stay in history as General.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('KEEP'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('DELETE'),
              ),
            ],
          ),
        );
        if (ok == true) await txStore.deleteGoal(g.id);
    }
  }
}

/// ADD SAVINGS bottom sheet (§12): amount, goal, description, date.
class AddSavingSheet extends ConsumerStatefulWidget {
  final List<SavingGoal> goals;
  const AddSavingSheet({super.key, required this.goals});
  @override
  ConsumerState<AddSavingSheet> createState() => _AddSavingSheetState();
}

class _AddSavingSheetState extends ConsumerState<AddSavingSheet> {
  final _amount = TextEditingController();
  final _desc = TextEditingController();
  String? _goalId;
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _amount.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amt = double.tryParse(_amount.text.trim());
    if (amt == null || amt <= 0 || _saving) return;
    setState(() => _saving = true);
    try {
      final desc = _desc.text.trim().isEmpty ? null : _desc.text.trim();
      if (_goalId == null) {
        await txStore.addSaving(amount: amt, description: desc, date: _date);
      } else {
        await txStore.contribute(
          goalId: _goalId!,
          amount: amt,
          description: desc,
          date: _date,
        );
      }
      HapticFeedback.lightImpact();
      if (mounted) Navigator.of(context).pop();
    } on StateError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ADD SAVINGS', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Amount (₹)',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _goalId,
            decoration: const InputDecoration(
              labelText: 'Goal',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(value: null, child: Text('General')),
              for (final g in widget.goals)
                DropdownMenuItem(value: g.id, child: Text(g.name)),
            ],
            onChanged: (v) => setState(() => _goalId = v),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(formatDay(_date)),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                initialDate: _date,
              );
              if (d != null) setState(() => _date = d);
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: _saving ? 'SAVING…' : 'SAVE',
              onPressed: (double.tryParse(_amount.text.trim()) ?? 0) > 0
                  ? _save
                  : null,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Add / edit a goal.
class GoalSheet extends StatefulWidget {
  final SavingGoal? existing;
  const GoalSheet({super.key, this.existing});
  @override
  State<GoalSheet> createState() => _GoalSheetState();
}

class _GoalSheetState extends State<GoalSheet> {
  late final TextEditingController _name;
  late final TextEditingController _target;
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name ?? '');
    _target = TextEditingController(
      text: widget.existing == null
          ? ''
          : widget.existing!.target.toStringAsFixed(0),
    );
    _date = widget.existing?.targetDate;
  }

  @override
  void dispose() {
    _name.dispose();
    _target.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final t = double.tryParse(_target.text.trim());
    if (_name.text.trim().isEmpty || t == null || t <= 0) return;
    try {
      if (widget.existing == null) {
        await txStore.addGoal(name: _name.text, target: t, targetDate: _date);
      } else {
        await txStore.updateGoal(
          id: widget.existing!.id,
          name: _name.text,
          target: t,
          targetDate: _date,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } on ArgumentError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Invalid input')));
      }
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.existing == null ? 'NEW GOAL' : 'EDIT GOAL',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Name (e.g. Emergency Fund)',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _target,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Target (₹)',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.flag_outlined),
            title: Text(
              _date == null ? 'Target date (optional)' : formatDay(_date!),
            ),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
              );
              if (d != null) setState(() => _date = d);
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'SAVE GOAL', onPressed: _save),
          ),
        ],
      ),
    ),
  );
}

/// Contribute to one goal (also writes a savings row — atomic).
class ContributeSheet extends StatefulWidget {
  final SavingGoal goal;
  const ContributeSheet({super.key, required this.goal});
  @override
  State<ContributeSheet> createState() => _ContributeSheetState();
}

class _ContributeSheetState extends State<ContributeSheet> {
  final _amount = TextEditingController();
  final _desc = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ADD TO “${widget.goal.name.toUpperCase()}”',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '${inr(widget.goal.remaining)} left',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Amount (₹)',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'CONTRIBUTE',
              onPressed: (double.tryParse(_amount.text.trim()) ?? 0) > 0
                  ? () async {
                      try {
                        await txStore.contribute(
                          goalId: widget.goal.id,
                          amount: double.parse(_amount.text.trim()),
                          description: _desc.text.trim().isEmpty
                              ? null
                              : _desc.text.trim(),
                        );
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } on StateError catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.message)));
                        }
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    ),
  );
}
