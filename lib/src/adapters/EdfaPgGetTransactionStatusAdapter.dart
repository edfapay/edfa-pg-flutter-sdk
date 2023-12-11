
import 'dart:convert';

import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/TransactionStatusResponseCallback.dart';
import 'package:edfapg_sdk/src/response/gettransactionstatus/TransactionStatusResult.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPgGetTransactionStatusAdapter extends BaseAdapter{

  // transactionId = selectedTransaction.id,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // amount = amount,
  execute({
    required String transactionId,
    required String payerEmail,
    required String cardNumber,
    required TransactionStatusResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){

    final params = {
      "transactionId" : transactionId,
      "payerEmail" : payerEmail,
      "cardNumber" : cardNumber,
    };

    startTransactionsStatus(params).listen((event) {
      Log(event);
      EdfaPgTransactionStatusResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
    });

    Log("[ EdfaPgTransactionStatusAdapter.execute][Params] ${jsonEncode(params)}");
  }
}