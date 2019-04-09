import 'package:agora/loginandsignup/login.dart';
import 'package:flutter/material.dart';

import 'signupemail.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double height;
  double width;
  String _userName = '', _firstName = '', _lastName = '';

  void haveAccountFunction() {}

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
                child: Image.asset(
                  "assets/agora.png",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                )),
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
              controller: firstNameController,
              style: TextStyle(
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                labelText: "Enter First Name",
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
              controller: lastNameController,
              style: TextStyle(
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                labelText: "Enter Last Name",
                hasFloatingPlaceholder: true,
                labelStyle: TextStyle(color: Color(0xFF018752), fontSize: 14.0),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          RaisedButton(
            onPressed: () {
              _userName = userNameController.text;
              _firstName = firstNameController.text;
              _lastName = lastNameController.text;
              if (_userName.length > 4 && _firstName.length > 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpEmail(
                    firstName: _firstName,
                    lastName: _lastName,
                    userName: _userName,
                  );
                }));
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                    "Field value too short or wrong input try again",
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
                    "Continue",
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
            height: height * 0.02,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Already Have an Account",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> Login()
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget signUpUI() {
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
      body: signUpUI(),
      resizeToAvoidBottomInset: true,
    );
  }
}
