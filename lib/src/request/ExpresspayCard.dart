class ExpresspayCard {
  String? _LABEL;

  String? number;
  num? expireMonth;
  num? expireYear;
  String? cvv;

  ExpresspayCard({
        required this.number,
        required this.expireMonth,
        required this.expireYear,
        required this.cvv
      });

  ExpresspayCard.test(String? LABEL, {
        required this.number,
        required this.expireMonth,
        required this.expireYear,
        required this.cvv
      }){
    _LABEL = LABEL;
  }

  ExpresspayCard.fromJson(dynamic json) {
    number = json['number'];
    expireMonth = json['expireMonth'];
    expireYear = json['expireYear'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['expireMonth'] = expireMonth;
    map['expireYear'] = expireYear;
    map['cvv'] = cvv;
    return map;
  }

  @override
  String toString() {
    return _LABEL ?? "<UNKNOWN>";
  }
}