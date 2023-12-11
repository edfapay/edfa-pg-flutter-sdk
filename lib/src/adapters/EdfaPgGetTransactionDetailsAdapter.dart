
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPgGetTransactionDetailsAdapter extends BaseAdapter{

  // transactionId = selectedTransaction.id,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // amount = amount,
  execute({
    required String transactionId,
    required String payerEmail,
    required String cardNumber,
    required TransactionDetailsResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){


    final params = {
      "transactionId" : transactionId,
      "payerEmail" : payerEmail,
      "cardNumber" : cardNumber,
    };

    startTransactionsDetail(params).listen((event) {
      Log(event);
      EdfaPgTransactionDetailResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON);
    });

    Log("[ EdfaPgTransactionDetailAdapter.execute][Params] ${jsonEncode(params)}");
  }
}