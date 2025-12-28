package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.flutter.sdk.helper.ExtrasType
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.request.Extra
import com.edfapg.sdk.model.request.card.EdfaPgCard
import com.edfapg.sdk.model.request.options.EdfaPgSaleOptions
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.sale.EdfaPgSale3Ds
import com.edfapg.sdk.model.response.sale.EdfaPgSaleCallback
import com.edfapg.sdk.model.response.sale.EdfaPgSaleDecline
import com.edfapg.sdk.model.response.sale.EdfaPgSaleRecurring
import com.edfapg.sdk.model.response.sale.EdfaPgSaleRedirect
import com.edfapg.sdk.model.response.sale.EdfaPgSaleResponse
import com.edfapg.sdk.model.response.sale.EdfaPgSaleResult
import com.edfapg.sdk.model.response.sale.EdfaPgSaleSuccess
import com.edfapg.sdk.toolbox.EdfaPgUtil
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel


class SaleEventHandler: EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null
    val gson = Gson()
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                        (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                            (get("EdfaPgCard") as? Map<*, *>)?.let { cardMap ->
                                (get("auth") as? Boolean)?.let { auth ->
                                    val extrasJson = (get("extras") as? List<*>) ?: listOf<Map<String,*>>()
                                    val extras:List<Extra> = gson.fromJson(gson.toJson(extrasJson), ExtrasType)

                                    val order = gson.fromJson(gson.toJson(orderMap), EdfaPgSaleOrder::class.java)
                                    val payer = gson.fromJson(gson.toJson(payerMap), EdfaPgPayer::class.java)
                                    val card = gson.fromJson(gson.toJson(cardMap), EdfaPgCard::class.java)

                                    var options: EdfaPgSaleOptions? = null
                                    (get("EdfaPgSaleOption") as? Map<*, *>)?.let {
                                        options = gson.fromJson(gson.toJson(payerMap), EdfaPgSaleOptions::class.java)
                                    }

                                    sale(auth = auth, order = order, extras = extras, payer = payer, card = card, saleOptions = options)

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

    fun sale(auth:Boolean, order:EdfaPgSaleOrder, extras:List<Extra>, payer:EdfaPgPayer, card:EdfaPgCard, saleOptions:EdfaPgSaleOptions?){
        EdfaPgSdk.Adapter.SALE.execute(
            order = order,
            card = card,
            payer = payer,
            extras = extras,
            termUrl3ds = EdfaPgUtil.ProcessCompleteCallbackUrl,
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