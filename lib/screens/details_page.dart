import 'package:ecommerce_78/assistant/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ProductDetails extends StatefulWidget {
  int ind;
  ProductDetails({required this.ind});

  @override
  _ProductDetailsState createState() => _ProductDetailsState(index: ind);
}

class _ProductDetailsState extends State<ProductDetails> {

  final _controller = Get.put(Controller());
  int index;
  _ProductDetailsState({required this.index});
  late double displayHeight = MediaQuery.of(context).size.height;
  late double displayWidth = MediaQuery.of(context).size.width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  "https://happybuy.appsticit.com"+_controller.dataProductList[index].img1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _controller.dataProductList[index].name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: displayHeight * 0.01),
            Container(
              child: Text(
                _controller.dataProductList[index].description,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: displayHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Regular Price: ${_controller.dataProductList[index].price}",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Discount Price: ${_controller.dataProductList[index].sellingPrice}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(height: displayHeight * 0.02),
            GestureDetector(
              onTap: (){},
              child: Container(
                height: displayHeight * 0.05, width: displayWidth * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child:  const Center(
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.white),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
