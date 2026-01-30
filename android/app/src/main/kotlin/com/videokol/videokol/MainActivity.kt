//package com.videokol.videokol
//
//import android.app.PictureInPictureParams
//import android.os.Build
//import android.util.Rational
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity: FlutterActivity() {
//    private val CHANNEL = "flutter_pip"
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "enterPiP") {
//                enterPiP()
//                result.success(true)
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun enterPiP() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val aspectRatio = Rational(16, 9)
//            val params = PictureInPictureParams.Builder()
//                .setAspectRatio(aspectRatio)
//                .build()
//            enterPictureInPictureMode(params)
//        }
//    }
//
//    override fun onUserLeaveHint() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            enterPiP()
//        }
//        super.onUserLeaveHint()
//    }
//}

package com.videokol.videokol

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    // KOSONG – FlutterForegroundTask yang handle status bar
}
