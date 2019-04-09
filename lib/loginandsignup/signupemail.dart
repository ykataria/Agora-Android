import 'package:agora/loginandsignup/login.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:agora/makeRequest.dart';
import 'signupConfirm.dart';

class SignUpEmail extends StatefulWidget {
  final String userName, firstName, lastName;

  const SignUpEmail(
      {Key key,
      @required this.userName,
      @required this.firstName,
      @required this.lastName})
      : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formkey = new GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double height;
  double width;
  bool obscure = false;
  bool startAnimation = false;

  Map<String, dynamic> receivedData = {};

  void signUpFunction() async {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Signing you up please wait...."),
        duration: Duration(seconds: 7),
        backgroundColor: Color(0xFF018752),
      ),
    );

    Map<String, String> data = {
      "identifier": widget.userName,
      "password": passwordController.text,
      "email": emailController.text,
      "firstName": widget.firstName,
      "lastName": widget.lastName
    };
    MakeRequest makeRequest = MakeRequest(
        "http://agora-rest-api.herokuapp.com/api/v1/auth/signup", data);

    try {
      receivedData = await makeRequest.postrequest();
      print("Data is is : $receivedData");

      if (receivedData['status'] == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return SignUpConfirm();
            },
          ), (Route<dynamic> route) => false);
      } else {
        setState(() {
          startAnimation = false;
        });
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "Error in signup please verify your credentials or check if you already have an account"),
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else {
      return null;
    }
  }

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
              "Sign Up",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFF018752),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                Container(
                  width: width * 0.8,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    controller: emailController,
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      labelText: "Enter your email",
                      hasFloatingPlaceholder: true,
                      labelStyle:
                          TextStyle(color: Color(0xFF018752), fontSize: 14.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  width: width * 0.8,
                  child: TextFormField(
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
                      ),
                    ),
                    validator: (val) => val.length < 5
                        ? "Password should be atleast 6 charater long"
                        : null,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          RaisedButton(
            onPressed: () {
              if (formkey.currentState.validate()) {
                setState(() {
                  startAnimation = true;
                });
                signUpFunction();
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
                    "Sign Up",
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
            height: height * 0.05,
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
                "Already Have An Account",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget signUp() {
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
      body: signUp(),
      resizeToAvoidBottomInset: true,
    );
  }
}
