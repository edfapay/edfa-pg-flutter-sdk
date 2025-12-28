import 'dart:convert';

import 'package:edfapg_sdk/src/response/gettransactiondetails/Transaction.dart';
import 'package:edfapg_sdk/src/response/base/result/IOrderResult.dart';

class EdfaPgSadadSuccess{
  String? billNumber;
  String? sadadNumber;

  EdfaPgSadadSuccess.fromJson(dynamic json){
    billNumber = json['billNumber'];
    sadadNumber = json['sadadNumber'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billNumber'] = billNumber;
    map['sadadNumber'] = sadadNumber;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}