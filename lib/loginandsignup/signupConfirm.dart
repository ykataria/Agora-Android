import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'login.dart';

class SignUpConfirm extends StatefulWidget {
  @override
  _SignUpConfirmState createState() => _SignUpConfirmState();
}

class _SignUpConfirmState extends State<SignUpConfirm> {
  double height;
  double width;

  Widget ui() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Waiting for Account activation",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF018752)
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 180,
              width: 180,
              child: FlareActor(
                "assets/SplashScreen.flr",
                alignment: Alignment.center,
                animation: "splashPlay",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "A message has been sent to your email. Please follow the link provided in the email to activate your account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Color(0xFF018752)),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ), (Route<dynamic> route) => false);
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
          )
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
                child: ui(),
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
      body: signUpUI(),
    );
  }
}
