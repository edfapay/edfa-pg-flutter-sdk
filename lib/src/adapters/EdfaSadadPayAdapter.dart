
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/SadadPayResponseCallback.dart';
import 'package:edfapg_sdk/src/cardpay/EdfaCardPayResult.dart';
import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/enum/DesignType.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';
import 'package:edfapg_sdk/src/sadadpay/EdfaSadadPayResult.dart';

import '../request/Extra.dart';

class EdfaSadadPayAdapter extends BaseAdapter{

  execute({
    required String? orderId,
    required String? orderDescription,
    required double? amount,
    required String? customerName,
    required String? mobileNumber,
    required SadadPayResponseCallback? callback,
    Function(dynamic)? onFailure,
  }) {

    final params = {
      "orderId": orderId,
      "orderDescription": orderDescription,
      "amount": amount,
      "customerName": customerName,
      "mobileNumber": mobileNumber
    };

    startSadadPay(params).listen((event) {
      EdfaSadadPayResult(event).triggerCallbacks(callback, onFailure: onFailure);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}
