import 'dart:convert';

class ExpresspayOrder {
  String? id;
  num? amount;
  String? description;

  ExpresspayOrder({
    required this.id,
    required this.amount,
    required this.description,
  });

  ExpresspayOrder.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['description'] = description;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}