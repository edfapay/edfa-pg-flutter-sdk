import 'dart:convert';

class EdfaPgSaleOrder {
  String? id;
  num? amount;
  String? description;
  String? currency;

  EdfaPgSaleOrder({
    required this.id,
    required this.amount,
    required this.description,
    required this.currency
  });

  EdfaPgSaleOrder.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    description = json['description'];
    currency = json['currency'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['description'] = description;
    map['currency'] = currency;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}