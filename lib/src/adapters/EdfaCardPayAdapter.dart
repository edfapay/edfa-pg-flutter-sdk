
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/cardpay/EdfaCardPayResult.dart';
import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/enum/DesignType.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';

class EdfaCardPayAdapter extends BaseAdapter{

  execute({
    required EdfaPgSaleOrder order,
    required EdfaPgPayer payer,
    required CardPayResponseCallback? callback,
    Function(dynamic)? onFailure,
    EdfaPayDesignType? designType = EdfaPayDesignType.one,
    EdfaPayLanguage? locale = EdfaPayLanguage.en,
    bool? recurring,
    bool? auth,
  }) {
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      designType.runtimeType.toString(): designType?.name ?? EdfaPayDesignType.one.name,
      locale.runtimeType.toString(): locale?.name ?? EdfaPayLanguage.en.name,
      "recurring": recurring,
      "auth": auth,
    };

    startCardPay(params).listen((event) {
      Log(event);
      EdfaCardPayResult(event).triggerCallbacks(callback, onFailure: onFailure);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}
