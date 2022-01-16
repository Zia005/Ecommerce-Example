// To parse this JSON data, do
//
//     final getAllSlider = getAllSliderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllSliderList getAllSliderFromJson(String str) => GetAllSliderList.fromJson(json.decode(str));

String getAllSliderToJson(GetAllSliderList data) => json.encode(data.toJson());

class GetAllSliderList {
  GetAllSliderList({
    required this.status,
    required this.msg,
    required this.data,
  });

  String status;
  String msg;
  List<Datum> data;

  factory GetAllSliderList.fromJson(Map<String, dynamic> json) => GetAllSliderList(
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
    required this.sliderImage,
    required this.status,
  });

  int id;
  String sliderImage;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sliderImage: json["slider_image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slider_image": sliderImage,
    "status": status,
  };
}
