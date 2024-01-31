package com.edfapg.flutter.sdk.eventhandlers

import com.edfapg.flutter.sdk.helper.toMap
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusCallback
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusResponse
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusResult
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusSuccess
import io.flutter.plugin.common.EventChannel


class GetTransactionStatusEventHandler : EventChannel.StreamHandler {
    var sink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events

        (arguments as? Map<*, *>)?.let {
            print(
                with(it) {
                    (get("transactionId") as? String)?.let { txnId ->
                        (get("payerEmail") as? String)?.let { payerEmail ->
                            (get("cardNumber") as? String)?.let { cardNumber ->

                                txnStatus(
                                    payerEmail = payerEmail,
                                    cardNumber = cardNumber,
                                    transactionId = txnId
                                )

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

    fun txnStatus(payerEmail: String, cardNumber: String, transactionId: String) {
        EdfaPgSdk.Adapter.GET_TRANSACTION_STATUS.execute(
            payerEmail = payerEmail,
            cardNumber = cardNumber,
            transactionId = transactionId,
            callback = object : EdfaPgGetTransactionStatusCallback {
                override fun onResponse(response: EdfaPgGetTransactionStatusResponse) {
                    send(mapOf("responseJSON" to response.toMap()))
                    super.onResponse(response)
                }

                override fun onResult(result: EdfaPgGetTransactionStatusResult) {
                    val res = result.result
                    when (res) {
                        is EdfaPgGetTransactionStatusSuccess -> send(mapOf("success" to res.toMap()))
                    }
                }

                override fun onError(error: EdfaPgError) {
                    send(mapOf("error" to error.toMap()))
                }

                override fun onFailure(throwable: Throwable) {
                    send(mapOf("failure" to throwable.toMap()))
                    super.onFailure(throwable)
                }
            }
        )

    }

    private fun send(map: Map<*, *>) {
        sink?.success(map)
    }
}