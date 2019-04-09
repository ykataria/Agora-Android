import 'package:flutter/material.dart';
import 'vote.dart';

class DetailElection extends StatefulWidget {
  final Map data;
  final IconData icon;
  final Color color;
  const DetailElection({Key key, this.data, this.icon, this.color})
      : super(key: key);
  @override
  _DetailElectionState createState() => _DetailElectionState();
}

class _DetailElectionState extends State<DetailElection> {
  double width;
  double height;

  @override
  void initState() {
    print("In init : ${widget.data['active']}");
    super.initState();
  }

  Widget infoText(String title, String def) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 20.0),
            child: Text(
              def,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget linearInfoText(String title, String def) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 5.0),
                child: Text(
                  def,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detail() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.data['active'] == "true"
          ? FloatingActionButton.extended(
            elevation: 15.0,
              icon: Icon(
                Icons.assignment_ind,
                size: 25.0,
                color: Colors.white,
              ),
              label: Text(
                "Vote Now",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: widget.color,
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context){
                      return VoteNow(widget.data['candidates']);
                    }
                  )
                );
              },
            )
          : Container(),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Details",
                    style: TextStyle(
                        color: widget.color,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  child: Column(
                    children: <Widget>[
                      linearInfoText("Name :", widget.data['name']),
                      infoText("Description :", widget.data['description']),
                      linearInfoText("Voting Algo :", "Oklahoma"),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Dates",
                    style: TextStyle(
                        color: widget.color,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  child: Column(
                    children: <Widget>[
                      linearInfoText("Created :", widget.data['start']),
                      linearInfoText("Start :", widget.data['start']),
                      linearInfoText("End :", widget.data['end']),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Candidates",
                    style: TextStyle(
                        color: widget.color,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.data['candidates'].toList().length,
                    itemBuilder: (context, count) {
                      return linearInfoText("Candidate ${count + 1} : ",
                          widget.data['candidates'][count]);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }

  Widget voterContent({String name, String number, String email}) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.color,
            radius: 20.0,
            child: Text(
              number,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            email,
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget voters() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add voter",
        elevation: 15.0,
        child: Icon(
          Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
        onPressed: (){
          print("Add Voter");
        },
        backgroundColor: widget.color,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: voterContent(
                email: "James@gmail.com", name: "James01", number: "1"),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: voterContent(
                email: "Max@gmail.com", name: "Max", number: "2"),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: voterContent(
                email: "steve@gmail.com", name: "Steve", number: "3"),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: voterContent(
                email: "Ramesh@gmail.com", name: "Ramesh", number: "4"),
          )
        ],
      ),
    );
  }

  Widget result() {
    if (widget.data['finished'] == "true") {
      return Center(
        child: Text(
          "To be implemented!",
          style: TextStyle(color: widget.color, fontSize: 25.0),
        ),
      );
    } else {
      return Center(
        child: Text(
          "Result Not Yet Declared",
          style: TextStyle(color: widget.color, fontSize: 25.0),
        ),
      );
    }
  }

  Widget ui() {
    return TabBarView(
      children: <Widget>[
        detail(),
        voters(),
        Center(
          child: Text("Ballots"),
        ),
        result()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: ui(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 15.0,
          backgroundColor: widget.color,
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.data['name'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottom: TabBar(
            isScrollable: false,
            labelColor: Colors.white,
            indicatorColor: widget.color,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
                text: "Detail",
              ),
              Tab(
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                text: "Voters",
              ),
              Tab(
                icon: Icon(
                  Icons.work,
                  color: Colors.white,
                ),
                text: "Ballot",
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                text: "Results",
              )
            ],
          ),
        ),
      ),
    );
  }
}
