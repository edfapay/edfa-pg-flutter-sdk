import 'dart:convert';


class EdfaPgRedirectParams {
  String? body;

  EdfaPgRedirectParams({this.body});

  EdfaPgRedirectParams.fromJson(dynamic json) {
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