


import 'dart:convert';

import 'package:edfapg_sdk/src/api/EdfaPgAction.dart';
import 'package:edfapg_sdk/src/api/EdfaPgResult.dart';
import 'package:edfapg_sdk/src/api/EdfaPgStatus.dart';
import 'package:edfapg_sdk/src/response/base/result/EdfaPgResponse.dart';



class IEdfaPgResult with EdfaPgResponse{
  /// The action of the transaction.
  EdfaPgAction? action;

  /// The result of the transaction.
  EdfaPgResult? result;

  /// The status of the transaction.
  EdfaPgStatus? status;

  /// Transaction ID in the Merchant’s system.
  String? orderId;

  /// Transaction ID in the Payment Platform.
  String? transactionId;


  IEdfaPgResult.fromJson(dynamic json) {
    action = EdfaPgAction.of(json['action'].toString());
    result = EdfaPgResult.of(json['result'].toString());
    status = EdfaPgStatus.of(json['status'].toString());
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