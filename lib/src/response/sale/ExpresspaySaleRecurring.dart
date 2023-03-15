import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';

class ExpresspaySaleRecurring extends IDetailsExpresspayResult{
  String? recurringToken;

  ExpresspaySaleRecurring.fromJson(dynamic json) : super.fromJson(json) {
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
