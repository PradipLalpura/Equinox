import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import '../domain/upi/upi.dart';

// UPIAppLauncher (§22): installed detection via our own MethodChannel
// (PackageManager — no discontinued third-party dep), per-app targeted
// launch via android_intent_plus, generic chooser fallback. No fake APIs:
// Android UPI apps return no structured result, so reconcile is explicit.
class UpiLauncher {
  static const _channel = MethodChannel('equinox/upi');
  final Map<String, bool> _cache = {};

  Future<bool> isInstalled(String package) async {
    if (_cache.containsKey(package)) return _cache[package]!;
    try {
      final ok = await _channel.invokeMethod<bool>(
              'isAppInstalled', {'package': package}) ??
          false;
      _cache[package] = ok;
      return ok;
    } on PlatformException {
      return false;
    }
  }

  Future<Map<UpiApp, bool>> installedStates() async {
    final out = <UpiApp, bool>{};
    for (final app in upiApps) {
      out[app] = await isInstalled(app.packageName);
    }
    return out;
  }

  /// Launches [upiUri]. When [package] is confirmed installed the intent
  /// targets it exactly; otherwise (or when null) Android shows a chooser.
  /// Throws only if NOTHING on the device handles upi:// — UI catches that.
  Future<void> launch(Uri upiUri, {String? package}) {
    return AndroidIntent(
      action: 'action_view',
      data: upiUri.toString(),
      package: package,
    ).launch();
  }
}

final upiLauncher = UpiLauncher();
