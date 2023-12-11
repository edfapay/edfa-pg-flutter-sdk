import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IResult.dart';
class EdfaPgCreditVoidSuccess extends IEdfaPgResult{

  EdfaPgCreditVoidSuccess.fromJson(dynamic json) : super.fromJson(json);


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}