package com.expresspay.fluttersdk

import android.content.Context
import com.expresspay.fluttersdk.eventhandlers.CardPayEventHandler
import com.expresspay.fluttersdk.eventhandlers.SaleEventHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/** ExpresspaySdkPlugin */
class ExpresspaySDKEventChannels{

  var cardpay:EventChannel? = null;
  var applepay:EventChannel? = null;

  var sale:EventChannel? = null;
  var recurringSale:EventChannel? = null;
  var capture:EventChannel? = null;
  var creditVoid:EventChannel? = null;
  var transactionStatus:EventChannel? = null;
  var transactionDetail:EventChannel? = null;
  var transactionLogs:EventChannel? = null;


  public fun initiate(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding, context: Context) {
    val messenger = flutterPluginBinding.binaryMessenger

    cardpay = EventChannel(messenger,"com.expresspay.sdk.cardpay")
    sale = EventChannel(messenger,"com.expresspay.sdk.sale")
    recurringSale = EventChannel(messenger,"com.expresspay.sdk.recurringsale")
    capture = EventChannel(messenger,"com.expresspay.sdk.capture")
    creditVoid = EventChannel(messenger,"com.expresspay.sdk.creditvoid")
    transactionStatus = EventChannel(messenger,"com.expresspay.sdk.transactionstatus")
    transactionDetail = EventChannel(messenger,"com.expresspay.sdk.transactiondetail")
    transactionLogs = EventChannel(messenger,"com.expresspay.sdk.transactionlogs")

    cardpay?.setStreamHandler(CardPayEventHandler(context))
    sale?.setStreamHandler(SaleEventHandler())

  }
}
