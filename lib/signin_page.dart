import 'package:ecommerce_78/assistant/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final globalKey=GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  Widget textFormField (String hint, String label, var controller, String type){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hint,
        labelText: label,
      ),
      validator: (value){
        if(type=='name'){
          if(value!.length>3){
            return null;
          }
          else{
            return  "Name length must be more than 3 letters";
          }
        }else{
          if(value!.length>7){
            return null;
          }
          else{
            return  "Password length must be more than 7 letters";
          }
        }
      },
    );
  }

  bool ok=false;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff640999),
            height: height*.4,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width*.4, height*.17, 0, 0),
            child: Column(
              children: [
                Text(
                  'E-mart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height*.35),
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, height*.05, width*.40, 0),
                      child: Text(
                        'Sign in to go ahead',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*.15, height*.05, width*.15, 0),
                      child: textFormField('Username','Username',nameController,'name'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*.15, height*.05, width*.15, 0),
                      child: textFormField('Password','Password',passController,'pass'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*.15, height*.01, width*.15, 0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: ok,
                            onChanged: (val){
                              setState(() {
                                ok=!ok;
                              });
                            }
                          ),
                          Text('Save Password'),
                          Padding(
                            padding: EdgeInsets.only(left: width*.1),
                            child: TextButton(
                              onPressed: (){

                              },
                              child: Text(
                                'Forgot Password?',
                              ),
                            )
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*.3, height*.05, width*.3, 0),
                      child: MaterialButton(
                        onPressed: (){
                           if(globalKey.currentState!.validate()){
                              UserInfo user = UserInfo();
                              if(ok){
                                user.saveUserNameToSharedPreference(nameController.text);
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                           }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.blue,
                        height: height*.07,
                        minWidth: width*.3,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(width*.1, height*.02, width*.15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Do not have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextButton(
                              onPressed: (){

                              },
                              child: Text(
                                'Create one',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
