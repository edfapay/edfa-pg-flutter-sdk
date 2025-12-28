package com.edfapg.flutter.sdk.eventhandlers

import android.content.Context
import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.EdfaSadadPay
import com.google.gson.Gson
import io.flutter.plugin.common.EventChannel

class SadadPayEventHandler(private val context: Context): EventChannel.StreamHandler {
    var sink:EventChannel.EventSink? = null
    private val gson = Gson()

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        (arguments as? Map<*, *>)?.let {
            with(it) {
                val orderId = (get("orderId") as? String)
                val orderDescription = (get("orderDescription") as? String)
                val amount = (get("amount") as? Double) ?: 0.0
                val customerName = (get("customerName") as? String)
                val mobileNumber = (get("mobileNumber") as? String)

                payWithSadad(orderId, orderDescription,amount, customerName, mobileNumber)
            }
        }
    }

    override fun onCancel(arguments: Any?) {

    }


    fun payWithSadad(orderId: String?, orderDescription: String?, amount: Double, customerName: String?, mobileNumber: String?){
        EdfaSadadPay()
            .setOrderId(orderId ?: "")
            .setOrderDescription(orderDescription ?: "")
            .setOrderAmount(amount)
            .setCustomerName(customerName ?: "")
            .setMobileNumber(mobileNumber ?: "")
            .onFailure { errors, exception ->
                print("${errors?.message} $exception")
                sink?.success(mapOf("error" to errors?.toMap()))
            }.onSuccess { res ->
                sink?.success(mapOf("success" to res.toMap()))
            }.initialize(
                onError = {
                    sink?.success(mapOf("error" to it))
                }
            )
    }
}