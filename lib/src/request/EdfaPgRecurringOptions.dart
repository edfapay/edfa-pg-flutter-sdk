import 'dart:convert';

class EdfaPgRecurringOptions {

  String? firstTransactionId;
  String? token;

  EdfaPgRecurringOptions({
    required this.firstTransactionId,
    required this.token
  });

  EdfaPgRecurringOptions.fromJson(dynamic json) {
    firstTransactionId = json['firstTransactionId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstTransactionId'] = firstTransactionId;
    map['token'] = token;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}