// To parse this JSON data, do
//
//     final getAllCategoryList = getAllCategoryListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetAllCategoryList> getAllCategoryListFromJson(String str) => List<GetAllCategoryList>.from(json.decode(str).map((x) => GetAllCategoryList.fromJson(x)));

String getAllCategoryListToJson(List<GetAllCategoryList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCategoryList {
    GetAllCategoryList({
        required this.id,
        required this.name,
        required this.categoryImage,
        required this.isActive,
    });

    int id;
    String name;
    String categoryImage;
    int isActive;

    factory GetAllCategoryList.fromJson(Map<String, dynamic> json) => GetAllCategoryList(
        id: json["id"],
        name: json["name"],
        categoryImage: json["category_image"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_image": categoryImage,
        "is_active": isActive,
    };
}
