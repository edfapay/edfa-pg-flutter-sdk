
import 'dart:convert';

import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/TransactionStatusResponseCallback.dart';
import 'package:expresspay_sdk/src/response/gettransactionstatus/ExpresspayTransactionStatusResult.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressPayGetTransactionStatusAdapter extends BaseAdapter{

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
      ExpresspayTransactionStatusResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
    });

    Log("[ExpresspayTransactionStatusAdapter.execute][Params] ${jsonEncode(params)}");
  }
}