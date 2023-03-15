package com.expresspay.fluttersdk

import android.content.Context
import com.expresspay.fluttersdk.methodhandlers.ConfigMethodHandler
import com.expresspay.fluttersdk.methodhandlers.PlatformVersionMethodHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** ExpresspaySdkPlugin */
class ExpresspaySdkMethodChannels{

    private val methodGetPlatformVersion = "getPlatformVersion"
    private val methodConfig = "config"

    private var channel: MethodChannel? = null;
    private var context: Context? = null


    public fun initiate(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding, context: Context) {
        this.context = context
        channel = MethodChannel(flutterPluginBinding.binaryMessenger,"com.expresspay.sdk")

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
