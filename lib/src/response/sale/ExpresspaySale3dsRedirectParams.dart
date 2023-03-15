import 'dart:convert';

class ExpresspaySale3dsRedirectParams {
  String? paReq;
  String? md;
  String? termUrl;

  ExpresspaySale3dsRedirectParams({
      this.paReq, 
      this.md, 
      this.termUrl,});

  ExpresspaySale3dsRedirectParams.fromJson(dynamic json) {
    paReq = json['PaReq'];
    md = json['MD'];
    termUrl = json['TermUrl'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PaReq'] = paReq;
    map['MD'] = md;
    map['TermUrl'] = termUrl;
    return map;
  }


  @override
  String toString() {
    return jsonEncode(toJson());
  }
}