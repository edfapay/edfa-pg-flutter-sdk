import 'dart:convert';

import 'package:expresspay_sdk/src/response/gettransactiondetails/ExpresspayTransaction.dart';
import 'package:expresspay_sdk/src/response/base/result/IOrderExpresspayResult.dart';

class ExpresspayTransactionDetailsSuccess extends IOrderExpresspayResult{

  String? declineReason;
  String? name;
  String? mail;
  String? ip;
  String? card;
  List<ExpresspayTransaction> transactions = [];

  ExpresspayTransactionDetailsSuccess.fromJson(dynamic json) : super.fromJson(json) {
    declineReason = json['decline_reason'];
    name = json['name'];
    mail = json['mail'];
    ip = json['ip'];
    card = json['card'];

    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions.add(ExpresspayTransaction.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['decline_reason'] = declineReason;
    map['mail'] = mail;
    map['ip'] = ip;
    map['card'] = card;
    map['name'] = name;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}