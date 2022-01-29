// To parse this JSON data, do
//
//     final getAllSliderList = getAllSliderListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetAllSliderList> getAllSliderListFromJson(String str) => List<GetAllSliderList>.from(json.decode(str).map((x) => GetAllSliderList.fromJson(x)));

String getAllSliderListToJson(List<GetAllSliderList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllSliderList {
  GetAllSliderList({
    required this.id,
    required this.sliderImage,
    required this.status,
  });

  int id;
  String sliderImage;
  String status;

  factory GetAllSliderList.fromJson(Map<String, dynamic> json) => GetAllSliderList(
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
