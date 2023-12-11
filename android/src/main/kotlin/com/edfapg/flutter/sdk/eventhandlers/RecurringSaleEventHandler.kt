package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.request.options.EdfaPgRecurringOptions
import com.edfapg.sdk.model.request.order.EdfaPgOrder
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.sale.*
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel


class RecurringSaleEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("EdfaPgOrder") as? Map<*, *>)?.let { orderMap ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->
                                (get("EdfaPgRecurringOptions") as? Map<*, *>)?.let { recOptionMap ->
                                    (get("auth") as? Boolean)?.let { auth ->
                                        val order = Gson().fromJson(Gson().toJson(orderMap), EdfaPgOrder::class.java)
                                        val recurringOptions = Gson().fromJson(Gson().toJson(recOptionMap), EdfaPgRecurringOptions::class.java)

                                        recurringSale(auth = auth, order = order, payerEmail = payerEmail, cardNumber = cardNumber, recurringOptions = recurringOptions);

                                        "All params are valid"
                                    } ?: "Missing 'Boolean' auth parameter"
                                } ?: "Missing 'EdfaPgRecurringOptions' auth parameter"
                            } ?: "Missing 'cardNumber' parameter"
                        } ?: "Missing 'payerEmail' parameter"
                    } ?: "Missing 'EdfaPgOrder' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun recurringSale(auth:Boolean, order:EdfaPgOrder, payerEmail:String, cardNumber:String, recurringOptions:EdfaPgRecurringOptions){
        EdfaPgSdk.Adapter.RECURRING_SALE.execute(
            auth = auth,
            order = order,
            cardNumber = cardNumber,
            options = recurringOptions,
            payerEmail = payerEmail,
            callback = object : EdfaPgSaleCallback {
                override fun onResponse(response: EdfaPgSaleResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: EdfaPgSaleResult) {
                    val res = result.result
                    when (res) {
                        is EdfaPgSaleDecline -> send(mapOf("decline" to res.toMap()))
                        is EdfaPgSaleRecurring -> send(mapOf("recurring" to res.toMap()))
                        is EdfaPgSaleRedirect -> send(mapOf("redirect" to res.toMap()))
                        is EdfaPgSale3Ds -> send(mapOf("secure3d" to res.toMap()))
                        is EdfaPgSaleSuccess -> send(mapOf("success" to res.toMap()))
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