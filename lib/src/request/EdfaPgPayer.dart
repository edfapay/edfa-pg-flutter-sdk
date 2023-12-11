import 'dart:convert';

import 'package:edfapg_sdk/src/request/EdfaPgPayerOption.dart';


class EdfaPgPayer {
  String? firstName;
  String? lastName;
  String? address;
  String? country;
  String? city;
  String? zip;
  String? email;
  String? phone;
  String? ip;
  EdfaPgPayerOption? options;

  EdfaPgPayer({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.country,
    required this.city,
    required this.zip,
    required this.email,
    required this.phone,
    required this.ip,
    this.options
  });

  EdfaPgPayer.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    email = json['email'];
    phone = json['phone'];
    ip = json['ip'];
    options = json['options'] != null ? EdfaPgPayerOption.fromJson(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['address'] = address;
    map['country'] = country;
    map['city'] = city;
    map['zip'] = zip;
    map['email'] = email;
    map['phone'] = phone;
    map['ip'] = ip;
    if (options != null) {
      map['options'] = options?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}