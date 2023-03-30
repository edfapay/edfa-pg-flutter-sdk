package com.expresspay.fluttersdk.eventhandlers

import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidResult
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidSuccess
import com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayGetTransactionDetailsCallback
import com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayGetTransactionDetailsResponse
import com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayGetTransactionDetailsResult
import com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayGetTransactionDetailsSuccess
import com.expresspay.sdk.model.response.sale.*
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
                        } ?: "Missing 'ExpresspayPayer' parameter"
                    } ?: "Missing 'transactionId' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun txnDetails(payerEmail:String, cardNumber:String, transactionId:String){
        ExpresspaySdk.Adapter.GET_TRANSACTION_DETAILS.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            callback = object : ExpresspayGetTransactionDetailsCallback {
                override fun onResponse(response: ExpresspayGetTransactionDetailsResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: ExpresspayGetTransactionDetailsResult) {
                    val res = result.result
                    when (res) {
                        is ExpresspayGetTransactionDetailsSuccess -> send(mapOf("success" to res.toMap()))
                    }
                }

                override fun onError(error: ExpresspayError){
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