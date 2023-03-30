package com.expresspay.fluttersdk.eventhandlers

import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidCallback
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidResponse
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidResult
import com.expresspay.sdk.model.response.creditvoid.ExpresspayCreditvoidSuccess
import io.flutter.plugin.common.EventChannel


class CreditVoidEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("transactionId") as? String)?.let { txnId ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->
                                val amount = (get("amount") as? Double)
                                creditVoid(payerEmail = payerEmail, cardNumber = cardNumber, transactionId = txnId, amount = amount)

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

    fun creditVoid(payerEmail:String, cardNumber:String, transactionId:String, amount:Double?){
        ExpresspaySdk.Adapter.CREDITVOID.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            amount = amount,
            callback = object : ExpresspayCreditvoidCallback {
                override fun onResponse(response: ExpresspayCreditvoidResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: ExpresspayCreditvoidResult) {
                    val res = result.result
                    when (res) {
                        is ExpresspayCreditvoidSuccess -> send(mapOf("success" to res.toMap()))
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