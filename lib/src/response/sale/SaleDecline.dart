import 'dart:convert';

import 'package:edfapg_sdk/src/response/base/result/IDetailsResult.dart';

class EdfaPgSaleDecline extends IDetailsEdfaPgResult{

  String? declineReason;

  EdfaPgSaleDecline.fromJson(dynamic json) : super.fromJson(json) {
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
