import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';

class ExpresspayCaptureSuccess extends IDetailsExpresspayResult{
  ExpresspayCaptureSuccess.fromJson(dynamic json) : super.fromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
