// To parse this JSON data, do
//
//     final getAllCategoryList = getAllCategoryListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllCategoryList getAllCategoryListFromJson(String str) {
    return GetAllCategoryList.fromJson(json.decode(str));
}

String getAllCategoryListToJson(GetAllCategoryList data) {
    return json.encode(data.toJson());
}

class GetAllCategoryList {
    GetAllCategoryList({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    List<Datum> data;

    factory GetAllCategoryList.fromJson(Map<String, dynamic> json) => GetAllCategoryList(
        status: json["status"],
        msg: json["msg"],
        data: List<Datum>.from(
            json["data"].map((x) {
                return Datum.fromJson(x);
            })
        ),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(
            data.map((x) {
                return x.toJson();
            })
        ),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.categoryImage,
        required this.isActive,
    });

    int id;
    String name;
    String categoryImage;
    int isActive;

    factory Datum.fromJson(Map<String, dynamic> json) {
        return Datum(
            id: json["id"],
            name: json["name"],
            categoryImage: json["category_image"],
            isActive: json["is_active"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_image": categoryImage,
        "is_active": isActive,
    };
}
