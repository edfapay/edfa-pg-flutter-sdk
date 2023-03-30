
import 'dart:convert';

import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/RecurringSaleResponseCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressPayRecurringSaleAdapter extends BaseAdapter{
  // order = order,
  // options = recurringOptions,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // auth = isAuth,

  execute({
    required ExpresspayOrder order,
    required ExpresspayRecurringOptions recurringOptions,
    required String payerEmail,
    required String cardNumber,
    required bool isAuth,
    required RecurringSaleResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){

    final params = {
      order.runtimeType.toString() : order.toJson(),
      recurringOptions.runtimeType.toString() : recurringOptions.toJson(),
      "payerEmail" : payerEmail,
      "cardNumber" : cardNumber,
      "auth" : isAuth,
    };

    startRecurringSale(params).listen((event) {
      Log(event);
      if(event is Map){
        ExpresspaySaleResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
      }
    });

    Log("[ExpresspayRecurringSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}