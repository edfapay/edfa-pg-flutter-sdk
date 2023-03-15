import 'dart:convert';

class ExpresspaySaleOption {
  String? channelId;
  bool? recurringInit;

  ExpresspaySaleOption({
    required this.channelId,
    required this.recurringInit
  });

  ExpresspaySaleOption.fromJson(dynamic json) {
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