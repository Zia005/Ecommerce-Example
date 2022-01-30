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

import 'home_screen.dart';

class CartItemScreen extends StatefulWidget {
  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController ctAddress = TextEditingController();
  TextEditingController ctPhone = TextEditingController();
  UserInfo user = new UserInfo();
  late String token = "";
  late String type = "";
  late String name = "";

  final Controller _controller = Get.put(Controller());
  var dbjson = [];

  bool information = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userName = new TextEditingController();
  TextEditingController userEmail = new TextEditingController();
  TextEditingController userAddress = new TextEditingController();
  TextEditingController userCity = new TextEditingController();
  TextEditingController userPhone = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getTotal();
    _Dataquery();
    _controller.getAllCartList();
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
            information ? Container() : TextButton(
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
        body: information ?
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 6),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Give Your Information",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.safeBlockVertical * 3.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      new TextFormField(
                        controller: userName,
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Color(0xFF0072bc) ),
                        decoration: new InputDecoration(
                          labelText: 'Name',
                          hintStyle: TextStyle(color: Color(0xFF0072bc)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.text,
                        validator: validateName,
                      ),
                      new TextFormField(
                        controller: userPhone,
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Color(0xFF0072bc) ),
                        decoration: new InputDecoration(
                          labelText: 'Mobile Number',
                          hintStyle: TextStyle(color: Color(0xFF0072bc)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.number,
                        validator: validateNumber,
                      ),
                      new TextFormField(
                        controller: userEmail,
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Color(0xFF0072bc) ),
                        decoration: new InputDecoration(
                          labelText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFF0072bc)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      new TextFormField(
                        controller: userCity,
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Color(0xFF0072bc) ),
                        decoration: new InputDecoration(
                          labelText: 'City',
                          hintStyle: TextStyle(color: Color(0xFF0072bc)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.text,
                        validator: validateCity,
                      ),
                      new TextFormField(
                        controller: userAddress,
                        maxLines: 2,
                        autofocus: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Color(0xFF0072bc) ),
                        decoration: new InputDecoration(
                          labelText: 'Address',
                          hintStyle: TextStyle(color: Color(0xFF0072bc)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: validateAddress,
                      ),

                      RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2,
                            color: Colors.blueGrey,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Please provide your information, ',style: new TextStyle(fontWeight: FontWeight.bold)),
                            new TextSpan(text: "we don't want to wait you longer to get your product",style: new TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 1,
                      ),
                      Container(
                          height: SizeConfig.safeBlockVertical * 14.8,
                          width: SizeConfig.safeBlockHorizontal * 90,
                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total ",
                                    style: TextStyle(
                                        color: Color(0xFF241e1e),
                                        fontSize: 18
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(getTotal().toString(),
                                    style: TextStyle(
                                        color: Color(0xFFf9951b),
                                        fontSize: 18
                                    ),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                child: Container(
                                  height: SizeConfig.safeBlockVertical * 7,
                                  width: SizeConfig.safeBlockHorizontal * 90,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF312f94),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.fromLTRB(10,5,10,5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_shopping_cart_outlined,color: Color(0xFFfffffa),),
                                      SizedBox(width: 10,),
                                      Text("Place Order",
                                        style: TextStyle(
                                            color: Color(0xFFfffffa),
                                            fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    getUserDataFromSharedPreference();
                                    dbHelper.deleteall();
                                    _Dataquery();
                                    setState(() {});
                                  }

                                },
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ):
        SingleChildScrollView(
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
        bottomNavigationBar: information ? Container(height: SizeConfig.safeBlockVertical * .2,) :
        Container(
          // height: MediaQuery.of(context).size.height * .092,
            height: SizeConfig.safeBlockVertical * 8,
            child: Column(
              children: [
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        information =true;
                      });
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


  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    }else if(value.length >= 3){
      return null;
    }else{
      return "Name must be at least 3 characters long";
    }
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    }else if(value.length >= 3){
      return null;
    }else{
      return "City name must be at least 3 characters long";
    }
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    }else if(value.length == 11){
      return null;
    }else{
      return "Mobile number should be 11 characters long";
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "* Required";
    }else if(!regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    }else if(value.length >= 5){
      return null;
    }else{
      return "Address can't be short, give the full details";
    }
  }

  Future _Dataquery() async {
    _controller.dataCartList.clear();
    final allRows = await dbHelper.queryAllRows();
    //  print('query all rows:');
    //  allRows.forEach((row) => print(row));
    // print(allRows[0]["_id"]);
    dbHelper.queryAllRows().then((notes) {
      notes.forEach((note) {
        // dbjson = dbjson + ((('{product_id: '+note['product_id'].toString()+
        //     ', product_name: '+note['product_name']+
        //     ', price: '+note['price'].toString()+
        //     ', quantity: '+note['quantity'].toString()) + "}"));
        // dbjson = dbjson +jsonEncode(note)+',' ;

        _controller.dataCartList.add(Model.fromMapObject(note));
        dbjson.add(note);
        //d_items.add(Model.fromMapObject(notes));
        //count.add((Model.fromMapObject(notes).pQuantity));
      });
      print(dbjson);
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
  Future createOrder() async {
    print("create order");
    // set up POST request arguments
    Uri url = Uri.parse(Config.orderUrl+"?consumer_key="+Config.key+"&consumer_secret="+Config.secret);
    Map<String, String> headers = {"Content-type": "application/json"};

    var userData = {
      "total": 265,
      "payment_method": "cash_on_delevery",
      "billing": {
        "first_name": "Zia",
        "address_1": "",
      },
      // "items": dbjson
    };
    var orderData = {
      // "invoice": userData,
      "total": getTotal().toString(),
      // "shipping_total": "262",
      // "discount_total": "261",
      "billing": {
        "first_name": userName.text,
        "address_1": userAddress.text,
        "city": userCity.text,
        "state": "",
        "postcode": "",
        "country": "",
        "email": userEmail.text,
        "phone": userPhone.text
      },
      "shipping": {
        "first_name": userName.text,
        "address_1": userAddress.text,
        "city": userCity.text,
        "country": "Bangladesh",
        "phone": userPhone.text
      },
      "payment_method": "cash_on_delevery",
      "line_items": dbjson
    };
    print(jsonEncode(orderData));
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      dbHelper.deleteall();
      _Dataquery();
      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderListScreen(162)));
      print(response.body);
    }
    //  this API passes back the id of the new item added to the body
  }

  int totalAmount = 0;
  getTotal() {
    totalAmount = 0;
    for (var i = 0; i < _controller.dataCartList.length; i++) {
      totalAmount += _controller.dataCartList[i].productPrice *
          _controller.dataCartList[i].productQuantity;
    }
    return totalAmount;
  }

  Future getUserDataFromSharedPreference() async {
    Future<String?> userName = user.getName();
    await userName.then((data) {
      name = data.toString();
      print(name);
    }, onError: (e) {
      print(e);
    });


    if (name.length > 5) {
      // _Dataquery();
      createOrder();
      _controller.dataCartList.clear();
      final snackBar = SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: Text('Order Placed Successfully !'),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CartItemScreen()),);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 1));
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    // else if(type == 'admin'){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
    //}
    // else if(type == 'user'){
    //   Navigator.pop(context);
    //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardClient2()));
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

}