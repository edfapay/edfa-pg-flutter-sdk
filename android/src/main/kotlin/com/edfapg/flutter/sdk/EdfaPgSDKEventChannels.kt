package com.edfapg.flutter.sdk

import android.content.Context
import android.util.Log
import com.edfapg.flutter.sdk.eventhandlers.CaptureEventHandler
import com.edfapg.flutter.sdk.eventhandlers.CardDetailPayEventHandler
import com.edfapg.flutter.sdk.eventhandlers.CardPayEventHandler
import com.edfapg.flutter.sdk.eventhandlers.CreditVoidEventHandler
import com.edfapg.flutter.sdk.eventhandlers.GetTransactionDetailsEventHandler
import com.edfapg.flutter.sdk.eventhandlers.GetTransactionStatusEventHandler
import com.edfapg.flutter.sdk.eventhandlers.RecurringSaleEventHandler
import com.edfapg.flutter.sdk.eventhandlers.SaleEventHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/** EdfaPgSdkPlugin */
class EdfaPgSDKEventChannels {

    var cardpay: EventChannel? = null;
    var cardDetailPay: EventChannel? = null;
    var applepay: EventChannel? = null;

    var sale: EventChannel? = null;
    var recurringSale: EventChannel? = null;
    var capture: EventChannel? = null;
    var creditVoid: EventChannel? = null;
    var transactionStatus: EventChannel? = null;
    var transactionDetail: EventChannel? = null;
    var transactionLogs: EventChannel? = null;


    fun initiate(
        flutterPluginBinding: FlutterPlugin.FlutterPluginBinding,
        context: Context
    ) {
        val messenger = flutterPluginBinding.binaryMessenger
        Log.d("EdfaPgSdkPluginEvent", "initiate")
        cardpay = EventChannel(messenger, "com.edfapg.flutter.sdk.cardpay")
        cardDetailPay = EventChannel(messenger, "com.edfapg.flutter.sdk.cardDetailPay")
        sale = EventChannel(messenger, "com.edfapg.flutter.sdk.sale")
        recurringSale = EventChannel(messenger, "com.edfapg.flutter.sdk.recurringsale")
        capture = EventChannel(messenger, "com.edfapg.flutter.sdk.capture")
        creditVoid = EventChannel(messenger, "com.edfapg.flutter.sdk.creditvoid")
        transactionStatus = EventChannel(messenger, "com.edfapg.flutter.sdk.transactionstatus")
        transactionDetail = EventChannel(messenger, "com.edfapg.flutter.sdk.transactiondetail")
        transactionLogs = EventChannel(messenger, "com.edfapg.flutter.sdk.transactionlogs")

        sale?.setStreamHandler(SaleEventHandler())
        recurringSale?.setStreamHandler(RecurringSaleEventHandler())
        capture?.setStreamHandler(CaptureEventHandler())
        creditVoid?.setStreamHandler(CreditVoidEventHandler())
        transactionStatus?.setStreamHandler(GetTransactionStatusEventHandler())
        transactionDetail?.setStreamHandler(GetTransactionDetailsEventHandler())
        cardpay?.setStreamHandler(CardPayEventHandler(context))
        cardDetailPay?.setStreamHandler(CardDetailPayEventHandler(context))

    }
}
