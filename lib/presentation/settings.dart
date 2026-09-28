import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../application/providers.dart';
import '../core/widgets/ui.dart';
import '../data/backup.dart';
import '../data/tx_store.dart';
import 'pay.dart';

// Phase 6 screens: pending-review inbox + data management. One file, both
// reached from Profile. Everything here is manual and on-device.

// --- Pending inbox: payments still needing a human verdict ---

class PendingScreen extends ConsumerWidget {
  const PendingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(pendingTxProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('PENDING REVIEW')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'These payments never got a final status. Equinox will not '
                'guess — confirm each one. Unconfirmed payments stay out of '
                'spending totals.',
              ),
            ),
          ),
          if (pending.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('All clear. Every payment has a verdict.'),
              ),
            ),
          for (final t in pending)
            Card(
              child: TransactionRow(
                t,
                onTap: () => _resolve(context, ref, t.id),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _resolve(
    BuildContext context,
    WidgetRef ref,
    String txId,
  ) async {
    final tx = ref.read(pendingTxProvider).firstWhere((t) => t.id == txId);
    var attemptId = await txStore.attemptFor(txId);
    attemptId ??= await txStore.recordLaunch(
      txId: txId,
      app: tx.upiApp ?? 'manual review',
    );
    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      builder: (_) => ReconcileSheet(
        txId: txId,
        attemptId: attemptId!,
        merchant: tx.merchant,
        amount: tx.amount,
      ),
    );
  }
}

// --- Data management: export / import / delete (§44–46) ---

class DataScreen extends ConsumerWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text('DATA MANAGEMENT')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Your data lives only on this phone. Export it yourself, '
              'restore a backup yourself. Nothing is ever uploaded.',
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.table_chart_outlined),
                title: const Text('Export transactions (CSV)'),
                subtitle: const Text(
                  'Spreadsheet of every payment. Shared manually.',
                ),
                onTap: () => _exportShare(
                  context,
                  'equinox-transactions.csv',
                  () => exportCsv(appDb),
                  'Equinox transactions',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.archive_outlined),
                title: const Text('Export full backup (JSON)'),
                subtitle: const Text(
                  'Everything: payments, savings, goals, settings.',
                ),
                onTap: () => _exportShare(
                  context,
                  'equinox-backup-${DateTime.now().toIso8601String().split('T').first}.json',
                  () => exportJson(appDb),
                  'Equinox backup',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.unarchive_outlined),
                title: const Text('Import backup (JSON)'),
                subtitle: const Text(
                  'Replaces ALL current data. Make an export first.',
                ),
                onTap: () => _import(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.delete_forever_outlined,
              color: Color(0xFFE05252),
            ),
            title: const Text(
              'Delete all data',
              style: TextStyle(
                color: Color(0xFFE05252),
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: const Text(
              'Permanently removes all local transactions, savings, goals and reports.',
            ),
            onTap: () => _deleteAll(context),
          ),
        ),
      ],
    ),
  );

  /// Save [content] to app storage, then open the system share sheet.
  /// Manual, on-device, offline — the only way data ever leaves the phone.
  Future<void> _exportShare(
    BuildContext context,
    String name,
    Future<String> Function() encode,
    String subject,
  ) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');
      await file.writeAsString(await encode());
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: subject),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Saved: ${file.path}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<void> _import(BuildContext context) async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (files.isEmpty || !context.mounted) return;
    late final Uint8List bytes;
    try {
      bytes = await files.single.readAsBytes();
    } catch (_) {
      return;
    }
    if (!context.mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Replace all data?'),
        content: const Text(
          'Importing wipes everything currently in Equinox, then restores '
          'the backup. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('REPLACE ALL'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await importJson(appDb, utf8.decode(bytes));
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Backup restored.')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed (data untouched): $e')),
        );
      }
    }
  }

  Future<void> _deleteAll(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
          'This will permanently remove all local transactions, savings, '
          'goals and reports. There is no cloud copy. There is no undo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('KEEP MY DATA'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE05252),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE EVERYTHING'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await txStore.wipeAll();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Everything deleted. Fresh start.')),
      );
      Navigator.of(context).pop();
    }
  }
}
