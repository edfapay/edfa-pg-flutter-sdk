package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.capture.EdfaPgCaptureCallback
import com.edfapg.sdk.model.response.capture.EdfaPgCaptureResponse
import com.edfapg.sdk.model.response.capture.EdfaPgCaptureResult
import com.edfapg.sdk.model.response.capture.EdfaPgCaptureSuccess
import com.edfapg.sdk.model.response.sale.*
import io.flutter.plugin.common.EventChannel


class CaptureEventHandler: EventChannel.StreamHandler {
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
                                capture(payerEmail = payerEmail, cardNumber = cardNumber, transactionId = txnId, amount = amount)

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

    fun capture(payerEmail:String, cardNumber:String, transactionId:String, amount:Double?){
        EdfaPgSdk.Adapter.CAPTURE.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            amount = amount,
            callback = object : EdfaPgCaptureCallback {
                override fun onResponse(response: EdfaPgCaptureResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: EdfaPgCaptureResult) {
                    val res = result.result
                    when (res) {
                        is EdfaPgCaptureSuccess -> send(mapOf("decline" to res.toMap()))
                        is EdfaPgSaleDecline -> send(mapOf("success" to res.toMap()))
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