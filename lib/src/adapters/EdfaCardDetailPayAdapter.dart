
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

class EdfaCardDetailPayAdapter extends BaseAdapter{

  execute({
    required EdfaPgSaleOrder order,
    required EdfaPgPayer payer,
    List<Extra> extras = const [],
    required EdfaPgCard card,
    required CardPayResponseCallback? callback,
    EdfaPayLanguage? locale = EdfaPayLanguage.en,
    Function(dynamic)? onFailure,
    bool? recurring,
    bool? auth,
  }) {
    List extrasJson = extras.map((xtra){ return xtra.toJson(); }).toList();
    final params = {
      order.runtimeType.toString(): order.toJson(),
      payer.runtimeType.toString(): payer.toJson(),
      card.runtimeType.toString(): card.toJson(),
      "extras": extrasJson,
      "recurring": recurring,
      "auth": auth,
    };

    startPayWithCardDetail(params).listen((event) {
      Log(event);
      EdfaCardPayResult(event).triggerCallbacks(callback, onFailure: onFailure);
    });

    Log("[ EdfaPgSaleAdapter.execute][Params] ${jsonEncode(params)}");
  }
}
