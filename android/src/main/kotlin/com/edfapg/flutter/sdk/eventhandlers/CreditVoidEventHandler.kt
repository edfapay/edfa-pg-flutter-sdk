package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.creditvoid.EdfaPgCreditvoidCallback
import com.edfapg.sdk.model.response.creditvoid.EdfaPgCreditvoidResponse
import com.edfapg.sdk.model.response.creditvoid.EdfaPgCreditvoidResult
import com.edfapg.sdk.model.response.creditvoid.EdfaPgCreditvoidSuccess
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
                        } ?: "Missing 'EdfaPgPayer' parameter"
                    } ?: "Missing 'transactionId' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun creditVoid(payerEmail:String, cardNumber:String, transactionId:String, amount:Double?){
        EdfaPgSdk.Adapter.CREDITVOID.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            amount = amount,
            callback = object : EdfaPgCreditvoidCallback {
                override fun onResponse(response: EdfaPgCreditvoidResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: EdfaPgCreditvoidResult) {
                    val res = result.result
                    when (res) {
                        is EdfaPgCreditvoidSuccess -> send(mapOf("success" to res.toMap()))
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