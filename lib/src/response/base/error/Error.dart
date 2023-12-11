import 'dart:convert';

import 'package:edfapg_sdk/src/api/EdfaPgResult.dart';

import 'ExactError.dart';

class EdfaPgError {
  EdfaPgResult? result;
  num? errorCode;
  String? errorMessage;
  List<EdfaPgExactError>? errors;

  EdfaPgError({
      this.result, 
      this.errorCode, 
      this.errorMessage, 
      this.errors,});

  EdfaPgError.fromJson(dynamic json) {
    result = EdfaPgResult.of(json['result']);
    errorCode = json['error_code'];
    errorMessage = json['error_message'];

    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors?.add(EdfaPgExactError.fromJson(v));
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