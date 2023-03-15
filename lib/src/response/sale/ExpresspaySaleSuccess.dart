import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';
import 'package:expresspay_sdk/src/response/sale/ExpressPaySaleResponse.dart';

class ExpresspaySaleSuccess extends IDetailsExpresspayResult with ExpressPaySaleResponse{
  ExpresspaySaleSuccess.fromJson(dynamic json) : super.fromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
