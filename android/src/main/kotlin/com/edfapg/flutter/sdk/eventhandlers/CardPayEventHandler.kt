package com.edfapg.flutter.sdk.eventhandlers

import android.content.Context
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.request.Extra
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsSuccess
import com.edfapg.sdk.toolbox.EdfaPayDesignType
import com.edfapg.sdk.toolbox.EdfaPayLanguage
import com.edfapg.sdk.views.edfacardpay.EdfaCardPay
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

internal val ExtrasType = object : TypeToken<List<Extra>>() {}.type
class CardPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null
    private val gson = Gson()

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            with(it) {
                (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                    (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                        val extrasJson = (get("extras") as? List<*>) ?: listOf<Map<String,*>>()
                        val extras:List<Extra> = gson.fromJson(gson.toJson(extrasJson), ExtrasType)

                        val order = gson.fromJson(gson.toJson(orderMap), EdfaPgSaleOrder::class.java)
                        val payer = gson.fromJson(gson.toJson(payerMap), EdfaPgPayer::class.java)
                        val design = (get("EdfaPayDesignType") as? String)
                        val locale = (get("EdfaPayLanguage") as? String)
                        val recurring = (get("recurring") as? Boolean) ?: false
                        val auth = (get("auth") as? Boolean) ?: false
                        val dType = EdfaPayDesignType.values().firstOrNull { it.value == design} ?: EdfaPayDesignType.one
                        val mLocale = EdfaPayLanguage.values().firstOrNull { it.value == locale} ?: EdfaPayLanguage.en

                        payWithCard(order, payer,extras, dType, mLocale, recurring, auth)
                    }

                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {

    }


    fun payWithCard(order:EdfaPgSaleOrder, payer:EdfaPgPayer, extras:List<Extra>, designType:EdfaPayDesignType, locale:EdfaPayLanguage,
                    recurring:Boolean, auth:Boolean){
        EdfaCardPay()
            .setOrder(order)
            .setPayer(payer)
            .setExtras(extras)
            .setDesignType(designType)
            .setLanguage(locale)
            .setRecurring(recurring)
            .setAuth(auth)
            .onTransactionFailure { res, data ->
                print("$res $data")
                handleFailure(data!!)
            }.onTransactionSuccess { res, data ->
                print("$res $data")
                handleSuccess(data as? EdfaPgGetTransactionDetailsSuccess)
            }.initialize(
                context = context,
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