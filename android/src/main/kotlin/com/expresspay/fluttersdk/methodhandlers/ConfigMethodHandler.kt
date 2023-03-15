package com.expresspay.fluttersdk.methodhandlers

import android.content.Context
import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.sdk.model.request.order.ExpresspaySaleOrder
import com.expresspay.sdk.model.request.payer.ExpresspayPayer
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class ConfigMethodHandler(private val context:Context, private val call:MethodCall, private val result: MethodChannel.Result) {

    fun handle(){
        (call.arguments as? List<*>)?.let {
            with(it) {
                (get(0) as? String)?.let { key ->
                    (get(1) as? String)?.let { password ->
                        (get(2) as? Boolean)?.let { enableDebug ->
                            ExpresspaySdk.init(context, key, password, "https://api.expresspay.sa/post")
                        }
                    }
                }
            }
        }
    }

}