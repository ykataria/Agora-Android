import 'package:flutter/material.dart';
import 'detailElection.dart';

class ElectionList extends StatefulWidget {
  final Color color;
  final String title, number;
  final IconData icon;

  const ElectionList({Key key, this.color, this.title, this.number, this.icon})
      : super(key: key);

  @override
  _ElectionListState createState() => _ElectionListState();
}

class _ElectionListState extends State<ElectionList> {
  Map dummyData = {
    "Active Elections": {
      0: {
        "name": "Best language 2019",
        "description": "Which programming language is best for 2019",
        "start": "4/2/2019, 2:54:33 AM",
        "end": "4/30/2019, 2:54:33 AM",
        "candidates": ["JavaScript", "Python", "C++", "Dart"],
        "active": "true"
      },
      1: {
        "name": "Cricket World Cup",
        "description": "Who will win cricket world cup",
        "start": "4/2/2019, 2:54:33 AM",
        "end": "4/30/2019, 2:54:33 AM",
        "candidates": ["Australia", "India", "England", "Windies"],
        "active": "true"
      }
    },
    "Pending Elections": {
      0: {
        "name": "Flutter vs React",
        "description": "Which mobile development tool is better?",
        "start": "4/20/2019, 12:00:00 AM",
        "end": "5/20/2019, 12:00:00 AM",
        "candidates": ["Flutter", "React"],
        "active": "false"
      },
      1: {
        "name": "Elections in India",
        "description": "Who will win elections in India 2019?",
        "start": "4/25/2019, 12:00:00 AM",
        "end": "5/25/2019, 12:00:00 AM",
        "candidates": ["Modi", "Rahul", "Other"],
        "active": "false"
      }
    },
    "Finished Elections": {
      0: {
        "name": "Angular vs React",
        "description": "Which is good frontend development tool?",
        "start": "3/20/2019, 12:00:00 AM",
        "end": "4/5/2019, 12:00:00 AM",
        "candidates": ["Angular", "React"],
        "Winner": "Angular",
        "finished": "true",
        "active": "false"
      }
    }
  };

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget detailUI(int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 20.0,
              ),
              child: Text(
                "Description :",
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 10.0),
          child: Text(
            dummyData[widget.title][count]["description"],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 20.0,
              ),
              child: Text(
                "Important :",
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 10.0),
          child: Text(
            "Start :  " + dummyData[widget.title][count]["start"],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 10.0),
          child: Text(
            "End   :  " + dummyData[widget.title][count]["end"],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              tooltip: "Edit election",
              icon: Icon(
                Icons.edit,
                color: widget.color,
                size: 30.0,
              ),
              onPressed: () {
                showMessage(
                    "Edit the election\nThis function is not yet implemented");
              },
            ),
            IconButton(
              tooltip: "Edit election",
              icon: Icon(
                Icons.visibility,
                color: widget.color,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailElection(
                    color: widget.color,
                    data: dummyData[widget.title][count],
                    icon: widget.icon,
                  );
                }));
              },
            ),
            IconButton(
              tooltip: "Delete election",
              icon: Icon(
                Icons.delete,
                color: widget.color,
                size: 30.0,
              ),
              onPressed: () {
                showMessage(
                    "Delete election\nThis function is under construction");
              },
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  void showMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: widget.color,
      duration: Duration(seconds: 5),
    ));
  }

  Widget election() {
    return ListView.builder(
      itemCount: dummyData[widget.title].keys.toList().length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, count) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 10.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ExpansionTile(
                  leading: Icon(
                    widget.icon,
                    size: 40.0,
                    color: widget.color,
                  ),
                  title: Text(
                    dummyData[widget.title][count]['name'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  children: <Widget>[detailUI(count)],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget allElections() {
    return Center(
      child: Text(
        'All Election List\nNot implemented yet\nCheck others Live, pending, finished elections',
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: widget.title == "All Elections" ? allElections() : election(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.color,
      ),
    );
  }
}
