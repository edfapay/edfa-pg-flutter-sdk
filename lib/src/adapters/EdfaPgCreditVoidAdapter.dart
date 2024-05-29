
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPgCreditVoidAdapter extends BaseAdapter{

  // transactionId = selectedTransaction.id,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // amount = amount,
  execute({
    required String transactionId,
    required String payerEmail,
    required String cardNumber,
    required num? amount,
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
      EdfaPgCreditVoidResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
    });

    Log("[ EdfaPgCreditVoidAdapter.execute][Params] ${jsonEncode(params)}");
  }
}