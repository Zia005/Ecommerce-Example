import 'package:ecommerce_78/screens/home_screen.dart';
import 'package:ecommerce_78/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assistant/user_info.dart';

void main() {
  runApp(
      MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String userName ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferenceData();

    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      if(userName != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void getSharedPreferenceData() async{
    UserInfo user = new UserInfo();
    await user.getName().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }
}


