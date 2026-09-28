import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../application/providers.dart';
import '../core/format/inr.dart';
import '../core/widgets/ui.dart';
import '../data/tx_store.dart';
import '../domain/models.dart';
import '../domain/upi/upi.dart';
import '../platform/location_capture.dart';
import '../platform/upi_launcher.dart';

// Phase 3 flow: Scan → Review → Pay → Reconcile. Replaces the ScanPlaceholder.

// --- Scanner (§14) ---

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});
  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  late final MobileScannerController _controller;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture cap) {
    if (_locked) return;
    final raw = cap.barcodes.firstOrNull?.rawValue;
    if (raw == null || raw.isEmpty) return;
    _locked = true;
    _controller.stop();
    HapticFeedback.mediumImpact();
    try {
      final payload = UpiPayload.parse(raw);
      if (!mounted) return;
      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (_) => ReviewScreen(payload: payload)),
          )
          .then((_) {
            _locked = false;
            _controller.start();
          });
    } on UpiParseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e.message}. Try a UPI payment QR.')),
      );
      _locked = false;
      _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: const Text('Scan a UPI QR'),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    body: Stack(
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
          errorBuilder: (context, error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.videocam_off,
                    color: Colors.white70,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Camera is needed to scan payment QRs. Nothing is recorded — '
                    'only the QR payload is read, on this phone.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'TRY AGAIN',
                    onPressed: () => _controller.start(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF5B5CE2), width: 3),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        const Positioned(
          bottom: 48,
          left: 0,
          right: 0,
          child: Text(
            'Point your camera at the payment QR',
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// --- Review (§16–21) ---

class ReviewScreen extends ConsumerStatefulWidget {
  final UpiPayload payload;
  const ReviewScreen({super.key, required this.payload});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  Category? _category;
  final _desc = TextEditingController();
  final _amount = TextEditingController();
  Future<Fix?>? _fixFuture;
  Future<Map<UpiApp, bool>>? _appsFuture;
  UpiApp? _app;
  bool _paying = false;

  @override
  void initState() {
    super.initState();
    _fixFuture = _captureWithRationale();
    _appsFuture = upiLauncher.installedStates().then((m) {
      for (final app in upiApps) {
        if (m[app] == true) {
          _app = app; // default: first installed, spec order
          break;
        }
      }
      return m;
    });
  }

  @override
  void dispose() {
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  /// Just-in-time permission with a reason (§49). "Not now" skips location;
  /// the payment continues either way.
  Future<Fix?> _captureWithRationale() async {
    try {
      if (await Geolocator.checkPermission() == LocationPermission.denied &&
          mounted) {
        final ok = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pin this payment to a place?'),
            content: const Text(
              'Equinox saves the location with the transaction so your '
              'history shows where you paid. One capture, never tracking.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('NOT NOW'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('ALLOW'),
              ),
            ],
          ),
        );
        if (ok != true) return null;
      }
    } catch (_) {
      return null;
    }
    return captureFix(); // single capture for this transaction
  }

  double? get _amountValue =>
      widget.payload.amount ?? double.tryParse(_amount.text.trim());

  bool _canPay(Map<UpiApp, bool>? installed) =>
      !_paying &&
      _category != null &&
      (_amountValue ?? 0) > 0 &&
      _app != null &&
      (installed?[_app] ?? false);

  Future<void> _pay() async {
    final amount = _amountValue;
    final category = _category;
    final app = _app;
    if (amount == null || amount <= 0 || category == null || app == null) {
      return;
    }
    setState(() => _paying = true);
    try {
      final fix = await _fixFuture;
      final desc = _desc.text.trim().isEmpty ? null : _desc.text.trim();
      final txId = await txStore.createInitiated(
        payload: widget.payload,
        amount: amount,
        category: category,
        description: desc,
        upiApp: app.name,
        fix: fix == null ? null : FixCoords(fix.lat, fix.lng, fix.accuracy),
      );
      final attemptId = await txStore.recordLaunch(txId: txId, app: app.name);
      final uri = widget.payload.toUri(
        amountOverride: widget.payload.amount == null ? amount : null,
        noteOverride: desc,
      );
      final installed = await upiLauncher.isInstalled(app.packageName);
      try {
        await upiLauncher.launch(
          uri,
          package: installed ? app.packageName : null,
        );
      } on PlatformException {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No app opened this payment. Confirm its status below.',
            ),
          ),
        );
      }
      ref.read(awaitingReturnProvider.notifier).state = (
        txId: txId,
        attemptId: attemptId,
      );
      if (!mounted) return;
      Navigator.of(context).popUntil((r) => r.isFirst);
      ref.read(navIndexProvider.notifier).state = 0;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not save payment: $e')));
    } finally {
      if (mounted) setState(() => _paying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.payload;
    return Scaffold(
      appBar: AppBar(title: const Text('REVIEW PAYMENT')),
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
                    p.payeeName ?? p.vpa,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(p.vpa, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  if (p.amount != null)
                    AmountDisplay(p.amount!)
                  else
                    TextField(
                      controller: _amount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Amount (₹)',
                        hintText: 'QR has no amount — enter it',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
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
                    'WHAT IS THIS PAYMENT FOR?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  CategorySelector(
                    selected: _category,
                    onSelect: (c) => setState(() => _category = c),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _desc,
                    decoration: const InputDecoration(
                      labelText: 'DESCRIPTION (optional)',
                      hintText: 'What was this for?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder<Fix?>(
            future: _fixFuture,
            builder: (context, snap) {
              final fix = snap.data;
              final label = snap.connectionState == ConnectionState.waiting
                  ? 'Locating…'
                  : fix == null
                  ? 'Location unavailable'
                  : '${fix.lat.toStringAsFixed(4)}, ${fix.lng.toStringAsFixed(4)}';
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF5B5CE2),
                  ),
                  title: Text(label),
                  subtitle: Text(
                    '${TimeOfDay.now().format(context)} · ${DateTime.now().day} ${_m(DateTime.now().month)} ${DateTime.now().year}',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          FutureBuilder<Map<UpiApp, bool>>(
            future: _appsFuture,
            builder: (context, snap) {
              final installed = snap.data;
              if (installed == null) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: LoadingState(),
                  ),
                );
              }
              final anyInstalled = installed.values.any((v) => v);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PAY WITH',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (!anyInstalled)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'No supported UPI app found. Install one to pay.',
                          ),
                        ),
                      RadioGroup<UpiApp>(
                        groupValue: _app,
                        onChanged: (v) => setState(() => _app = v),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final app in upiApps)
                              RadioListTile<UpiApp>(
                                value: app,
                                enabled: installed[app] == true,
                                title: Text(app.name),
                                secondary: Icon(
                                  app.icon,
                                  color: const Color(0xFF5B5CE2),
                                ),
                                subtitle: Text(
                                  installed[app] == true
                                      ? '✓ Installed'
                                      : 'Not installed',
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: _paying
                              ? 'OPENING…'
                              : 'PAY ${inr(_amountValue ?? 0)}',
                          onPressed: _canPay(installed) ? _pay : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String _m(int m) => const [
  '',
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
][m];

// --- Reconcile (§23) ---

class ReconcileSheet extends ConsumerWidget {
  final String txId;
  final String attemptId;
  final String merchant;
  final double amount;
  const ReconcileSheet({
    super.key,
    required this.txId,
    required this.attemptId,
    required this.merchant,
    required this.amount,
  });

  Future<void> _set(BuildContext context, WidgetRef ref, PayStatus to) async {
    try {
      await txStore.reconcile(txId: txId, attemptId: attemptId, to: to);
    } on StateError catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
    ref.read(awaitingReturnProvider.notifier).state = null;
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Did you complete this payment?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '$merchant · ${inr(amount)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Equinox never guesses — tell it what happened.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'YES, COMPLETED',
              onPressed: () => _set(context, ref, PayStatus.successful),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _set(context, ref, PayStatus.cancelled),
              child: const Text('NO, CANCELLED'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => _set(context, ref, PayStatus.pending),
              child: const Text('KEEP PENDING'),
            ),
          ),
        ],
      ),
    ),
  );
}
