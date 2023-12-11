
import 'package:edfapg_sdk/src/api/EdfaPgTransactionStatus.dart';
import 'package:edfapg_sdk/src/api/EdfaPgTransactionType.dart';

class EdfaPgTransaction {
  String? date;
  EdfaPgTransactionType? type;
  EdfaPgTransactionStatus? status;
  double? amount;
  
  EdfaPgTransaction({
      this.date, 
      this.type, 
      this.status, 
      this.amount,});

  EdfaPgTransaction.fromJson(dynamic json) {
    date = json['date'];
    type = EdfaPgTransactionType.of(json['type'].toString());
    status = EdfaPgTransactionStatus.of(json['status'].toString());
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