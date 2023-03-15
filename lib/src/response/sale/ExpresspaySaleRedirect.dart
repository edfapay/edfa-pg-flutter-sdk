import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';
import 'package:expresspay_sdk/src/response/sale/ExpresspayRedirectParams.dart';

class ExpresspaySaleRedirect extends IDetailsExpresspayResult{
  String? redirectUrl;
  String? redirectMethod;
  ExpresspayRedirectParams? redirectParams;

  ExpresspaySaleRedirect.fromJson(dynamic json) : super.fromJson(json) {
    redirectUrl = json['redirect_url'];
    redirectParams = ExpresspayRedirectParams.fromJson(json['redirect_params']);
    redirectMethod = json['redirect_method'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['redirect_url'] = redirectUrl;
    map['redirect_params'] = redirectParams?.toJson();
    map['redirect_method'] = redirectMethod;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
