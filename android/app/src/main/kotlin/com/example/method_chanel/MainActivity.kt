package com.example.method_chanel

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent // <-- Add this line
import com.zing.zalo.zalosdk.oauth.ZaloSDK // <-- Add this line

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.d("RECEIVE", "Receive Channel " + call.method)
           when(call.method){
               METHOD1 -> {
                   val intent = Intent(this, NativeActivity::class.java)
                   startActivity(intent)
                   result.success("result return from native")
               }
               METHOD2 -> {
                   val intent = Intent(this, LoginActivity::class.java)
                   startActivity(intent)
                   result.success("result return from login activity")
               }
           }
        }
    }

     override fun onActivityResult(requestCode:Int, resultCode:Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
        ZaloSDK.Instance.onActivityResult(this, requestCode, resultCode, data) // <-- Add this line
    }

    companion object {
        const val CHANNEL = "NativeChannel"
        const val METHOD1 = "method1"
        const val METHOD2 = "method2"
    }
}
