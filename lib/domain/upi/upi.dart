import 'package:flutter/material.dart';
import '../models.dart';

// UPI domain: QR parsing (§15), app configs (§21–22), status machine (§23).
// Pure Dart except IconData refs — fully unit-tested, no platform involved.

class UpiParseException implements Exception {
  final String message;
  const UpiParseException(this.message);
  @override
  String toString() => 'UpiParseException: $message';
}

/// Parsed `upi://pay?...` payload. Only `pa` (VPA) is required; amount is
/// optional — review screen forces manual entry when absent (§61).
class UpiPayload {
  final String vpa;
  final String? payeeName;
  final double? amount;
  final String currency;
  final String? reference;
  final String? note;
  final String? merchantCode;
  final String raw;
  const UpiPayload({required this.vpa, this.payeeName, this.amount,
    this.currency = 'INR', this.reference, this.note, this.merchantCode,
    required this.raw});

  static UpiPayload parse(String raw) {
    final text = raw.trim();
    final uri = Uri.tryParse(text);
    // ponytail: only upi://pay. tez://upi/pay deep links are out of scope —
    // scanner shows "not a UPI QR" instead of mis-parsing.
    if (uri == null || uri.scheme != 'upi' || uri.host != 'pay') {
      throw const UpiParseException('Not a UPI payment QR');
    }
    final q = uri.queryParameters;
    final pa = (q['pa'] ?? '').trim();
    if (pa.isEmpty || !pa.contains('@')) {
      throw const UpiParseException('QR is missing a valid UPI ID');
    }
    double? amount;
    final am = q['am']?.trim() ?? '';
    if (am.isNotEmpty) {
      amount = double.tryParse(am);
      if (amount == null || amount <= 0) {
        throw const UpiParseException('QR has an invalid amount');
      }
    }
    String? opt(String key) {
      final v = q[key]?.trim();
      return (v == null || v.isEmpty) ? null : v;
    }
    return UpiPayload(
      vpa: pa,
      payeeName: opt('pn'),
      amount: amount,
      currency: opt('cu') ?? 'INR',
      reference: opt('tr'),
      note: opt('tn'),
      merchantCode: opt('mc'),
      raw: text,
    );
  }

  /// UPI collect URL for the external app. Only non-null params included.
  Uri toUri({double? amountOverride, String? noteOverride}) {
    final amt = amountOverride ?? amount;
    final nt = noteOverride ?? note;
    final params = <String, String>{
      'pa': vpa,
      'pn': ?payeeName,
      'am': ?amt?.toStringAsFixed(2),
      'cu': currency,
      'tr': ?reference,
      'tn': ?nt,
      'mc': ?merchantCode,
    };
    return Uri(scheme: 'upi', host: 'pay', queryParameters: params);
  }
}

/// The five supported UPI apps (§21). Package names for GPay/PhonePe/Paytm
/// are stable; POP UPI/super.money packages are best-effort — launch always
/// falls back to a generic upi://pay chooser when the package isn't
/// confirmed installed, so a wrong guess degrades to "pick manually",
/// never to a dead end. Verify on-device in the acceptance matrix.
class UpiApp {
  final String name;
  final String packageName;
  final IconData icon;
  const UpiApp(this.name, this.packageName, this.icon);
}

const upiApps = <UpiApp>[
  UpiApp('super.money', 'com.supermoney.app', Icons.bolt_outlined),
  UpiApp('POP UPI', 'com.pop.upi', Icons.local_offer_outlined),
  UpiApp('Google Pay', 'com.google.android.apps.nbu.paisa.user', Icons.g_mobiledata),
  UpiApp('PhonePe', 'com.phonepe.app', Icons.account_balance_wallet_outlined),
  UpiApp('Paytm', 'net.one97.paytm', Icons.payments_outlined),
];

// Status machine (§23). Terminal states have no exits; NOTHING auto-moves
// initiated/pending/unknown → successful — only explicit user reconcile does.
const allowedTransitions = <PayStatus, Set<PayStatus>>{
  PayStatus.draft: {PayStatus.initiated, PayStatus.cancelled},
  PayStatus.initiated: {PayStatus.pending, PayStatus.successful, PayStatus.failed, PayStatus.cancelled, PayStatus.unknown},
  PayStatus.pending: {PayStatus.successful, PayStatus.failed, PayStatus.cancelled, PayStatus.unknown},
  PayStatus.unknown: {PayStatus.successful, PayStatus.failed, PayStatus.cancelled, PayStatus.pending},
  PayStatus.successful: {},
  PayStatus.failed: {},
  PayStatus.cancelled: {},
};

bool canTransition(PayStatus from, PayStatus to) =>
    allowedTransitions[from]?.contains(to) ?? false;
