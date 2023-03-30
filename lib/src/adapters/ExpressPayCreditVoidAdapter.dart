
import 'dart:convert';

import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/CreditVoidResponseCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressPayCreditVoidAdapter extends BaseAdapter{

  // transactionId = selectedTransaction.id,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // amount = amount,
  execute({
    required String transactionId,
    required String payerEmail,
    required String cardNumber,
    required double? amount,
    required CreditVoidResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){

    final params = {
      "transactionId" : transactionId,
      "payerEmail" : payerEmail,
      "cardNumber" : cardNumber,
      "amount" : amount,
    };

    startCreditVoid(params).listen((event) {
      Log(event);
      if(event is Map){
        ExpresspayCreditVoidResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
      }

    });

    Log("[ExpresspayCreditVoidAdapter.execute][Params] ${jsonEncode(params)}");
  }
}