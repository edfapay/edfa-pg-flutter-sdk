
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPgCaptureAdapter extends BaseAdapter{

  // transactionId = selectedTransaction.id,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // amount = amount,
  execute({
    required String transactionId,
    required String payerEmail,
    required String cardNumber,
    required num? amount,
    required CaptureResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){

    final params = {
      "transactionId" : transactionId,
      "payerEmail" : payerEmail,
      "cardNumber" : cardNumber,
      "amount" : amount,
    };

    startCapture(params).listen((event) {
      Log(event);
      EdfaPgCaptureResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
    });

    Log("[ EdfaPgCaptureAdapter.execute][Params] ${jsonEncode(params)}");
  }
}