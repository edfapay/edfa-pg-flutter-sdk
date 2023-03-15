
import 'dart:convert';

import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:flutter/cupertino.dart';

import '../../expresspay_sdk.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpresspaySaleAdapter extends BaseAdapter{

  execute({
    required ExpresspaySaleOrder order,
    required ExpresspayCard card,
    required ExpresspayPayer payer,
    ExpresspaySaleOption? saleOption,
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
      if(event is Map){
        ExpresspaySaleResult(event).triggerCallbacks(onResponse, onResponseJSON: onResponseJSON, onFailure: onFailure);
      }
    });

    Log("[ExpresspaySaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}