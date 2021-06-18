import 'dart:convert';

import 'package:flutter/material.dart';
import 'mainscreen.dart';
import 'registerScreen.dart';
import 'package:http/http.dart' as http ;


class User{
  final String username, password;
  User(this.username, this.password);
}


class LoginScreen extends StatefulWidget {
  static const String idScreen = "register";
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

postLoginData() async {
  var request = http.Request('POST', Uri.parse('https://chargify.eu-gb.cf.appdomain.cloud/api/charger/get')); request.body = json.encode({   "location": [     73.0673499,     19.0465953   ] });
      http.StreamedResponse response = await request.send();
  print(response.stream.bytesToString());
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(65, 193, 186, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 300,
                    height: 280,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/chargify.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                ),
                controller: usernameController,

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(style: TextStyle(color: Colors.white),

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                ),
                controller: passwordController,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(54,91,109,1), borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  Navigator.push(
                     context, MaterialPageRoute(builder: (_) => MainScreen()));
                  String name = usernameController.text;
                  String pass = passwordController.text;
                  //postLoginData();
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
                onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => RegistrationScreen()));
                  },
                child: Text('New User? Create Account'))
          ],
        ),
      ),
    );
  }
}