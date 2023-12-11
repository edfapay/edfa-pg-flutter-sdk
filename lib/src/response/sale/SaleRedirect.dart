import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';
import 'package:edfapg_sdk/src/response/sale/RedirectParams.dart';

class EdfaPgSaleRedirect extends IDetailsEdfaPgResult{
  String? redirectUrl;
  String? redirectMethod;
  EdfaPgRedirectParams? redirectParams;

  EdfaPgSaleRedirect.fromJson(dynamic json) : super.fromJson(json) {
    redirectUrl = json['redirect_url'];
    redirectParams = EdfaPgRedirectParams.fromJson(json['redirect_params']);
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
