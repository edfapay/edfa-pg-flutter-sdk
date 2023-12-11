import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';

class EdfaPgCaptureSuccess extends IDetailsEdfaPgResult{
  EdfaPgCaptureSuccess.fromJson(dynamic json) : super.fromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
