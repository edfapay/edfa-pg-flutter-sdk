import 'dart:convert';

import 'package:expresspay_sdk/src/api/ExpresspayResult.dart';

import 'ExpresspayExactError.dart';

class ExpresspayError {
  ExpresspayResult? result;
  num? errorCode;
  String? errorMessage;
  List<ExpresspayExactError>? errors;

  ExpresspayError({
      this.result, 
      this.errorCode, 
      this.errorMessage, 
      this.errors,});

  ExpresspayError.fromJson(dynamic json) {
    result = ExpresspayResult.of(json['result']);
    errorCode = json['error_code'];
    errorMessage = json['error_message'];

    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors?.add(ExpresspayExactError.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result?.result;
    map['error_code'] = errorCode;
    map['error_message'] = errorMessage;
    if (errors != null) {
      map['errors'] = errors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}