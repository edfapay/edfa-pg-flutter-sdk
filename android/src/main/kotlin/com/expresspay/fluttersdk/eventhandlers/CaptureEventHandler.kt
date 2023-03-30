package com.expresspay.fluttersdk.eventhandlers

import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.request.card.ExpresspayCard
import com.expresspay.sdk.model.request.options.ExpresspayRecurringOptions
import com.expresspay.sdk.model.request.options.ExpresspaySaleOptions
import com.expresspay.sdk.model.request.order.ExpresspayOrder
import com.expresspay.sdk.model.request.order.ExpresspaySaleOrder
import com.expresspay.sdk.model.request.payer.ExpresspayPayer
import com.expresspay.sdk.model.response.base.ExpresspayResponse
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.capture.ExpresspayCaptureCallback
import com.expresspay.sdk.model.response.capture.ExpresspayCaptureResponse
import com.expresspay.sdk.model.response.capture.ExpresspayCaptureResult
import com.expresspay.sdk.model.response.capture.ExpresspayCaptureSuccess
import com.expresspay.sdk.model.response.sale.*
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel
import kotlin.math.sin


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
                        } ?: "Missing 'ExpresspayPayer' parameter"
                    } ?: "Missing 'transactionId' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun capture(payerEmail:String, cardNumber:String, transactionId:String, amount:Double?){
        ExpresspaySdk.Adapter.CAPTURE.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            amount = amount,
            callback = object : ExpresspayCaptureCallback {
                override fun onResponse(response: ExpresspayCaptureResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: ExpresspayCaptureResult) {
                    val res = result.result
                    when (res) {
                        is ExpresspayCaptureSuccess -> send(mapOf("decline" to res.toMap()))
                        is ExpresspaySaleDecline -> send(mapOf("success" to res.toMap()))
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