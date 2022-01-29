import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_78/assistant/controller.dart';
import 'package:ecommerce_78/assistant/helper.dart';
import 'package:ecommerce_78/assistant/size_config.dart';
import 'package:ecommerce_78/assistant/user_info.dart';
import 'package:ecommerce_78/database/db_helper.dart';
import 'package:ecommerce_78/screens/details_page.dart';
import 'package:ecommerce_78/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'cart_screen.dart';
import 'category_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  late double displayHeight = MediaQuery.of(context).size.height;
  late double displayWidth = MediaQuery.of(context).size.width;

  String userName = "";
  final _controller = Get.put(Controller());
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
    // _controller.getAllOrderList();
    _controller.getAllCategoryList();
    _controller.getAllProductList();
    _controller.getAllSliderList();
    // print(_controller.dataOrderList.length.toString()+" hello");

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(userName),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('E-Commerce App',
                    style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      // );
                    },
                    child: const CircleAvatar(
                      // child: Image.network('url'),
                      radius: 25, foregroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    // height: screenHeight * 0.25,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: Obx((){
                            if(_controller.loadingSliderList.value){
                              return CircularProgressIndicator();
                            }else{
                              return CarouselSlider.builder(
                                itemCount: _controller.dataSliderList.length,
                                itemBuilder: (context,index,pageViewIndex){
                                  return CachedNetworkImage(
                                    imageUrl: Helper.baseUrl+_controller.dataSliderList[index].sliderImage.toString()
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  height: 190,viewportFraction: 1,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlayAnimationDuration: Duration(seconds: 2)
                                )
                              );
                            }
                          }),

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Categories',
                              style: TextStyle(
                                  fontSize: 20, fontWeight:  FontWeight.bold
                              ),
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.arrow_right_alt, size: 30),
                            )
                          ],
                        ),
                        Obx((){
                          if(_controller.loadingCategoryList.value){
                            return CircularProgressIndicator();
                          }else{
                            return Container(
                              height: displayHeight * 0.19,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4EFEF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller.dataCategoryList.length,
                                itemBuilder: (context,index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: displayHeight * 0.10,
                                          width: displayWidth * .20,
                                          child: Center(
                                              child: Image.network("https://happybuy.appsticit.com"+_controller.dataCategoryList[index].categoryImage.toString())

                                          ),
                                        ),
                                        Container(
                                          height: displayHeight * 0.06,
                                          width: displayWidth * .20,
                                          child:  Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Text(_controller.dataCategoryList[index].name.toString(),
                                                style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            );
                          }

                        }),

                      ],
                    ),
                  ),
                  SizedBox(height: displayHeight * 0.02),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF2F5F5),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Divider(indent: 200, endIndent: 200, thickness: 5),
                    SizedBox(height: displayHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Most Popular',
                          style: TextStyle(
                            fontSize: 20, fontWeight:  FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.arrow_right_alt, size: 30),
                        )
                      ],
                    ),
                    SizedBox(height: displayHeight * 0.01),
                    // Obx((){
                    //   if(_controller.loadingProductList.value){
                    //     return CircularProgressIndicator();
                    //   }else{
                    //     return Container(
                    //       height: displayHeight * 0.8,
                    //       width: displayWidth,
                    //       child: GridView.builder(
                    //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisSpacing: 5,
                    //           crossAxisCount: 2,
                    //           mainAxisSpacing: 5,
                    //         ),
                    //         itemCount: _controller.dataProductList.length,
                    //         scrollDirection: Axis.vertical,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return GestureDetector(
                    //             onTap: (){
                    //               Navigator.push(context,
                    //                   MaterialPageRoute(builder: (context) => const SofaDetails())
                    //               );
                    //             },
                    //             child: Container(
                    //               height: displayHeight * 0.20,
                    //               width:  displayWidth * 0.30,
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   Container(
                    //                     height: displayHeight * 0.10,
                    //                     width:  displayWidth * 0.20,
                    //                     child: ClipRRect(
                    //                       child: Image.network(
                    //                         "https://happybuy.appsticit.com"+_controller.dataProductList[index].img1.toString(),
                    //                         fit: BoxFit.scaleDown,
                    //                       ),
                    //                       borderRadius: BorderRadius.circular(30),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 5),
                    //                   Text(_controller.dataProductList[index].name.toString(),
                    //                     style: TextStyle(fontWeight: FontWeight.bold),
                    //                   ),
                    //                   const SizedBox(height: 5),
                    //                   Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                     children:  [
                    //                       Text("৳ "+_controller.dataProductList[index].price.toString(),
                    //                         style: TextStyle(
                    //                           decoration: TextDecoration.lineThrough,
                    //                           color: Colors.red,
                    //                         ),
                    //                       ),
                    //                       Text("৳ "+_controller.dataProductList[index].sellingPrice.toString())
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   }
                    // }),
                    Obx((){
                      if(_controller.loadingProductList.value){
                        return CircularProgressIndicator();
                      }
                      else{
                        return Container(
                          height: displayHeight * 0.8,
                          width: displayWidth,
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: _controller.dataProductList.length,
                              itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(ind: index)));
                                  },
                                  child: Container(
                                    height: displayHeight * 0.20,
                                    width: displayWidth * 0.40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          child: Container(
                                            height: displayHeight*.10,
                                            width: displayWidth * 0.40,
                                            child: Image.network(
                                              "https://happybuy.appsticit.com"+_controller.dataProductList[index].img1,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          _controller.dataProductList[index].name.toString(),
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                onPressed: (){

                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                                                },
                                                child: Text(
                                                  'Add to Cart',
                                                )
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  _controller.dataProductList[index].price,
                                                  style: TextStyle(
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(_controller.dataProductList[index].sellingPrice)
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getSharedPreferenceData() async{
    UserInfo user = UserInfo();
    await user.getEmail().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  void insertUpdate(index) async {
    print("add to card");
    Map<String, dynamic> row = {
      DatabaseHelper.proid: _controller.dataProductList[index].id,
      DatabaseHelper.proName: _controller.dataProductList[index].name,
      DatabaseHelper.proQuantity: 1,
      DatabaseHelper.pImg: _controller.dataProductList[index].img1,
      DatabaseHelper.proPrice: _controller.dataProductList[index].price,
      DatabaseHelper.tPrice: _controller.dataProductList[index].price,
    };

    final checkPro = await dbHelper.checkProduct(_controller.dataProductList[index].id.toString());
    if (checkPro == null) {
      final idupdate = await dbHelper.insert(row);
      print(idupdate.toString() + "insert");
      setState(() {});
    } else {
      final updatedata = await dbHelper.updateCartList(row, _controller.dataProductList[index].id);
      print(updatedata.toString() + "update");
      setState(() {});
    }


  }

}

