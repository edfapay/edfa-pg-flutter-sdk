package com.expresspay.fluttersdk.eventhandlers

import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.gettransactionstatus.ExpresspayGetTransactionStatusCallback
import com.expresspay.sdk.model.response.gettransactionstatus.ExpresspayGetTransactionStatusResponse
import com.expresspay.sdk.model.response.gettransactionstatus.ExpresspayGetTransactionStatusResult
import com.expresspay.sdk.model.response.gettransactionstatus.ExpresspayGetTransactionStatusSuccess
import io.flutter.plugin.common.EventChannel


class GetTransactionStatusEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("transactionId") as? String)?.let { txnId ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->

                                txnStatus(payerEmail = payerEmail, cardNumber = cardNumber, transactionId = txnId)

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

    fun txnStatus(payerEmail:String, cardNumber:String, transactionId:String){
        ExpresspaySdk.Adapter.GET_TRANSACTION_STATUS.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            callback = object : ExpresspayGetTransactionStatusCallback {
                override fun onResponse(response: ExpresspayGetTransactionStatusResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: ExpresspayGetTransactionStatusResult) {
                    val res = result.result
                    when (res) {
                        is ExpresspayGetTransactionStatusSuccess -> send(mapOf("success" to res.toMap()))
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