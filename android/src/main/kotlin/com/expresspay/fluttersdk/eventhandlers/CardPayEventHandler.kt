package com.expresspay.fluttersdk.eventhandlers

import android.content.Context
import com.expresspay.fluttersdk.helper.Helper
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.request.order.ExpresspaySaleOrder
import com.expresspay.sdk.model.request.payer.ExpresspayPayer
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.base.result.IExpresspayResult
import com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayGetTransactionDetailsSuccess
import com.expresspay.sdk.views.expresscardpay.ExpressCardPay
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

class CardPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            with(it) {
                (get("ExpresspaySaleOrder") as? Map<*, *>)?.let { orderMap ->
                    (get("ExpresspayPayer") as? Map<*, *>)?.let { payerMap ->
                        val order = Gson().fromJson(Gson().toJson(orderMap), ExpresspaySaleOrder::class.java)
                        val payer = Gson().fromJson(Gson().toJson(payerMap), ExpresspayPayer::class.java)
                        payWithCard(order, payer)
                    }
                }
            }
        }

    }

    override fun onCancel(arguments: Any?) {

    }

    fun payWithCard(order:ExpresspaySaleOrder, payer:ExpresspayPayer){

        val expressCardPay = ExpressCardPay()
            .setOrder(order)
            .setPayer(payer)
            .onTransactionFailure { res, data ->
                print("$res $data")
                handleFailure(data!!)
            }.onTransactionSuccess { res, data ->
                print("$res $data")
                handleSuccess(data as? ExpresspayGetTransactionDetailsSuccess)
            }

        /*
        * Precise way to start card payment (ready to use)
        * */
        expressCardPay.initialize(
            context,
            onError = {
                handleFailure(it)
            },
            onPresent = {
                onPresent()
            }
        )


        /*
        * To get intent of card screen activity to present in your own choice (ready to use)
        * */
//        startActivity(expressCardPay.intent(
//            this,
//            onError = {
//
//            },
//            onPresent = {
//
//            })
//        )


        /*
        * To get fragment of card screen to present in your own choice (ready to use)
        * */
//        expressCardPay.fragment(
//            onError = {
//
//            },
//            onPresent = {
//
//            }
//        )
    }



    private fun onPresent(){
        print("onPresent :)")
        sink?.success(
            mapOf(
                "onPresent" to ":)"
            )
        )
    }

    private fun handleSuccess(response: ExpresspayGetTransactionDetailsSuccess?){
        print("native.transactionSuccess.data ==> ${response?.toMap()}")
        sink?.success(
            mapOf(
                "success" to response?.toMap()
            )
        )
    }

    private fun handleFailure(error:Any){
        when (error) {
            is  ExpresspayError -> sink?.success(
                mapOf("error" to error.toMap())
            )
            is Serializable -> sink?.success(
                mapOf("failure" to error.toMap())
            )
            else -> sink?.success(
                mapOf(
                    "error" to mapOf(
                        "result" to "ERROR",
                        "error_code" to 100000,
                        "error_message" to "$error",
                        "errors" to listOf<Map<*,*>>(),
                    )
                )
            )

        }
    }
}