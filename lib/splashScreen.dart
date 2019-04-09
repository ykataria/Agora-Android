import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './loginandsignup/login.dart';
import 'package:agora/HomeUI/dashboard.dart';

import 'makeRequest.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String username;
  String password;
  Map<dynamic, dynamic> rdata = {};

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    password = prefs.getString('pass');

    print("Username is : $username");
    print("Password is : $password");

    if (username != null && password != null) {
      print("Inside if");
 
      Map<String, String> data = {
        "identifier": username.toString(),
        "password": password.toString()
      };
      MakeRequest makeRequest =
          MakeRequest("http://agora-rest-api.herokuapp.com/api/v1/auth/login", data);

      try {
        rdata = await makeRequest.postrequest();
        print("Data is ${rdata['status']}");
        print("Data is $rdata");
        if (rdata['status'] == 200) {
          Future.delayed(
            Duration(seconds: 3),
            () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoard(data: rdata['data']);
                },
              ), (Route<dynamic> route) => false);
            },
          );
        } else {
          Future.delayed(
            Duration(seconds: 3),
            () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ), (Route<dynamic> route) => false);
            },
          );
        }
      } catch (e) {
        print("error : $e");
        Future.delayed(
          Duration(seconds: 3),
          () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ), (Route<dynamic> route) => false);
          },
        );
      }
    } else {
      Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          ), (Route<dynamic> route) => false);
        },
      );
    }
  }

  Widget mainUI() {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
              height: 220.0,
              width: 220.0,
              child: Center(
                child: FlareActor(
                  "assets/SplashScreen.flr",
                  alignment: Alignment.center,
                  animation: "splashPlay",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text(
              "Agora Vote",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF018752),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainUI(),
      backgroundColor: Colors.white,
    );
  }
}
