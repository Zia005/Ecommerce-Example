import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double displayHeight = MediaQuery.of(context).size.height;
  late double displayWidth = MediaQuery.of(context).size.width;
  String str="\$120";
  int unit=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: displayHeight*.75,
            child: ListView.builder(
              itemCount: 10,
                itemBuilder: (context,index){
                  return Container(
                    height: displayHeight*.20,
                    child: Center(
                      child: Container(
                        height: displayHeight*.16,
                        width: displayWidth*.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: displayHeight*.16,
                              child: Image.network(
                                'https://scontent.fdac24-1.fna.fbcdn.net/v/t1.6435-1/p240x240/183486765_991461274926176_2450183245147139496_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=7206a8&_nc_eui2=AeHXEbg_JFSLMdltt3oqihqG8AkHOWJxobbwCQc5YnGhthmAmetZpCbMhWowTWqd4ov4A2K9cn2D3lTZTRTT2Fvr&_nc_ohc=CAYAwI90PVgAX8ybz83&_nc_ht=scontent.fdac24-1.fna&oh=00_AT9-KmZvG6YdSOGvXHb6YZKBfIhDdFFqT8SOXXSPT_gwCg&oe=6214F2B6',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Shanto',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '43',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey
                                      ),
                                    ),
                                    Text(
                                      str,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: (){
                                      setState(() {
                                        unit++;
                                      });
                                    },
                                    icon: Icon(Icons.add)
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: Text("${unit}"),
                                  ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      setState(() {
                                        (unit==0)?unit=0:unit--;
                                      });
                                    },
                                    icon: Icon(Icons.remove)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          Container(
            height: displayHeight*.15,
            child: Center(
              child: Container(
                height: displayHeight*.10,
                width: displayWidth*.80,
                child: ElevatedButton(
                  onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                  },
                  child: Row(
                    children: [
                      Text('Confirm Payment'),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
