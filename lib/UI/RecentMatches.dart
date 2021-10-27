import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/UI/Notlivematch.dart';
import 'package:CricScore_App/UI/Livematches.dart';
import 'package:CricScore_App/UI/Recenttab.dart';
import 'package:CricScore_App/UI/recenttabscorecard.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Oneday.dart';
import 'TestMatches.dart';
import 'Upcomingmatches.dart';
class RecentMatches extends StatefulWidget {
  dynamic matches;
  RecentMatches({this.matches});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}
class _NestedTabBarState extends State<RecentMatches>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  bool isError = false;
  bool isLoading =false;
  var today=DateTime.now();
  var test=new List();
  var one=new List();
  var t20=new List();
  var upcoming =new List();
  var recent = new List();
  @override
  void initState() {
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

    double screenHeight = MediaQuery.of(context).size.height;
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
                Twenty(t20:t20,status:"recent"),

                Oneday(one:one,status: "recent",),
                TestMatches(test:test,status: "recent"),


              ],
            ),
          )
        ],
      ),
    );
  }
  // dynamic mathesfromserver=new List();
  // void getmatches() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for (int i = 0; i < widget.matches.length; i++) {
  //     if (widget.matches[i]['format'] == "t20") {
  //       t20.add(widget.matches[i]);
  //     }
  //     else if (widget.matches[i]['format'] == "test") {
  //       test.add(widget.matches[i]);
  //     }
  //     else {
  //       one.add(widget.matches[i]);
  //     }
  //   }
  // }

  dynamic mathesfromserver=new List();
  void getmatches() async {
    setState(() {
      isLoading=true;
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();

    try {
      final response = await get(Uri.parse(
          'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=3Me2w6gSy5GD9BKybwa8NPWQkT2PZ5fnfA5RLdYkPBraxSnVfSAnafoDikHu&include=runs,visitorteam,localteam,batting,bowling,league,stage&filter[status]=Finished&filter[starts_between]=${DateTime(today.year, today.month - 1, today.day).toString().substring(0,10)},${today.toString().substring(0,10)}&sort=starting_at'),
          headers: {
            // "rs-token":prefs.getString("token")

          });
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        //print("jhebild"+responseJson.length);
       setState(() {
         mathesfromserver=responseJson['data'];
        // print("jhebild"+mathesfromserver.length);
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
