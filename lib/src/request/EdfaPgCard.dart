class EdfaPgCard {
  String? _LABEL;

  String? number;
  num? expireMonth;
  num? expireYear;
  String? cvv;

  EdfaPgCard({
        required this.number,
        required this.expireMonth,
        required this.expireYear,
        required this.cvv
      });

  EdfaPgCard.test(String? LABEL, {
        required this.number,
        required this.expireMonth,
        required this.expireYear,
        required this.cvv
      }){
    _LABEL = LABEL;
  }

  EdfaPgCard.fromJson(dynamic json) {
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