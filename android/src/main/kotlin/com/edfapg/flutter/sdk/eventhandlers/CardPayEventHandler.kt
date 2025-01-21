package com.edfapg.flutter.sdk.eventhandlers

import android.content.Context
import android.widget.Toast
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.model.request.card.EdfaPgCard
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactiondetails.EdfaPgGetTransactionDetailsSuccess
import com.edfapg.sdk.toolbox.DesignType
import com.edfapg.sdk.toolbox.EdfaLocale
import com.edfapg.sdk.views.edfacardpay.EdfaCardPay
import com.edfapg.sdk.views.edfacardpay.EdfaPayWithCardDetails
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

class CardPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            with(it) {
                (get("EdfaPgSaleOrder") as? Map<*, *>)?.let { orderMap ->
                    (get("EdfaPgPayer") as? Map<*, *>)?.let { payerMap ->
                        val order = Gson().fromJson(Gson().toJson(orderMap), EdfaPgSaleOrder::class.java)
                        val payer = Gson().fromJson(Gson().toJson(payerMap), EdfaPgPayer::class.java)
                        val design = (get("DesignType") as? String)
                        val locale = (get("EdfaLocale") as? String)
                        val dType = DesignType.values().firstOrNull { it.value == design} ?: DesignType.PAYMENT_DESIGN_1
                        val mLocale = EdfaLocale.values().firstOrNull { it.value == locale} ?: EdfaLocale.EN

                        payWithCard(order, payer, dType, mLocale)
//                        payWithCardDetails(order, payer)

                    }

                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {

    }


    fun payWithCard(order:EdfaPgSaleOrder, payer:EdfaPgPayer, designType:DesignType, locale:EdfaLocale){

        val expressCardPay = EdfaCardPay()
            .setOrder(order)
            .setPayer(payer)
            .onTransactionFailure { res, data ->
                print("$res $data")
                handleFailure(data!!)
            }.onTransactionSuccess { res, data ->
                print("$res $data")
                handleSuccess(data as? EdfaPgGetTransactionDetailsSuccess)
            }

        /*
        * Precise way to start card payment (ready to use)
        * */
        expressCardPay.initialize(
            designType = designType,
            locale = locale,
            context = context,
            onError = {
                handleFailure(it)
            },
            onPresent = {
                onPresent()
            })

    }


    fun payWithCardDetails(order:EdfaPgSaleOrder, payer:EdfaPgPayer){

        val card = EdfaPgCard("4458271329748293", 7, 2029, "331")



        EdfaPayWithCardDetails(context = context)
            .setOrder(order)
            .setPayer(payer)
            .setCard(card)
            .onTransactionFailure { res, data ->
                print("$res $data")
                Toast.makeText(context, "Transaction Failure", Toast.LENGTH_LONG).show()
            }.onTransactionSuccess { res, data ->
                print("$res $data")
                Toast.makeText(context, "Transaction Success", Toast.LENGTH_LONG).show()
            }
            .initialize(
                onError = {
                    Toast.makeText(context, "onError $it", Toast.LENGTH_LONG).show()
                },
                onPresent = {

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