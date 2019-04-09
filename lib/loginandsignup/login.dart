import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'signup.dart';
import 'package:agora/makeRequest.dart';
import 'package:agora/HomeUI/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double height;
  double width;
  bool obscure = false;
  bool startAnimation = false;
  Map<String, dynamic> receivedData = {};

  void loginFunction() async {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("logging you in please wait...."),
        duration: Duration(seconds: 7),
        backgroundColor: Color(0xFF018752),
      ),
    );

    Map<String, String> data = {
      "identifier": userNameController.text.toString(),
      "password": passwordController.text.toString()
    };
    MakeRequest makeRequest = MakeRequest(
        "http://agora-rest-api.herokuapp.com/api/v1/auth/login", data);

    try {
      receivedData = await makeRequest.postrequest();

      if (receivedData['status'] == 200) {
        Map<String, String> temp;

        temp = Map.from(receivedData['data']['token']);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("username", receivedData['data']['username']);
        await prefs.setString("pass", passwordController.text);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return DashBoard(data: receivedData['data']);
          },
        ), (Route<dynamic> route) => false);
      } else {
        print("Error is : $receivedData");
        setState(() {
          startAnimation = false;
        });
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "Wrong ID password please check your ID password and try again"),
            duration: Duration(seconds: 5),
            backgroundColor: Color(0xFF018752),
          ),
        );
      }
    } catch (e) {
      setState(() {
        startAnimation = false;
      });
      print("error : $e");
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
              "Some problem accured please check your internet connection and try again later"),
          duration: Duration(seconds: 5),
          backgroundColor: Color(0xFF018752),
        ),
      );
    }
  }

  void forgotPasswordFunction() {}

  Widget contentsOfCard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: 120,
              child: FlareActor(
                "assets/SplashScreen.flr",
                alignment: Alignment.center,
                animation: "splashPlay",
                fit: BoxFit.fill,
                isPaused: !startAnimation,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFF018752),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            width: width * 0.8,
            child: TextField(
              controller: userNameController,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: "Enter username",
                hasFloatingPlaceholder: true,
                labelStyle: TextStyle(color: Color(0xFF018752), fontSize: 14.0),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            width: width * 0.8,
            child: TextField(
              controller: passwordController,
              style: TextStyle(
                fontSize: 18.0,
              ),
              obscureText: obscure,
              decoration: InputDecoration(
                  labelText: "Enter Password",
                  hasFloatingPlaceholder: true,
                  labelStyle:
                      TextStyle(color: Color(0xFF018752), fontSize: 14.0),
                  suffixIcon: IconButton(
                    icon: obscure
                        ? Icon(
                            Icons.visibility_off,
                            color: Color(0xFF018752),
                          )
                        : Icon(
                            Icons.visibility,
                            color: Color(0xFF018752),
                          ),
                    onPressed: () {
                      if (obscure) {
                        setState(() {
                          obscure = false;
                        });
                      } else {
                        setState(() {
                          obscure = true;
                        });
                      }
                    },
                  )),
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          RaisedButton(
            onPressed: () {
              if (userNameController.text.length > 3 &&
                  passwordController.text.length >= 5) {
                setState(() {
                  startAnimation = true;
                });
                loginFunction();
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                    "Field value too short or wrong input try again later",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 5),
                  backgroundColor: Color(0xFF018752),
                ));
              }
            },
            elevation: 15.0,
            child: Container(
              width: width * 0.6,
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            splashColor: Colors.white30,
            highlightColor: Colors.black12,
            clipBehavior: Clip.antiAlias,
            // color: Color(0xFFFFCD00),
            color: Colors.yellow[700],
          ),
          SizedBox(
            height: height * 0.005,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot your password",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Not implemented yet"),
                  duration: Duration(seconds: 4),
                  backgroundColor: Color(0xFF018752),
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            color: Color(0xFF018752),
            width: width * 0.8,
            height: 1.0,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RaisedButton(
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Not implemented yet"),
                  duration: Duration(seconds: 4),
                  backgroundColor: Color(0xFF018752),
                ),
              );
            },
            elevation: 15.0,
            child: Container(
              width: width * 0.6,
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Login with Facebook",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            splashColor: Colors.white30,
            highlightColor: Colors.black12,
            clipBehavior: Clip.antiAlias,
            // color: Color(0xFFFFCD00),
            color: Color(0xFF3b5998),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Don't Have Account",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUp();
              }));
            },
          ),
        ],
      ),
    );
  }

  Widget loginUI() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: height,
            width: width,
            child: Image.asset(
              "assets/background.png",
              alignment: Alignment.center,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
          Container(
            height: height * 0.92,
            width: width * 0.92,
            child: Card(
              color: Colors.white,
              elevation: 15.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: SingleChildScrollView(
                child: contentsOfCard(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: loginUI(),
      resizeToAvoidBottomInset: true,
    );
  }
}
