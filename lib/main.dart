import 'package:flutter/material.dart';
import './splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        cursorColor: Color(0xFF018752),
        indicatorColor: Color(0xFF018752),
        primaryColor: Colors.yellow[700]
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
