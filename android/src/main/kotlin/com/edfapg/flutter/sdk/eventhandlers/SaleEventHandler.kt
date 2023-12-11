package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.request.card.EdfaPgCard
import com.edfapg.sdk.model.request.options.EdfaPgSaleOptions
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.sale.*
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel


class SaleEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                        (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                            (get("EdfaPgCard") as? Map<*, *>)?.let { cardMap ->
                                (get("auth") as? Boolean)?.let { auth ->

                                    val order = Gson().fromJson(Gson().toJson(orderMap), EdfaPgSaleOrder::class.java)
                                    val payer = Gson().fromJson(Gson().toJson(payerMap), EdfaPgPayer::class.java)
                                    val card = Gson().fromJson(Gson().toJson(cardMap), EdfaPgCard::class.java)

                                    var options: EdfaPgSaleOptions? = null
                                    (get("EdfaPgSaleOption") as? Map<*, *>)?.let {
                                        options = Gson().fromJson(Gson().toJson(payerMap), EdfaPgSaleOptions::class.java)
                                    }

                                    sale(auth = auth, order = order, payer = payer, card = card, saleOptions = options)

                                    "All params are valid"
                                } ?: "Missing 'Boolean' auth parameter"
                            } ?: "Missing 'EdfaPgCard' parameter"
                        } ?: "Missing 'EdfaPgPayer' parameter"
                    } ?: "Missing 'EdfaPgSaleOrder' parameter"
                }
            )
        }

    }

    override fun onCancel(arguments: Any?) {
    }

    fun sale(auth:Boolean, order:EdfaPgSaleOrder, payer:EdfaPgPayer, card:EdfaPgCard, saleOptions:EdfaPgSaleOptions?){
        EdfaPgSdk.Adapter.SALE.execute(
            order = order,
            card = card,
            payer = payer,
            termUrl3ds = "https://pay.EdfaPg.sa/",
            options = saleOptions,
            auth = auth,
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