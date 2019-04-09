import 'package:flutter/material.dart';

import 'package:agora/HomeUI/electionList.dart';

class DashBoardUI extends StatefulWidget {
  @override
  _DashBoardUIState createState() => _DashBoardUIState();
}

class _DashBoardUIState extends State<DashBoardUI> {
  double width, height;

  Widget customCard(
      {Color color, IconData icon, String title, String number, var function}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return function;
            },
          ),
        );
      },
      child: Card(
        elevation: 15.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: color,
        child: Container(
          width: width * 0.9,
          height: 100.0,
          alignment: Alignment.center,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            leading: Icon(
              icon,
              size: 40.0,
              color: Colors.white,
            ),
            trailing: Text(
              number,
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget ui() {
    return SingleChildScrollView(
      primary: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * 0.04,
            ),
            customCard(
              color: Color(0xFFFE7A00),
              icon: Icons.view_list,
              number: "5",
              title: "All Elections",
              function: ElectionList(
                color: Color(0xFFFE7A00),
                number: "5",
                title: "All Elections",
                icon: Icons.view_list,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            customCard(
              color: Color(0xFFFF0000),
              icon: Icons.play_circle_outline,
              number: "2",
              title: "Active Elections",
              function: ElectionList(
                color: Color(0xFFFF0000),
                number: "2",
                title: "Active Elections",
                icon: Icons.play_circle_outline,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            customCard(
              color: Color(0xFF37B93C),
              icon: Icons.watch_later,
              number: "2",
              title: "Pending Elections",
              function: ElectionList(
                color: Color(0xFF37B93C),
                number: "2",
                title: "Pending Elections",
                icon: Icons.watch_later,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            customCard(
              color: Color(0xFF36B9D6),
              icon: Icons.check_circle_outline,
              number: "1",
              title: "Finished Elections",
              function: ElectionList(
                color: Color(0xFF36B9D6),
                number: "1",
                title: "Finished Elections",
                icon: Icons.check_circle_outline,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ui(),
    );
  }
}
