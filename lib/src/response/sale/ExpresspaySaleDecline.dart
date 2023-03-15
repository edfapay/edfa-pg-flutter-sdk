import 'dart:convert';

import 'package:expresspay_sdk/src/response/base/result/IDetailsExpresspayResult.dart';

class ExpresspaySaleDecline extends IDetailsExpresspayResult{

  String? declineReason;

  ExpresspaySaleDecline.fromJson(dynamic json) : super.fromJson(json) {
    declineReason = json['decline_reason'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['decline_reason'] = declineReason;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
