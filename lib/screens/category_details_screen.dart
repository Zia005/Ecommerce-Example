import 'package:ecommerce_78/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ElectronicDevices extends StatefulWidget {
  const ElectronicDevices({Key? key}) : super(key: key);

  @override
  _ElectronicDevicesState createState() => _ElectronicDevicesState();
}

class _ElectronicDevicesState extends State<ElectronicDevices> {
  late double displayHeight = MediaQuery.of(context).size.height;
  late double displayWidth = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElectronicDevices'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: displayHeight,
            width: displayWidth,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
              ),
              itemCount: 15,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDetailsScreen()));
                  },
                  child: Container(
                    height: displayHeight * 0.15,
                    width: displayWidth * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Image.network(
                            'https://cdn-images.article.com/products/SKU25A/2890x1500/image74669.jpg?fit=max&w=1370&q=80&fm=webp',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Andes Sofa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "৳ 10000",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                              ),
                            ),
                            Text("৳ 9000")
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
