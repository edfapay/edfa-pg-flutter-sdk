package com.expresspay.fluttersdk.eventhandlers

import com.expresspay.sdk.core.ExpresspaySdk
import com.expresspay.fluttersdk.helper.toMap
import com.expresspay.sdk.model.request.options.ExpresspayRecurringOptions
import com.expresspay.sdk.model.request.order.ExpresspayOrder
import com.expresspay.sdk.model.response.base.error.ExpresspayError
import com.expresspay.sdk.model.response.sale.*
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel


class RecurringSaleEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("ExpresspayOrder") as? Map<*, *>)?.let { orderMap ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->
                                (get("ExpresspayRecurringOptions") as? Map<*, *>)?.let { recOptionMap ->
                                    (get("auth") as? Boolean)?.let { auth ->
                                        val order = Gson().fromJson(Gson().toJson(orderMap), ExpresspayOrder::class.java)
                                        val recurringOptions = Gson().fromJson(Gson().toJson(recOptionMap), ExpresspayRecurringOptions::class.java)

                                        recurringSale(auth = auth, order = order, payerEmail = payerEmail, cardNumber = cardNumber, recurringOptions = recurringOptions);

                                        "All params are valid"
                                    } ?: "Missing 'Boolean' auth parameter"
                                } ?: "Missing 'ExpresspayRecurringOptions' auth parameter"
                            } ?: "Missing 'cardNumber' parameter"
                        } ?: "Missing 'payerEmail' parameter"
                    } ?: "Missing 'ExpresspayOrder' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun recurringSale(auth:Boolean, order:ExpresspayOrder, payerEmail:String, cardNumber:String, recurringOptions:ExpresspayRecurringOptions){
        ExpresspaySdk.Adapter.RECURRING_SALE.execute(
            auth = auth,
            order = order,
            cardNumber = cardNumber,
            options = recurringOptions,
            payerEmail = payerEmail,
            callback = object : ExpresspaySaleCallback {
                override fun onResponse(response: ExpresspaySaleResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: ExpresspaySaleResult) {
                    val res = result.result
                    when (res) {
                        is ExpresspaySaleDecline -> send(mapOf("decline" to res.toMap()))
                        is ExpresspaySaleRecurring -> send(mapOf("recurring" to res.toMap()))
                        is ExpresspaySaleRedirect -> send(mapOf("redirect" to res.toMap()))
                        is ExpresspaySale3Ds -> send(mapOf("secure3d" to res.toMap()))
                        is ExpresspaySaleSuccess -> send(mapOf("success" to res.toMap()))
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