import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IResult.dart';

class EdfaPgTransactionStatusSuccess extends IEdfaPgResult{
  EdfaPgTransactionStatusSuccess.fromJson(dynamic json) : super.fromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}