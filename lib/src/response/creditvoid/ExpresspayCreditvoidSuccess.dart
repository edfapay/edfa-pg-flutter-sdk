import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IExpresspayResult.dart';
class ExpresspayCreditVoidSuccess extends IExpresspayResult{

  ExpresspayCreditVoidSuccess.fromJson(dynamic json) : super.fromJson(json);


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}