package com.equinox.app.equinox

import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// Single native seam for Phase 3: per-app installed detection via
// PackageManager. (Manifest <queries> already lists the 5 UPI packages.)
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "equinox/upi")
            .setMethodCallHandler { call, result ->
                if (call.method == "isAppInstalled") {
                    val pkg = call.argument<String>("package") ?: ""
                    result.success(isInstalled(pkg))
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun isInstalled(pkg: String): Boolean {
        if (pkg.isEmpty()) return false
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(pkg, PackageManager.PackageInfoFlags.of(0))
            } else {
                @Suppress("DEPRECATION")
                packageManager.getPackageInfo(pkg, 0)
            }
            true
        } catch (_: PackageManager.NameNotFoundException) {
            false
        }
    }
}
