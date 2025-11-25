
import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/BaseAdapter.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/cardpay/EdfaCardPayResult.dart';
import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/enum/DesignType.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';

import '../request/Extra.dart';

class EdfaCardPayAdapter extends BaseAdapter{

  execute({
    required EdfaPgSaleOrder order,
    required EdfaPgPayer payer,
    List<Extra> extras = const [],
    required CardPayResponseCallback? callback,
    Function(dynamic)? onFailure,
    EdfaPayDesignType? designType = EdfaPayDesignType.one,
    EdfaPayLanguage? locale = EdfaPayLanguage.en,
    bool? recurring,
    bool? auth,
  }) {
    List extrasJson = extras.map((xtra){ return xtra.toJson(); }).toList();
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      designType.runtimeType.toString(): designType?.name ?? EdfaPayDesignType.one.name,
      locale.runtimeType.toString(): locale?.name ?? EdfaPayLanguage.en.name,
      "extras": extrasJson,
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
