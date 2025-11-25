class Extra {
  String? type;
  String? name;
  String? value;

  Extra({
        required this.type,
        required this.name,
        required this.value,
      });

  Extra.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    map['value'] = value;
    return map;
  }
}