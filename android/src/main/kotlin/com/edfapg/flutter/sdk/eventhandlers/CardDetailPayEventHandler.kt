package com.edfapg.flutter.sdk.eventhandlers

import android.content.Context
import android.widget.Toast
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.request.card.EdfaPgCard
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsSuccess
import com.edfapg.sdk.toolbox.EdfaPayDesignType
import com.edfapg.sdk.toolbox.EdfaPayLanguage
import com.edfapg.sdk.views.edfacardpay.EdfaCardPay
import com.edfapg.sdk.views.edfacardpay.EdfaPayWithCardDetails
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

class CardDetailPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            with(it) {
                (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                    (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                        (get("EdfaPgCard") as? Map<*, *>)?.let { cardMap ->
                            val order = Gson().fromJson(Gson().toJson(orderMap), EdfaPgSaleOrder::class.java)
                            val payer = Gson().fromJson(Gson().toJson(payerMap), EdfaPgPayer::class.java)
                            val card = Gson().fromJson(Gson().toJson(cardMap), EdfaPgCard::class.java)
                            val locale = get("EdfaPayLanguage") as? String
                            val mLocale = EdfaPayLanguage.values().firstOrNull { it.value == locale} ?: EdfaPayLanguage.en
                            val recurring = (get("recurring") as? Boolean ?: false)
                            val auth = (get("auth") as? Boolean ?: false)

                            payWithCardDetails(order, payer, card, mLocale, recurring, auth)
                        }
                    }

                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {

    }

    private fun payWithCardDetails(order:EdfaPgSaleOrder, payer:EdfaPgPayer, card:EdfaPgCard, language:EdfaPayLanguage, recurring:Boolean, auth:Boolean){
        EdfaPayWithCardDetails(context = context)
            .setOrder(order)
            .setPayer(payer)
            .setCard(card)
            .setRecurring(recurring)
            .setAuth(auth)
            .onTransactionFailure { res, data ->
                print("$res $data")
                handleFailure(data!!)

            }.onTransactionSuccess { res, data ->
                print("$res $data")
                handleSuccess(data as? EdfaPgGetTransactionDetailsSuccess)

            }.initialize(
                onError = {
                    handleFailure(it)
                },
                onPresent = {
                    onPresent()
                }
            )
    }


    private fun onPresent(){
        print("onPresent :)")
        sink?.success(
            mapOf(
                "onPresent" to ":)"
            )
        )
    }

    private fun handleSuccess(response: EdfaPgGetTransactionDetailsSuccess?){
        print("native.transactionSuccess.data ==> ${response?.toMap()}")
        sink?.success(
            mapOf(
                "success" to response?.toMap()
            )
        )
    }

    private fun handleFailure(error:Any){
        when (error) {
            is  EdfaPgError -> sink?.success(
                mapOf("error" to error.toMap())
            )
            is Serializable -> sink?.success(
                mapOf("failure" to error.toMap())
            )
            else -> sink?.success(
                mapOf(
                    "error" to mapOf(
                        "result" to "ERROR",
                        "error_code" to 100000,
                        "error_message" to "$error",
                        "errors" to listOf<Map<*,*>>(),
                    )
                )
            )

        }
    }
}