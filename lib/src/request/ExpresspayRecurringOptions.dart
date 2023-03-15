import 'dart:convert';

class ExpresspayRecurringOptions {

  String? firstTransactionId;
  String? token;

  ExpresspayRecurringOptions({
    required this.firstTransactionId,
    required this.token
  });

  ExpresspayRecurringOptions.fromJson(dynamic json) {
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