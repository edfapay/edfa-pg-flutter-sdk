import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';

class EdfaPgSaleRecurring extends IDetailsEdfaPgResult{
  String? recurringToken;

  EdfaPgSaleRecurring.fromJson(dynamic json) : super.fromJson(json) {
    recurringToken = json['recurring_token'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['recurring_token'] = recurringToken;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
