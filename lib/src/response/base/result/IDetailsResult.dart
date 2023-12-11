import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IOrderResult.dart';
import 'package:intl/intl.dart';
import 'package:edfapg_sdk/src/Helpers.dart';


class IDetailsEdfaPgResult extends IOrderEdfaPgResult {
  /// Transaction date in the Payment Platform.
  DateTime? transactionDate;

  /// Descriptor from the bank, the same as cardholder will see in the bank statement. Optional.
  String? descriptor;


  IDetailsEdfaPgResult.fromJson(dynamic json) : super.fromJson(json) {
    // `trans_date` Format: (2012-04-03 16:02:01) [yyyy-MM-dd HH:mm:ss]
    try{
      transactionDate = DateTime.parse(json['trans_date']);
    }catch(e){
      Log(e);
    }
    descriptor = json['descriptor'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();

    map['trans_date'] = transactionDate == null ? "" : DateFormat("yyyy-MM-dd HH:mm:ss").format(transactionDate!);
    map['descriptor'] = descriptor;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}