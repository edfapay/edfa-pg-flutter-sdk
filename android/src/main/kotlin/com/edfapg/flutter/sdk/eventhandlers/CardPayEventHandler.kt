package com.edfapg.flutter.sdk.eventhandlers

import android.content.Context
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsSuccess
import com.edfapg.sdk.views.edfacardpay.EdfaCardPay
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

class CardPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            with(it) {
                (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                    (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                        val order = Gson().fromJson(Gson().toJson(orderMap), EdfaPgSaleOrder::class.java)
                        val payer = Gson().fromJson(Gson().toJson(payerMap), EdfaPgPayer::class.java)
                        payWithCard(order, payer)
                    }
                }
            }
        }

    }

    override fun onCancel(arguments: Any?) {

    }

    fun payWithCard(order:EdfaPgSaleOrder, payer:EdfaPgPayer){

        val expressCardPay = EdfaCardPay()
            .setOrder(order)
            .setPayer(payer)
            .onTransactionFailure { res, data ->
                print("$res $data")
                handleFailure(data!!)
            }.onTransactionSuccess { res, data ->
                print("$res $data")
                handleSuccess(data as? EdfaPgGetTransactionDetailsSuccess)
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

    private fun handleSuccess(response: EdfaPgGetTransactionDetailsSuccess?){
        print("native.transactionSuccess.data ==> ${response?.toMap()}")
        sink?.success(
            mapOf(
                "success" to response?.toMap()
            )
        )
    }

    private fun handleFailure(error:Any){
        when (error) {
            is  EdfaPgError -> sink?.success(
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