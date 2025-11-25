
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/applepay/EdfaApplePayResult.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';
import 'package:edfapg_sdk/src/request/Extra.dart';

import 'callbacks/ApplePayResponseCallback.dart';

class EdfaApplePayAdapter extends BaseAdapter{

  execute({
    required String applePayMerchantId,
    required EdfaPgSaleOrder order,
    required EdfaPgPayer payer,
    List<Extra> extras = const [],
    required ApplePayResponseCallback? callback,
    Function(dynamic)? onFailure,
  }) {
    List extrasJson = extras.map((xtra){ return xtra.toJson(); }).toList();
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      "extras": extrasJson,
      "applePayMerchantId": applePayMerchantId,
    };

    startApplePay(params).listen((event) {
      Log(event);
      EdfaApplePayResult(event).triggerCallbacks(callback);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}