package com.equinox.app.equinox

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// Native seam: per-app installed detection + full UPI-handler discovery.
// Discovery beats hardcoding: any app that resolves upi://pay (GPay, BHIM,
// future apps) is found, and anything found is guaranteed launchable.
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "equinox/upi")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAppInstalled" -> {
                        val pkg = call.argument<String>("package") ?: ""
                        result.success(isInstalled(pkg))
                    }
                    "getUpiApps" -> result.success(upiApps())
                    else -> result.notImplemented()
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

    private fun upiApps(): List<Map<String, String>> {
        val probe = Intent(
            Intent.ACTION_VIEW,
            Uri.parse("upi://pay?pa=probe@upi")
        )
        return packageManager
            .queryIntentActivities(probe, PackageManager.MATCH_ALL)
            .mapNotNull {
                val pkg = it.activityInfo?.packageName ?: return@mapNotNull null
                val label = try {
                    it.loadLabel(packageManager)?.toString()
                } catch (_: Exception) {
                    null
                }.takeUnless { s -> s.isNullOrBlank() } ?: pkg
                mapOf("package" to pkg, "label" to label)
            }
            .distinctBy { it["package"] }
            .sortedBy { it["label"] }
    }
}
