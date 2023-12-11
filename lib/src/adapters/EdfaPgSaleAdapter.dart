
import 'dart:convert';

import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/request/EdfaPgCard.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOptions.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';

import '../../edfapg_sdk.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPgSaleAdapter extends BaseAdapter{

  execute({
    required EdfaPgSaleOrder order,
    required EdfaPgCard card,
    required EdfaPgPayer payer,
    EdfaPgSaleOption? saleOption,
    required bool isAuth,
    required SaleResponseCallback? onResponse,
    required Function(dynamic)? onFailure,
    required Function(Map)? onResponseJSON,
  }){

    final params = {
      card.runtimeType.toString() : card.toJson(),
      order.runtimeType.toString() : order.toJson(),
      payer.runtimeType.toString() : payer.toJson(),
      "auth" : isAuth,
      if(saleOption != null)
        card.runtimeType.toString() : saleOption.toJson(),
    };

    startSale(params).listen((event) {
      Log(event);
      EdfaPgSaleResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, onFailure: onFailure);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}