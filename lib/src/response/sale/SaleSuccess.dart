import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';
import 'package:edfapg_sdk/src/response/sale/SaleResponse.dart';

class EdfaPgSaleSuccess extends IDetailsEdfaPgResult with EdfaPgSaleResponse{
  EdfaPgSaleSuccess.fromJson(dynamic json) : super.fromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
