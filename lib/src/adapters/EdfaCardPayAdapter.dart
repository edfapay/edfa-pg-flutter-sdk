
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
    DesignType? designType = DesignType.PAYMENT_DESIGN_1,
    EdfaLocale? locale = EdfaLocale.EN,
  }) {
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      designType.runtimeType.toString(): designType?.value ?? DesignType.PAYMENT_DESIGN_1.value,
      locale.runtimeType.toString(): locale?.value ?? EdfaLocale.values
    };

    startCardPay(params).listen((event) {
      Log(event);
      EdfaCardPayResult(event).triggerCallbacks(callback);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}
