
import 'dart:convert';

import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/Helpers.dart';
import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:expresspay_sdk/src/applepay/ExpressApplePayResult.dart';
import 'package:flutter/cupertino.dart';

import 'callbacks/ApplePayResponseCallback.dart';

class ExpressApplePayAdapter extends BaseAdapter{

  execute({
    required String applePayMerchantId,
    required ExpresspaySaleOrder order,
    required ExpresspayPayer payer,
    required ApplePayResponseCallback? callback,
    Function(dynamic)? onFailure,
  }) {
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      "applePayMerchantId": applePayMerchantId,
    };

    startApplePay(params).listen((event) {
      Log(event);
      if (event is Map) {
        ExpressApplePayResult(event).triggerCallbacks(callback);
      }
    });

    Log("[ExpresspaySaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}