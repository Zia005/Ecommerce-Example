import 'dart:convert';

import 'package:ecommerce_78/model/get_all_category_list.dart';
import 'package:ecommerce_78/model/get_all_product_list.dart';
import 'package:ecommerce_78/model/get_all_sliders.dart';
import 'package:ecommerce_78/model/get_all_user_list.dart';
import 'package:ecommerce_78/model/get_order_list.dart';
import 'package:ecommerce_78/model/get_order_summary.dart';
import 'package:http/http.dart' as http;

class FetchAllApiData{

  final clientObject = http.Client;

  Future<List<GetOrderList>> fetchAllOrderData(clientObject) async{
    var url = Uri.parse("https://happybuy.appsticit.com/orders");
    var heroResponse = await clientObject.get(url);

    // if(heroResponse.statusCode == 200){
    //   var jsonDecode = json.decode(heroResponse.body);
    // }
    return getOrderListFromJson(heroResponse.body);
  }

  Future<GetAllCategoryList> fetchAllCategoryData(http.Client client) async{
    var url = Uri.parse("https://happybuy.appsticit.com/getallcategory");
    var heroResponse = await client.get(url);
    return getAllCategoryListFromJson(heroResponse.body);
  }

  Future<GetAllProductData> fetchAllProductData(http.Client client) async {
    var url = Uri.parse("https://happybuy.appsticit.com/getallproductdata");
    var heroResponse = await client.get(url);
    return getAllProductDataFromJson(heroResponse.body);
  }

  Future<GetAllSlider> fetchAllSliderData(http.Client client) async{
    var url = Uri.parse("https://happybuy.appsticit.com/getallsliders");
    var heroResponse = await client.get(url);
    return getAllSliderFromJson(heroResponse.body);
  }

  Future<UserData> fetchAllUserData(http.Client client) async{
    var url = Uri.parse("https://happybuy.appsticit.com/allUserList");
    var heroResponse = await client.get(url);
    return getAllUserDataFromJson(heroResponse.body);
  }

  Future<GetOrderSummary> fetchAllOrderSummaryData(http.Client client) async{
    var url = Uri.parse("https://happybuy.appsticit.com/orders");
    var heroResponse = await client.get(url);
    return getAllOrderSummaryFromJson(heroResponse.body);
  }

}