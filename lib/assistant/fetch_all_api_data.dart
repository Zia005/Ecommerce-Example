import 'dart:convert';
import 'package:ecommerce_78/model/get_all_category_list.dart';
import 'package:ecommerce_78/model/get_all_product_list.dart';
import 'package:ecommerce_78/model/get_all_sliders.dart';
import 'package:ecommerce_78/model/get_all_user_list.dart';
import 'package:ecommerce_78/model/get_order_list.dart';
import 'package:ecommerce_78/model/get_order_summary.dart';
import 'package:http/http.dart' as http;

class LoadAllApiData{

  static Future<List<GetAllOrderList>?> fetchAllOrderData() async{
    var url = Uri.parse("https://happybuy.appsticit.com/orders");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});

    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode);

      // print(heroResponse.body);
      // print(jsonDecode);
      print(convertData +" Done");
      return getOrderListFromJson(convertData);
    }

    return null;

  }

  static Future<List<GetAllCategoryList>?> fetchAllCategoryData() async{
    var url = Uri.parse("https://happybuy.appsticit.com/getallcategory");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});
    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode['data']);
      print(convertData + " hello");
      return getAllCategoryListFromJson(convertData);
    }

    return null;
  }

  static Future<GetAllProductList?> fetchAllProductData() async {
    var url = Uri.parse("https://happybuy.appsticit.com/getallproductdata");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});
    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode);
      return getAllProductDataFromJson(heroResponse.body);
    }

    return null;
  }

  static Future<GetAllSliderList?> fetchAllSliderData() async{
    var url = Uri.parse("https://happybuy.appsticit.com/getallsliders");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});
    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode);
      return getAllSliderFromJson(heroResponse.body);
    }
    return null;
  }

  static Future<GetAllUserList?> fetchAllUserData() async{
    var url = Uri.parse("https://happybuy.appsticit.com/allUserList");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});
    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode);
      return getAllUserDataFromJson(heroResponse.body);
    }
    return null;
  }

  static Future<GetAllOrderSummaryList?> fetchAllOrderSummaryData() async{
    var url = Uri.parse("https://happybuy.appsticit.com/orders");
    var heroResponse = await http.get(url,headers: {"Content-Type": "application/json"});
    if(heroResponse.statusCode == 200){
      var jsonDecode = json.decode(heroResponse.body);
      var convertData = json.encode(jsonDecode);
      return getAllOrderSummaryFromJson(heroResponse.body);
    }
    return null;
  }

}