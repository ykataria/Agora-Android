import 'package:flutter/material.dart';

class CreateElection extends StatefulWidget {
  @override
  _CreateElectionState createState() => _CreateElectionState();
}

class _CreateElectionState extends State<CreateElection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.priority_high,
                size: 40.0,
                color: Color(0xFF018752),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Work in progress",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFF018752)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
