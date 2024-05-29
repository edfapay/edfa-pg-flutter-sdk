package com.edfapg.flutter.sdk.methodhandlers

import android.content.Context
import com.edfapg.flutter.sdk.ENABLE_DEBUG
import com.edfapg.flutter.sdk.PAYMENT_URL
import com.edfapg.sdk.core.EdfaPgSdk
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class ConfigMethodHandler(
    private val context: Context,
    private val call: MethodCall,
    private val result: MethodChannel.Result
) {

    fun handle() {
        (call.arguments as? List<*>)?.let {
            with(it) {
                (get(0) as? String)?.let { key ->
                    (get(1) as? String)?.let { password ->
                        EdfaPgSdk.init(context, key, password, PAYMENT_URL)
                        (get(2) as? Boolean)?.let { enableDebug ->
                            ENABLE_DEBUG = enableDebug
                            if (ENABLE_DEBUG)
                                EdfaPgSdk.enableDebug()
                            else
                                EdfaPgSdk.disableDebug()
                        }
                    }
                }
            }
        }
    }

}