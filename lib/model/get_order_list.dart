// To parse this JSON data, do
//
//     final getOrderList = getOrderListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetAllOrderList> getOrderListFromJson(String str) {
  return List<GetAllOrderList>.from(json.decode(str).map((x) {
    return GetAllOrderList.fromJson(x);
  }));
}

String getOrderListToJson(List<GetAllOrderList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllOrderList {
  GetAllOrderList({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.createAt,
    required this.details,
    required this.user,
    required this.shipping,
  });

  int id;
  String userId;
  String totalPrice;
  Status? status;
  DateTime createAt;
  List<Detail> details;
  User user;
  Shipping shipping;

  factory GetAllOrderList.fromJson(Map<String, dynamic> json) => GetAllOrderList(
    id: json["id"],
    userId: json["user_id"],
    totalPrice: json["total_price"],
    status: statusValues.map[json["status"]],
    createAt: DateTime.parse(json["create_at"]),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    user: User.fromJson(json["user"]),
    shipping: Shipping.fromJson(json["shipping"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_price": totalPrice,
    "status": statusValues.reverse[status],
    "create_at": createAt.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "user": user.toJson(),
    "shipping": shipping.toJson(),
  };
}

class Detail {
  Detail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  int id;
  String orderId;
  String productId;
  String productName;
  String price;
  String quantity;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product_name": productName,
    "price": price,
    "quantity": quantity,
  };
}

class Shipping {
  Shipping({
    required this.id,
    required this.orderId,
    required this.shippingAddress,
  });

  int id;
  String orderId;
  String shippingAddress;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"],
    orderId: json["order_id"],
    shippingAddress: json["shipping_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "shipping_address": shippingAddress,
  };
}

enum Status { COMPLETE, DELIVER, PROCESSING }

final statusValues = EnumValues({
  "complete": Status.COMPLETE,
  "deliver": Status.DELIVER,
  "processing": Status.PROCESSING
});

class User {
  User({
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
  String email;
  int isActive;
  int isVerifide;
  String address;
  Type? type;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    password: json["password"],
    profileimage: json["profileimage"] == null ? null : json["profileimage"],
    email: json["email"] == null ? null : json["email"],
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
    "email": email == null ? null : email,
    "is_active": isActive,
    "is_Verifide": isVerifide,
    "address": address == null ? null : address,
    "type": typeValues.reverse[type],
    "token": token == null ? null : token,
  };
}

enum Type { USER }

final typeValues = EnumValues({
  "user": Type.USER
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
