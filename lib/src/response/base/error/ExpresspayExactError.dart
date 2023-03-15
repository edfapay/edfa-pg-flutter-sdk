import 'dart:convert';

class ExpresspayExactError {
  num? errorCode;
  String? errorMessage;

  ExpresspayExactError({
      this.errorCode, 
      this.errorMessage,});

  ExpresspayExactError.fromJson(dynamic json) {
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error_code'] = errorCode;
    map['error_message'] = errorMessage;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}