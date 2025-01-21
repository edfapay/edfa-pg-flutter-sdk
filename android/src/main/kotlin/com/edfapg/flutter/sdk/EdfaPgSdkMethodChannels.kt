package com.edfapg.flutter.sdk

import android.content.Context
import android.util.Log
import com.edfapg.flutter.sdk.methodhandlers.ConfigMethodHandler
import com.edfapg.flutter.sdk.methodhandlers.PlatformVersionMethodHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** EdfaPgSdkPlugin */
class EdfaPgSdkMethodChannels{

    private val methodGetPlatformVersion = "getPlatformVersion"
    private val methodConfig = "config"

    private var channel: MethodChannel? = null;
    private var context: Context? = null


    public fun initiate(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding, context: Context) {
        this.context = context
        channel = MethodChannel(flutterPluginBinding.binaryMessenger,"com.edfapg.flutter.sdk")
        Log.d("EdfaPgSdkPluginMethod", "initiate")

        channel?.setMethodCallHandler { call, result ->
            when (call.method) {
                methodConfig -> ConfigMethodHandler(context, call, result).handle()
                methodGetPlatformVersion -> PlatformVersionMethodHandler(call, result).handle()
                else -> {
                    result.notImplemented()
                }
            }
        }

    }
}
