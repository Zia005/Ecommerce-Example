import 'dart:convert';

import 'package:ecommerce_78/assistant/controller.dart';
import 'package:ecommerce_78/assistant/size_config.dart';
import 'package:ecommerce_78/assistant/user_info.dart';
import 'package:ecommerce_78/database/db_helper.dart';
import 'package:ecommerce_78/database/db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class CartItemScreen extends StatefulWidget {
  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  final dbHelper = DatabaseHelper.instance;
  final Controller _controller = Get.put(Controller());
  var dbjson =[];
  int totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    getTotal();
    _Dataquery();
    _controller.dataCartList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF312f94),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print("delete");
              dbHelper.deleteall();
              _Dataquery();
              setState(() {});
            },
            child: Text("Clear",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Slider
            Container(
                height: MediaQuery.of(context).size.height / 1.31,
                child: Obx(() {
                  if (_controller.dataCartList.length == 0) {
                    return Center(
                      child: Text(" No Data Please Add New Item"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: _controller.dataCartList.length,
                        itemBuilder: (BuildContext contex, int index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    // width: MediaQuery.of(context).size.width * .28,
                                    // height: MediaQuery.of(context).size.height * .15,
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    child: Image.network(
                                      _controller.dataCartList[index].pImg,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 130,
                                    // height: MediaQuery.of(context).size.height * .14,

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // width: MediaQuery.of(context).size.width * .5,
                                              // height: MediaQuery.of(context).size.height * .05,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width / 2,
                                                        child: Center(
                                                          child: Text(
                                                              _controller.dataCartList[index].pName,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          _controller.dataCartList[index].pQuantity.toString(),
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                          )),
                                                      Text(" | ",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                          )),
                                                      Text(
                                                        _controller.dataCartList[index].pPrice.toString(),
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  dbHelper.delete(_controller.dataCartList[index].id);
                                                  _Dataquery();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red[300],
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // width: MediaQuery.of(context).size.width * .4,
                                              // height: MediaQuery.of(context).size.height * .05,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '৳ ' +
                                                            (double.parse(_controller.dataCartList[index].productPrice.toString()) *
                                                                _controller.dataCartList[index].pQuantity).toString(),
                                                        style: TextStyle(
                                                            color: Colors.amber,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.black54, // Button color
                                                      child: InkWell(
                                                        splashColor: Colors.white70, // Splash color
                                                        onTap: () {
                                                          _controller.dataCartList[index].pQuantity > 1
                                                              ? _controller.dataCartList[index].pQuantity--
                                                              : 1;
                                                          insertUpdate(index);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      _controller.dataCartList[index].pQuantity.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.black54, // Button color
                                                      child: InkWell(
                                                        splashColor: Colors.white, // Splash color
                                                        onTap: () {
                                                          _controller.dataCartList[index].pQuantity++;
                                                          insertUpdate(index);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        }
                    );
                  }
                })
            ),

            Container(
              // height: MediaQuery.of(context).size.height * .16,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Obx((){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                              "Items :" +
                                  _controller.dataCartList.length.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Text(
                            "Total : " + "৳" + getTotal().toString(),
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // height: MediaQuery.of(context).size.height * .092,
          height: SizeConfig.safeBlockVertical * 8,
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {

                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * .85,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Checkout',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      )
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Color(0xFF312f94),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ],
          )
      )
    );
  }


  Future _Dataquery() async {
    _controller.dataCartList.clear();
    // final allRows = await dbHelper.queryAllRows();
    dbHelper.queryAllRows().then((notes) {
      notes.forEach((note) {
        _controller.dataCartList.add(Model.fromMapObject(note));
        // dbjson.add(note);
        //d_items.add(Model.fromMapObject(notes));
        //count.add((Model.fromMapObject(notes).pQuantity));
      });
      // print(dbjson);
    });
  }

  void insertUpdate(index) async {
    print("add to card");
    Map<String, dynamic> row = {
      DatabaseHelper.proid: _controller.dataCartList[index].id,
      DatabaseHelper.proName: _controller.dataCartList[index].pName,
      DatabaseHelper.proQuantity: _controller.dataCartList[index].pQuantity,
      DatabaseHelper.pImg: _controller.dataCartList[index].pImg,
      DatabaseHelper.proPrice: _controller.dataCartList[index].productPrice,
      DatabaseHelper.tPrice:
      (double.parse(_controller.dataCartList[index].productPrice.toString()) *
          _controller.dataCartList[index].pQuantity)
          .toString(),
    };
    final checkPro =
    await dbHelper.checkProduct(_controller.dataCartList[index].id.toString());
    if (checkPro == null) {
      final idupdate = await dbHelper.insert(row);
      print(idupdate.toString() + "insert");
      setState(() {});
    } else {
      final updatedata =
      await dbHelper.updateCartList(row, _controller.dataCartList[index].id);
      print(updatedata.toString() + "update");

      setState(() {});
    }
    getTotal();
  }

  //order create
  // Future createOrder() async {
  //   print("create order");
  //   // set up POST request arguments
  //   Uri url = Uri.parse(Config.orderUrl+"?consumer_key="+Config.key+"&consumer_secret="+Config.secret);
  //   Map<String, String> headers = {"Content-type": "application/json"};
  //
  //   var userData = {
  //     "total": 265,
  //     "payment_method": "cash_on_delevery",
  //     "billing": {
  //       "first_name": "Zia",
  //       "address_1": "",
  //     },
  //     // "items": dbjson
  //   };
  //   var orderData = {
  //     // "invoice": userData,
  //     "total": getTotal().toString(),
  //     // "shipping_total": "262",
  //     // "discount_total": "261",
  //     "billing": {
  //       "first_name": userName.text,
  //       "address_1": userAddress.text,
  //       "city": userCity.text,
  //       "state": "",
  //       "postcode": "",
  //       "country": "",
  //       "email": userEmail.text,
  //       "phone": userPhone.text
  //     },
  //     "shipping": {
  //       "first_name": userName.text,
  //       "address_1": userAddress.text,
  //       "city": userCity.text,
  //       "country": "Bangladesh",
  //       "phone": userPhone.text
  //     },
  //     "payment_method": "cash_on_delevery",
  //     "line_items": dbjson
  //   };
  //   print(jsonEncode(orderData));
  //   var response = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode(orderData),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     dbHelper.deleteall();
  //     _Dataquery();
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => OrderListScreen(162)));
  //     print(response.body);
  //   }
  //   //  this API passes back the id of the new item added to the body
  // }

  getTotal() {
    totalAmount = 0;
    for (var i = 0; i < _controller.dataCartList.length; i++) {
      totalAmount += _controller.dataCartList[i].productPrice *
          _controller.dataCartList[i].productQuantity;
    }
    return totalAmount;
  }


}
