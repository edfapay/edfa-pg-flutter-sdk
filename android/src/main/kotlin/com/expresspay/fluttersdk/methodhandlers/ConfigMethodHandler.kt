package com.expresspay.fluttersdk.methodhandlers

import android.content.Context
import com.expresspay.fluttersdk.ENABLE_DEBUG
import com.expresspay.sdk.core.ExpresspaySdk
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class ConfigMethodHandler(private val context:Context, private val call:MethodCall, private val result: MethodChannel.Result) {

    fun handle(){
        (call.arguments as? List<*>)?.let {
            with(it) {
                (get(0) as? String)?.let { key ->
                    (get(1) as? String)?.let { password ->
                        ExpresspaySdk.init(context, key, password, "https://api.expresspay.sa/post")
                        (get(2) as? Boolean)?.let { enableDebug ->
                            ENABLE_DEBUG = enableDebug
                        }
                    }
                }
            }
        }
    }

    private fun enableOkHttplogs(){
//        val logging = HttpLoggingInterceptor()
//        logging.setLevel(Level.BASIC)
//        val client: OkHttpClient = Builder()
//            .addInterceptor(logging)
//            .build()
    }

}