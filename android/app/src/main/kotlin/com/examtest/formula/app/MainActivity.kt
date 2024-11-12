package com.examtest.formula.app
import android.view.WindowManager.LayoutParams

import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.FlutterEngine
class MainActivity: FlutterActivity() {
    private val CHANNEL = "app_metadata"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)

        io.flutter.plugin.common.MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setApplicationId" -> {
                    val apiKey: String? = call.argument("apiKey")
                    if (apiKey != null) {
                        try {
                            val applicationInfo = packageManager.getApplicationInfo(
                                packageName,
                                android.content.pm.PackageManager.GET_META_DATA
                            )
                            applicationInfo.metaData.putString("com.google.android.gms.ads.APPLICATION_ID", apiKey)
                            println("Application ID received: $apiKey")
//                            android.widget.Toast.makeText(this, "Application ID set to: $apiKey", android.widget.Toast.LENGTH_LONG)
//                                .show()
                            result.success("Application ID set to: $apiKey")
                        } catch (e: Exception) {
                            result.error("METADATA_ERROR", "Failed to update APPLICATION_ID", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "API Key is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}