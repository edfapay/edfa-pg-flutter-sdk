


import 'dart:convert';

import 'package:expresspay_sdk/src/api/ExpresspayAction.dart';
import 'package:expresspay_sdk/src/api/ExpresspayResult.dart';
import 'package:expresspay_sdk/src/api/ExpresspayStatus.dart';
import 'package:expresspay_sdk/src/response/base/result/ExpresspayResponse.dart';



class IExpresspayResult with ExpresspayResponse{
  /// The action of the transaction.
  ExpresspayAction? action;

  /// The result of the transaction.
  ExpresspayResult? result;

  /// The status of the transaction.
  ExpresspayStatus? status;

  /// Transaction ID in the Merchant’s system.
  String? orderId;

  /// Transaction ID in the Payment Platform.
  String? transactionId;


  IExpresspayResult.fromJson(dynamic json) {
    action = ExpresspayAction.of(json['action'].toString());
    result = ExpresspayResult.of(json['result'].toString());
    status = ExpresspayStatus.of(json['status'].toString());
    orderId = json['order_id'];
    transactionId = json['trans_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = action?.action;
    map['result'] = result?.result;
    map['status'] = status?.status;
    map['order_id'] = orderId;
    map['trans_id'] = transactionId;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}