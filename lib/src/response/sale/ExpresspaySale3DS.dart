import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';
import 'package:expresspay_sdk/src/response/sale/ExpresspaySale3dsRedirectParams.dart';

class ExpresspaySale3DS extends IDetailsExpresspayResult{
  String? redirectUrl;
  String? redirectMethod;
  ExpresspaySale3dsRedirectParams? redirectParams;

  ExpresspaySale3DS.fromJson(dynamic json) : super.fromJson(json) {
    redirectUrl = json['redirect_url'];
    redirectParams = ExpresspaySale3dsRedirectParams.fromJson(json['redirect_params']);
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
