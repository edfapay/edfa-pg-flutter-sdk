
import 'package:expresspay_sdk/src/api/ExpresspayTransactionStatus.dart';
import 'package:expresspay_sdk/src/api/ExpresspayTransactionType.dart';

class ExpresspayTransaction {
  String? date;
  ExpresspayTransactionType? type;
  ExpresspayTransactionStatus? status;
  double? amount;
  
  ExpresspayTransaction({
      this.date, 
      this.type, 
      this.status, 
      this.amount,});

  ExpresspayTransaction.fromJson(dynamic json) {
    date = json['date'];
    type = ExpresspayTransactionType.of(json['type'].toString());
    status = ExpresspayTransactionStatus.of(json['status'].toString());
    amount = json['amount'];
  }

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['date'] = date;
    map['type'] = type;
    map['status'] = status;
    map['amount'] = amount;
    return map;
  }

}