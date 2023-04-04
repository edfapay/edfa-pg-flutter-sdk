
import 'dart:convert';

import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/BaseAdapter.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:expresspay_sdk/src/cardpay/ExpressCardPayResult.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressCardPayAdapter extends BaseAdapter{

  execute({
    required ExpresspaySaleOrder order,
    required ExpresspayPayer payer,
    required CardPayResponseCallback? callback,
    Function(dynamic)? onFailure,
  }) {
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
    };

    startCardPay(params).listen((event) {
      Log(event);
      ExpressCardPayResult(event).triggerCallbacks(callback);
    });

    Log("[ExpresspaySaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}
