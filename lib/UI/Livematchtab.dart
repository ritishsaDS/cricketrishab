import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Oneday.dart';
import 'TestMatches.dart';
import 'Upcomingmatches.dart';

class Livematchtab extends StatefulWidget{
  dynamic matches;
  Livematchtab({this.matches});
  @override
  _LivematchtabState createState() => _LivematchtabState();
}

class _LivematchtabState extends State<Livematchtab>  with TickerProviderStateMixin {
  TabController _nestedTabController;
  @override
  void initState() {
    _nestedTabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }
  var test = new List();
  var one = new List();
  var t20 = new List();
  var upcoming = new List();
  var recent = new List();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    // TODO: implement build
  return Scaffold(
    backgroundColor: Colors.lightBlue,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,

          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "T20",
            ),
            Tab(
              text: "TEST",
            ),
            Tab(
              text: "ODI",
            ),

          ],
        ),
        Container(
          height: screenHeight * 0.68,
          //  margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Twenty(t20:t20),
              TestMatches(test:test),
              Oneday(one:one),


            ],
          ),
        )
      ],
    ),
  );
  }
  dynamic mathesfromserver=new List();
  void getmatches() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < widget.matches.length; i++) {
      if (widget.matches[i]['format'] == "t20") {
        t20.add(widget.matches[i]);
      }
      else if (widget.matches[i]['format'] == "test") {
        test.add(widget.matches[i]);
      }
      else {
        one.add(widget.matches[i]);
      }
    }
  }
}