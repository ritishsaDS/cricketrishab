import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/Oneday.dart';
import 'package:CricScore_App/Utils/Colors.dart';

import 'Livematches.dart';
import 'Recenttab.dart';
import 'Upcomingmatches.dart';

class Allmatches extends StatefulWidget{
  dynamic hometeamscore;
  dynamic hometeamrr;
  dynamic hometeamname;
  dynamic hometeamsimage;
  dynamic awayteamscore;
  dynamic awayteamrr;
  dynamic awayteamimage;
  dynamic awayteamname;
  dynamic event_status;
  dynamic event_status_info;
  dynamic league_name;
  dynamic league_key;
  Allmatches({this.event_status,this.event_status_info,this.league_key,this.league_name,this.awayteamimage,this.awayteamname,this.awayteamrr,this.awayteamscore,this.hometeamname,this.hometeamrr,this.hometeamscore,this.hometeamsimage});

  @override
  _AllmatchesState createState() => _AllmatchesState();
}

class _AllmatchesState extends State<Allmatches> {
  void initState() {
    //setUpTimedFetch();
    //getmatches();
   // getteams();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),

      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            elevation: 0,
            leading: Icon(Icons.arrow_back),
backgroundColor: Color(lightBlue),

            iconTheme: IconThemeData(color: Colors.white),
            bottom:  TabBar(
              tabs: [
                Tab(text: "Recent"),
                Tab(text: "Live"),
                Tab(text: "Upcoming"),
              ],
            ),

          ),
          body:  TabBarView(
            children: [
              Recenttab(),
              Livematch(),
              Oneday()
            ],
          ),
        ),
      ),
    );

  }
}