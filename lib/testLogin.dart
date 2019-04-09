import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'makeRequest.dart';

class TestLogin extends StatefulWidget {
  @override
  _TestLoginState createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  int result;
  Map tempData = {};

  Future<int> getRequest() async {
    try {
      var response = await http.get(
          Uri.parse("http://agora-rest-api.herokuapp.com/api/v1/user"),
          headers: {
            "X-Auth-Token":
                "test"
          });

      if(response.statusCode == 200)
      {
        print("Http returned 200 : ${response.body}");
      }
      else
      {
        print("Http returned ${response.statusCode} and : ${response.statusCode}");
      }

    } catch (e) {
      print("Error $e");
    }
  }

  Future<int> checkLogin() async {
    Map data = {"identifier": "test", "password": "Test"};
    try {
      var response = await http.post(
        Uri.parse("http://agora-rest-api.herokuapp.com/api/v1/auth/login"),
        body: json.encode(data),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        print("Http returned 200: ${response.body}");
        tempData = json.decode(response.body);

        print("the Data is : ${tempData['email']}");
        return response.statusCode;
      } else {
        print("Http returned : ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Error in http posting: $e----------");
      return 0;
    }
  }

  Widget mainUI() {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          Map<String, String> data = {
            "identifier": "ykataria",
            "password": "123YOG123"
          };
          result = await getRequest();
          // MakeRequest request = MakeRequest(
          //     "http://agora-rest-api.herokuapp.com/api/v1/auth/login", data);
          // Map temp = await request.request();

          // Map temp2 = json.decode(temp['data']);
          // print("Final Data is as follows: ${temp2["token"]}");
        },
        elevation: 15.0,
        child: Container(
          width: 230.0,
          height: 45.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        splashColor: Colors.white30,
        highlightColor: Colors.black12,
        clipBehavior: Clip.antiAlias,
        // color: Color(0xFFFFCD00),
        color: Colors.yellow[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login test"),
          backgroundColor: Colors.yellow[700],
        ),
        body: mainUI());
  }
}
