// To parse this JSON data, do
//
//     final getAllProductData = getAllProductDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllProductData getAllProductDataFromJson(String str) => GetAllProductData.fromJson(json.decode(str));

String getAllProductDataToJson(GetAllProductData data) => json.encode(data.toJson());

class GetAllProductData {
  GetAllProductData({
    required this.status,
    required this.msg,
    required this.data,
  });

  String status;
  String msg;
  List<DataObject> data;

  factory GetAllProductData.fromJson(Map<String, dynamic> json) => GetAllProductData(
    status: json["status"],
    msg: json["msg"],
    data: List<DataObject>.from(json["data"].map((x) => DataObject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class DataObject {
  DataObject({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.price,
    required this.sellingPrice,
    required this.description,
  });

  int id;
  String categoryId;
  String name;
  String img1;
  String img2;
  String img3;
  dynamic img4;
  dynamic img5;
  String price;
  String sellingPrice;
  String description;

  factory DataObject.fromJson(Map<String, dynamic> json) => DataObject(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    img1: json["img1"],
    img2: json["img2"] == null ? null : json["img2"],
    img3: json["img3"] == null ? null : json["img3"],
    img4: json["img4"],
    img5: json["img5"],
    price: json["price"],
    sellingPrice: json["selling_price"] == null ? null : json["selling_price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "img1": img1,
    "img2": img2 == null ? null : img2,
    "img3": img3 == null ? null : img3,
    "img4": img4,
    "img5": img5,
    "price": price,
    "selling_price": sellingPrice == null ? null : sellingPrice,
    "description": description,
  };
}
