import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoteNow extends StatefulWidget {
  final List data;

  VoteNow(this.data);
  @override
  _VoteNowState createState() => _VoteNowState();
}

class _VoteNowState extends State<VoteNow> {
  List<String> selected = ['t', 't', 't', 't'];
  List<String> temp;

  initState() {
    temp = widget.data;
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget selectCandidate(int i) {
    return DropdownButton<String>(
      items: temp.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(
            value,
            style: TextStyle(fontSize: 20.0),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selected[i] = value;
        });
      },
      elevation: 20,
      style: TextStyle(
        color: Colors.blue,
      ),
      hint: Text("Select Candidate"),
      iconSize: 30.0,
      isExpanded: false,
      value: selected[i] == "t" ? null : selected[i],
    );
  }

  Widget content(String temp, int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$temp Preference : ",
            style: TextStyle(fontSize: 20.0),
          ),
          selectCandidate(i)
        ],
      ),
    );
  }

  Widget voteUI() {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Select candidates \nas per your preference",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          content("1st", 0),
          content("2nd", 1),
          content("3rd", 2),
          content("4th", 3),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 15.0,
        tooltip: "Confirm",
        child: Icon(Icons.check, size: 35.0, color: Colors.white,),
        backgroundColor: Color(0xFFFF0000),
        onPressed: () {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Voting Done thanks for taking part in voting process every vote count!"),
              duration: Duration(seconds: 7),
            )
          );
          Future.delayed(Duration(seconds: 7),(){
            if(mounted)
            {
              Navigator.pop(context);
            }
          });
        },
      ),
      body: SingleChildScrollView(
        primary: true,
        child: voteUI(),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFFF0000),
        title: Text(
          "Vote Now",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
