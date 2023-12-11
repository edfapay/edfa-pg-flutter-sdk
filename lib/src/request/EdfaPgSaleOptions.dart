import 'dart:convert';

class EdfaPgSaleOption {
  String? channelId;
  bool? recurringInit;

  EdfaPgSaleOption({
    required this.channelId,
    required this.recurringInit
  });

  EdfaPgSaleOption.fromJson(dynamic json) {
    channelId = json['channelId'];
    recurringInit = json['recurringInit'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['channelId'] = channelId;
    map['recurringInit'] = recurringInit;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}