import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SofaDetails extends StatefulWidget {
  const SofaDetails({Key? key}) : super(key: key);

  @override
  _SofaDetailsState createState() => _SofaDetailsState();
}

class _SofaDetailsState extends State<SofaDetails> {

  late double displayHeight = MediaQuery.of(context).size.height;
  late double displayWidth = MediaQuery.of(context).size.width;

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
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                'https://cdn-images.article.com/products/SKU25A/2890x1500/image74678.jpg?fit=max&w=1370&q=80&fm=webp',
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Ceni Volcanic Gray Sofa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: displayHeight * 0.01),
            Container(
              child: const Text(
                'Intentionally designed to sit low to the ground, the Ceni '
                    'Sofa is a contemporary take on a vintage silhouette. '
                    'Designed with loose cushions, track arm rests, and a '
                    'solid wood base, the Ceni features a firmly padded back '
                    'cushion and medium-firm seat composed of sinuous '
                    'springs and foam for a deep-seated lounge experience. '
                    'A bit of bounce relaxes for increased comfort overtime.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: displayHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Regular Price: 10000৳",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                Text("Discount Price: 9000৳",
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
                  child: Text('ADD TO CART',
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
