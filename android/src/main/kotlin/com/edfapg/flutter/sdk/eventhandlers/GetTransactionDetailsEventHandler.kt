package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsCallback
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsResponse
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsResult
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsSuccess
import com.edfapg.sdk.model.response.sale.*
import io.flutter.plugin.common.EventChannel


class GetTransactionDetailsEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("transactionId") as? String)?.let { txnId ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->

                                txnDetails(payerEmail = payerEmail, cardNumber = cardNumber, transactionId = txnId)

                                "All params are valid"
                            } ?: "Missing 'cardNumber' parameter"
                        } ?: "Missing 'EdfaPgPayer' parameter"
                    } ?: "Missing 'transactionId' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun txnDetails(payerEmail:String, cardNumber:String, transactionId:String){
        EdfaPgSdk.Adapter.GET_TRANSACTION_DETAILS.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            callback = object : EdfaPgGetTransactionDetailsCallback {
                override fun onResponse(response: EdfaPgGetTransactionDetailsResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: EdfaPgGetTransactionDetailsResult) {
                    val res = result.result
                    when (res) {
                        is EdfaPgGetTransactionDetailsSuccess -> send(mapOf("success" to res.toMap()))
                    }
                }

                override fun onError(error: EdfaPgError){
                    send(mapOf("error" to error.toMap()))
                }

                override fun onFailure(throwable: Throwable) {
                    send(mapOf("failure" to throwable.toMap()))
                    super.onFailure(throwable)
                }
            }
        )

    }

    private fun send(map:Map<*,*>){
        sink?.success(map)
    }
}