import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';
import 'package:edfapg_sdk/src/response/sale/Sale3dsRedirectParams.dart';

class EdfaPgSale3DS extends IDetailsEdfaPgResult{
  String? redirectUrl;
  String? redirectMethod;
  EdfaPgSale3dsRedirectParams? redirectParams;

  EdfaPgSale3DS.fromJson(dynamic json) : super.fromJson(json) {
    redirectUrl = json['redirect_url'];
    redirectParams = EdfaPgSale3dsRedirectParams.fromJson(json['redirect_params']);
    redirectMethod = json['redirect_method'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['redirect_url'] = redirectUrl;
    map['redirect_params'] = redirectParams;
    map['redirect_method'] = redirectMethod;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}
