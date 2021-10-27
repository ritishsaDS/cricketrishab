import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/UI/Livematchtab.dart';
import 'package:CricScore_App/UI/Notlivematch.dart';
import 'package:CricScore_App/UI/Livematches.dart';
import 'package:CricScore_App/UI/Recenttab.dart';
import 'package:CricScore_App/UI/recenttabscorecard.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Oneday.dart';
import 'RecentMatches.dart';
import 'TestMatches.dart';
import 'Upcomingmatches.dart';

class Locationstat extends StatefulWidget {
  @override
  _LocationstatState createState() => _LocationstatState();
}

class _LocationstatState extends State<Locationstat>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isError = false;
  bool isLoading = false;
  var upcoming =new List();
  var recent = new List();
  var live = new List();
  @override
  void initState() {

  ///  getmatches();
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text('All Matches'),
centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            //unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text:('Recent'),
              ),
              Tab(
                text:('Upcoming'),
              ),
              // Tab(
              //   text:('Live'),
              // ),

            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          RecentMatches(matches:recent),
          Upcoming(upcoming:upcoming),
        // Livematchtab(matches:live),


        ],
        controller: _tabController,
      ),
    );
  }

}




class Upcoming extends StatefulWidget {
  dynamic upcoming;
  Upcoming({this.upcoming});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}
class _NestedTabBarState extends State<Upcoming>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  bool isError = false;
  bool isLoading = false;
  var test = new List();
  var one = new List();
  var t20 = new List();
  var upcoming = new List();
  var recent = new List();

  @override
  void initState() {
    print("widget.upcoming");
    print(widget.upcoming);
    getmatches();
    super.initState();
    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
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
                text: "ODI",
              ),
              Tab(
                text: "TEST",
              ),

            ],
          ),
          Expanded(

            //  margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                Twenty(t20: t20,status:"upcoming"),

                Oneday(one: one,status:"upcoming"),
                TestMatches(test: test,status:"upcoming"),


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
      isLoading=true;
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();

    try {
      final response = await get(Uri.parse(
          'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=3Me2w6gSy5GD9BKybwa8NPWQkT2PZ5fnfA5RLdYkPBraxSnVfSAnafoDikHu&include=venue,runs,visitorteam,localteam,batting,bowling,league,season,stage&sort=starting_at&filter[status]=NS&filter[type]=T20'),
          headers: {
            // "rs-token":prefs.getString("token")

          });
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          mathesfromserver=responseJson['data'];
          for(int i =0; i<mathesfromserver.length;i++){
            if(mathesfromserver[i]['type']=="T20I"){
              t20.add(mathesfromserver[i]);
              setState(() {
                isLoading=false;
              });

            }
            else if(mathesfromserver[i]['type']=="ODI"){
              one.add(mathesfromserver[i]);
            }
          }
        });


        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        // for(int i=0;i<pastmatches.length;i++){
        //   searcharray.add( pastmatches[i]['name']);
        //   print(searcharray.toString());
        // }

      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }
}