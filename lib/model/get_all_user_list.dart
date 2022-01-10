// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserData getAllUserDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.status,
    required this.msg,
    required this.data,
  });

  String status;
  String msg;
  List<Datum> data;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.profileimage,
    required this.email,
    required this.isActive,
    required this.isVerifide,
    required this.address,
    required this.type,
    required this.token,
  });

  int id;
  String name;
  String phone;
  String password;
  String profileimage;
  Email? email;
  int isActive;
  int isVerifide;
  String address;
  Type? type;
  String token;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    password: json["password"],
    profileimage: json["profileimage"] == null ? null : json["profileimage"],
    email: json["email"] == null ? null : emailValues.map[json["email"]],
    isActive: json["is_active"],
    isVerifide: json["is_Verifide"],
    address: json["address"] == null ? null : json["address"],
    type: typeValues.map[json["type"]],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "password": password,
    "profileimage": profileimage == null ? null : profileimage,
    "email": email == null ? null : emailValues.reverse[email],
    "is_active": isActive,
    "is_Verifide": isVerifide,
    "address": address == null ? null : address,
    "type": typeValues.reverse[type],
    "token": token == null ? null : token,
  };
}

enum Email { EMPTY, SHORIFULISLAM234_GMAIL_COM, BA479222_GMAIL_COM }

final emailValues = EnumValues({
  "ba479222@gmail.com": Email.BA479222_GMAIL_COM,
  "": Email.EMPTY,
  "shorifulislam234@gmail.com": Email.SHORIFULISLAM234_GMAIL_COM
});

enum Type { USER, ADMIN }

final typeValues = EnumValues({
  "admin": Type.ADMIN,
  "user": Type.USER
});

class EnumValues<T> {
  Map<String, T> map;
late  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
