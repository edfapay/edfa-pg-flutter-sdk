import 'dart:convert';

import 'IExpresspayResult.dart';

class IOrderExpresspayResult extends IExpresspayResult {
  /// Amount of capture.
  num?  orderAmount;

  /// Currency.
  String? orderCurrency;


  IOrderExpresspayResult.fromJson(dynamic json) : super.fromJson(json) {
    orderAmount = json['amount'];
    orderCurrency = json['currency'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['amount'] = orderAmount;
    map['currency'] = orderCurrency;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
