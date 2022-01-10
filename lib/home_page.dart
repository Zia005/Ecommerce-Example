import 'package:ecommerce_78/assistant/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userName ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferenceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
    );
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
