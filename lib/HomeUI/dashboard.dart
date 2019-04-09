import 'package:flutter/material.dart';

import 'darshBoardUI.dart';
import 'createElection.dart';
import 'aboutApp.dart';
import 'package:agora/makeRequest.dart';
import 'package:agora/loginandsignup/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  final Map<String, dynamic> data;
  DashBoard({Key key, this.data}) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  double height, width;

  int ui = 0;
  String title = "Dashboard";

  String email = "jhon@gmail.com", name = "jhon";

  String token;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (mounted) {
      setState(() {
        email = widget.data['email'];
        name = widget.data['username'];
      });
    }
    super.initState();
  }

  Future<int> getRequest(String token) async {
    try {
      var response = await http.get(
          Uri.parse("http://agora-rest-api.herokuapp.com/api/v1/user/logout"),
          headers: {
            "X-Auth-Token": token
                
          });

      if (response.statusCode == 200) {
        print("Http returned 200 : ${response.body}");
        return response.statusCode;
      } else {
        
        print(
            "Http returned ${response.statusCode} and : ${response.body}");
        return response.statusCode;
      }
    } catch (e) {
      print("Error $e");
    }
  }

  logoutFunction() async {
    int status;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      print("token is : $token");


      status = await getRequest(token);
      
      if (status == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ), (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "Could not logout make sure you are connected to internet"),
            duration: Duration(
              seconds: 5,
            ),
            backgroundColor: Color(0xFF018752),
          ),
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ), (Route<dynamic> route) => false);
      }
    } catch (e) {
      print("error : $e");
      Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
              Text("Could not logout make sure you are connected to internet"),
          duration: Duration(
            seconds: 5,
          ),
          backgroundColor: Color(0xFF018752),
        ),
      );
    }
  }

  Widget drawerUI() {
    return Drawer(
      elevation: 15.0,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/drawer.png"),
              ),
            ),
            accountName: Text(
              name.substring(0, 1).toUpperCase() +
                      name.substring(1, name.length) ??
                  "",
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'm-medium'),
            ),
            accountEmail: Text(
              email ?? "",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'm-medium'),
            ),
            currentAccountPicture: Tooltip(
              message: "Test",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80.0,
                child: Text(
                  name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF018752)),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: Color(0xFF018752),
              size: 25.0,
            ),
            title: Text(
              'DashBoard',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {
                  ui = 0;
                  title = 'Dashboard';
                });
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              color: Color(0xFF018752),
              size: 25.0,
            ),
            title: Text(
              'Create Election',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {
                  ui = 1;
                  title = "Create Election";
                });
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Color(0xFF018752),
              size: 25.0,
            ),
            title: Text(
              'Help and FeedBack',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {
                  ui = 3;
                  title = "Help and FeedBack";
                });
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Color(0xFF018752),
              size: 25.0,
            ),
            title: Text(
              'About Agora',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {
                  ui = 4;
                  title = "About Agora";
                });
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Color(0xFF018752),
              size: 25.0,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              // getRequest();
              logoutFunction();
            },
          ),
        ],
      ),
    );
  }

  Widget mainUI() {
    switch (ui) {
      case 0:
        return DashBoardUI();
        break;
      case 1:
        return CreateElection();
        break;
      case 2:
        return CreateElection();
        break;
      case 3:
        return CreateElection();
        break;
      case 4:
        return AboutApp();
        break;
      default:
        return DashBoardUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: drawerUI(),
      body: mainUI(),
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.yellow[700],
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 15.0,
        tooltip: "Create Election",
        child: Icon(
          Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF018752),
        onPressed: () {
          setState(() {
            ui = 1;
            title = "Create Election";
          });
        },
      ),
    );
  }
}
