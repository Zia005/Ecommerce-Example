import 'package:ecommerce_78/assistant/fetch_all_api_data.dart';
import 'package:ecommerce_78/model/get_all_category_list.dart';
import 'package:ecommerce_78/model/get_all_product_list.dart';
import 'package:ecommerce_78/model/get_all_sliders.dart';
import 'package:ecommerce_78/model/get_all_user_list.dart';
import 'package:ecommerce_78/model/get_order_list.dart';
import 'package:ecommerce_78/model/get_order_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  var loadingCategoryList = true.obs;
  var loadingOrderList = true.obs;
  var loadingProductList = true.obs;
  var loadingSliderList = true.obs;
  var loadingUserList = true.obs;
  var loadingOrderSummaryList = true.obs;

  var dataCategoryList = List<GetAllCategoryList>.empty().obs;
  var dataOrderList = List<GetAllOrderList>.empty().obs;
  var dataProductList = List<GetAllProductList>.empty().obs;
  var dataSliderList = List<GetAllSliderList>.empty().obs;
  var dataUserList = List<GetAllUserList>.empty().obs;
  var dataOrderSummaryList = List<GetAllOrderSummaryList>.empty().obs;

  void init(BuildContext context){
    getAllCategoryList();
    getAllOrderList();
    getAllOrderSummaryList();
    getAllSliderList();
    getAllUserList();
    getAllProductList();
  }

  getAllCategoryList() async{
    try{
      loadingCategoryList(true).obs;
      var data = await LoadAllApiData.fetchAllCategoryData();

      if(data != null){
        dataCategoryList = data as RxList<GetAllCategoryList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingCategoryList(false).obs;
    }
  }

  getAllOrderList() async{
    try{
      loadingOrderList(true).obs;
      var data = await LoadAllApiData.fetchAllOrderData();

      if(data != null){
        dataOrderList = data as RxList<GetAllOrderList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingOrderList(false).obs;
    }
  }

  getAllProductList() async{
    try{
      loadingProductList(true).obs;
      var data = await LoadAllApiData.fetchAllProductData();

      if(data != null){
        dataProductList = data as RxList<GetAllProductList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingProductList(false).obs;
    }
  }

  getAllSliderList() async{
    try{
      loadingSliderList(true).obs;
      var data = await LoadAllApiData.fetchAllSliderData();

      if(data != null){
        dataSliderList = data as RxList<GetAllSliderList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingSliderList(false).obs;
    }
  }

  getAllUserList() async{
    try{
      loadingUserList(true).obs;
      var data = await LoadAllApiData.fetchAllUserData();

      if(data != null){
        dataUserList = data as RxList<GetAllUserList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingUserList(false).obs;
    }
  }

  getAllOrderSummaryList() async{
    try{
      loadingOrderSummaryList(true).obs;
      var data = await LoadAllApiData.fetchAllOrderSummaryData();

      if(data != null){
        dataOrderSummaryList = data as RxList<GetAllOrderSummaryList>;
      }
    }catch(e){
      print(e);
    }finally{
      loadingOrderSummaryList(false).obs;
    }
  }

}