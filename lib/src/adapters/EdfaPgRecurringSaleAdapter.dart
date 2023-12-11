
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/request/EdfaPgOrder.dart';
import 'package:edfapg_sdk/src/request/EdfaPgRecurringOptions.dart';

class EdfaPgRecurringSaleAdapter extends BaseAdapter{
  // order = order,
  // options = recurringOptions,
  // payerEmail = selectedTransaction.payerEmail,
  // cardNumber = selectedTransaction.cardNumber,
  // auth = isAuth,

  execute({
    required EdfaPgOrder order,
    required EdfaPgRecurringOptions recurringOptions,
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
      EdfaPgSaleResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, );
    });

    Log("[ EdfaPgRecurringSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}