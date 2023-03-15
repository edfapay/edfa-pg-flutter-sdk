import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ExpresspayRedirectParams {
  String? body;

  ExpresspayRedirectParams({this.body});

  ExpresspayRedirectParams.fromJson(dynamic json) {
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['body'] = body;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}