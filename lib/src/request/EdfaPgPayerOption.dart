import 'dart:convert';

import 'package:intl/intl.dart';

class EdfaPgPayerOption {
  String? middleName;
  DateTime? birthdate;
  String? address2;
  String? state;

  EdfaPgPayerOption({
    required this.middleName,
    required this.birthdate,
    required this.address2,
    required this.state
  });

  EdfaPgPayerOption.fromJson(dynamic json) {
    middleName = json['middleName'];
    birthdate = DateTime.parse(json['birthdate']);
    address2 = json['address2'];
    state = json['state'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['middleName'] = middleName;
    map['birthdate'] =  birthdate == null ? "" : DateFormat("yyyy-MM-dd").format(birthdate!);
    map['address2'] = address2;
    map['state'] = state;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}