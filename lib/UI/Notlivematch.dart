import 'dart:convert';

import 'package:http/http.dart';
import 'package:CricScore_App/UI/Matchsquad.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Livematches.dart';
import 'Recenttab.dart';
import 'Upcomingmatches.dart';

class NotLivematch extends StatefulWidget {
  dynamic match;
  var status;
  dynamic deatil;
  var shortname;
  var matchnumber;
  NotLivematch({this.match,this.deatil,this.matchnumber,this.shortname, this.status});

  @override
  _NotLivematchState createState() => _NotLivematchState();
}

class _NotLivematchState extends State<NotLivematch> {
  int index = 0;
  bool live = true;
  bool commentary = false;
  bool isError = false;
  bool isLoading = false;
  var teama;
  var teamb;
  //final GlobalKey<ExpansionTile> expansionTile = new GlobalKey();

  bool scoreboard = false;
  var map;
  var squada = [];
  var squad = [];
  var squadb = [];
  int selected = 0; //attention

  @override
  void initState() {
    print(widget.key);

    print(widget.match['players']);
    getKeysFromMap();
    getfeaturedmatches();

    super.initState();
  }

  void getKeysFromMap() {
    print('----------');
    print('Get keys:');
    // Get all keys
    widget.match['players'].keys.forEach((key) {
      squad.add(key);
    });
    getlist();
  }

  void getlist() {
    print(squad);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (widget.status == 'not_started') {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            initialIndex: 2,
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("${mathesfromserver['short_name']}"),
                  centerTitle: true,
                  elevation: 0,
                  
                  leading: GestureDetector(onTap:(){
                    Navigator.pop(context);
                  },child: Icon(Icons.arrow_back)),
                  backgroundColor: Color(lightBlue),
                  iconTheme: IconThemeData(color: Colors.white),
                  bottom: TabBar(
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text("INFO",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("LIVE",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SCORECARD",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SQUADS",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                        child:isLoading?CircularProgressIndicator(
                          color: Colors.blue,
                        ): Column(children: [
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Text("SQUADS"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Matchsquad(
                                      firstteam: mathesfromserver['teams']['a']
                                          ["name"],
                                      secondteam: mathesfromserver['teams']['b']
                                          ["name"],
                                      firstsquad: squada,
                                      match: mathesfromserver,
                                      secondsquad: squadb)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: SizeConfig.screenWidth,
                          child: Text(mathesfromserver['teams']['a']["name"]),
                        ),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Matchsquad(
                                      firstteam: mathesfromserver['teams']['a']
                                      ["name"],
                                      secondteam: mathesfromserver['teams']['b']
                                      ["name"],
                                      firstsquad: squada,
                                      match: mathesfromserver,
                                      secondsquad: squadb)));
                        },
                        child: Container(
                          // color:Colors.grey,
                          padding: EdgeInsets.all(10),
                          width: SizeConfig.screenWidth,
                          child: Text(mathesfromserver['teams']['b']["name"]),
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Text("INFO"),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Match",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['sub_title'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Series",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(widget.shortname,
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Match Type",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['format'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toss",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              // Text("${mathesfromserver['toss']['winner']=='a'?teama:teamb } opted to ${mathesfromserver['toss']['elected']}",
                              //     style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Umpires",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text("Richard Kettlebrough",
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Refree",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text("Chris Broad",
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Venue",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['venue']['name'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                    ])),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/stop-watch.png",
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Match Not Started Yet",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/stop-watch.png",
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Match Not Started Yet",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,left:3,right:3),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Color(lightBlue),
                              borderRadius: BorderRadius.circular(15)),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Text(
                                mathesfromserver['teams']['a']["name"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              iconColor: Colors.blue,
                              collapsedIconColor: Colors.white,
                              children: squadwidget(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top:10,left:3,right:3),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Color(lightBlue),
                              borderRadius: BorderRadius.circular(15)),
                          child: ExpansionTile(
                              title: Text(
                                mathesfromserver['teams']['b']["name"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              children: squadwidgetb()),
                        )
                      ],
                    ),
                  ],
                ),
              )));
    }

    else if (widget.status == 'completed') {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
              initialIndex: 1,
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("${mathesfromserver['short_name']}"),
                  centerTitle: true,
                  elevation: 0,
                  leading: GestureDetector(onTap:(){
    Navigator.pop(context);
    },child:Icon(Icons.arrow_back)),
                  backgroundColor: Color(lightBlue),
                  iconTheme: IconThemeData(color: Colors.white),
                  bottom: TabBar(
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text("INFO",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("LIVE",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SCORECARD",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SQUADS",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                        child: Column(children: [
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Text("SQUADS"),
                      ),
                      GestureDetector(
onTap: (){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Matchsquad(
              firstteam: mathesfromserver['teams']['a']
              ["name"],
              secondteam: mathesfromserver['teams']['b']
              ["name"],
              firstsquad: squada,
              match: mathesfromserver,
              secondsquad: squadb)));
},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: SizeConfig.screenWidth,
                          child: Text(mathesfromserver['teams']['a']["name"]),
                        ),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Matchsquad(
                                      firstteam: mathesfromserver['teams']['a']
                                      ["name"],
                                      secondteam: mathesfromserver['teams']['b']
                                      ["name"],
                                      firstsquad: squada,
                                      match: mathesfromserver,
                                      secondsquad: squadb)));
                        },
                        child: Container(
                          // color:Colors.grey,
                          padding: EdgeInsets.all(10),
                          width: SizeConfig.screenWidth,
                          child: Text(mathesfromserver['teams']['b']["name"]),
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Text("INFO"),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Match",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['sub_title'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Series",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(widget.shortname,
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Match Type",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['format'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toss",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                  "${mathesfromserver['toss']['winner'] == 'a' ? teama : teamb} opted to ${mathesfromserver['toss']['elected']}",
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Umpires",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text("Richard Kettlebrough",
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Refree",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text("Chris Broad",
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: SizeConfig.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Venue",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(mathesfromserver['venue']['name'],
                                  style: TextStyle(color: Colors.black))
                            ]),
                      ),
                      Divider(
                          height: 5, thickness: 1.5, color: Colors.grey[200]),
                    ])),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              height: SizeConfig.screenHeight * 0.32,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(left:10.0,right:10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth*0.8,
                                            child:Text(widget.matchnumber,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                          )
                                        ],),
                                      Text(widget.deatil.toString()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(mathesfromserver['name']),
                                          // Container(
                                          //   width: 100,
                                          //   height: 25,
                                          //   child: ElevatedButton(onPressed: (){var i=0;
                                          //   i++;}, style: ButtonStyle(
                                          //       foregroundColor: MaterialStateProperty.all<Color>(Color(lightBlue)),
                                          //       backgroundColor: MaterialStateProperty.all<Color>(Color(lightBlue)),
                                          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          //           RoundedRectangleBorder(
                                          //               borderRadius: BorderRadius.circular(30),
                                          //               side: BorderSide(color: Colors.white)
                                          //           )
                                          //       )
                                          //
                                          //   ),child: Text("Live",style: TextStyle(color: Colors.white,fontSize: 14),),),
                                          // )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/bg/team1.png",
                                            scale: 5,
                                          ),
                                          Text(
                                            teama,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Text(
                                              mathesfromserver['play']
                                              ['innings']['a_1']
                                              ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                              ['innings']['a_1']
                                              ['score_str'].toString().split('in')[1].substring(1)+")",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                          //Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/bg/team2.png",
                                            scale: 5,
                                          ),
                                          Text(
                                            teamb,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Text(
                                              mathesfromserver['play']
                                              ['innings']['b_1']
                                              ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                              ['innings']['b_1']
                                              ['score_str'].toString().split('in')[1].substring(1)+")",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                          // Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(mathesfromserver['play']['result']
                                          ['msg'],style: TextStyle(color: Colors.red),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Player Of the Match: "),
                              Text(
                                mathesfromserver['players'][mathesfromserver['play']['result']['pom'][0]]['player']['legal_name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          // Container(
                          //   child: Text(
                          //     "Balls",
                          //     style: TextStyle(
                          //         fontSize: SizeConfig.blockSizeVertical * 1.50,
                          //         color: Colors.black),
                          //   ),
                          //   margin: EdgeInsets.only(
                          //       left: SizeConfig.screenWidth * 0.02,
                          //       top: SizeConfig.blockSizeVertical),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       left: SizeConfig.screenWidth * 0.02,
                          //       top: SizeConfig.blockSizeVertical),
                          //   width: SizeConfig.screenWidth * 0.4,
                          //   height: SizeConfig.blockSizeVertical * 3,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(25),
                          //       border: Border.all(
                          //         color: Color(lightBlue),
                          //       )),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenHeight*0.80,
                      child: ListView(

                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10,),
                            width: SizeConfig.screenWidth,
                            color: Color(lightBlue),
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                key: Key(index.toString()),
                                  initiallyExpanded : index==selected,
                                onExpansionChanged: ((newState){
                                  if(newState)
                                    setState(() {
                                      Duration(seconds:  20000);
                                      selected = index;
                                    });
                                  else
                                    setState(() {
                                    selected = -1;
                                  });
                                }),
                                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['teams']['a']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                          mathesfromserver['play']
                                          ['innings']['a_1']
                                          ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                          ['innings']['a_1']
                                          ['score_str'].toString().split('in')[1].substring(1)+")",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children: [
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(

                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Batting"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("B"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("4s"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("6s"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.1,
                                                  child: Text("S/R"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        child: Column(
                                          children:  battingorder()

                                                )),
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Bowling"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("O"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("W"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("M"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("Eco."),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                            Container(

                                                child: Column(

                                                  children: bowlingsecondorderlist(),
                                                ))

                                          ],
                                        )),


                            ),

                          Container(
                            margin: EdgeInsets.only(top:10,),
                            color: Color(lightBlue),
                            width: SizeConfig.screenWidth,
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: index==selected,
                                  onExpansionChanged: ((newState){
                                    if(newState)
                                      setState(() {
                                        selected=1;
                                        Duration(seconds:  20000);
                                        selected = index;
                                      });
                                    else
                                      setState(() {
                                        selected = -1;
                                      });
                                  }),
                                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['teams']['b']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                          mathesfromserver['play']
                                          ['innings']['b_1']
                                          ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                          ['innings']['b_1']
                                          ['score_str'].toString().split('in')[1].substring(1)+")",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  backgroundColor: Color(lightBlue),
                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Batting"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("B"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("4s"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.05,
                                                  child: Text("6s"),
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.1,
                                                  child: Text("S/R"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        child: Column(
                                          children: batting2ndorder(),
                                        )),
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Bowling"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("O"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("W"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("M"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("Eco."),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Column(
                                          children: bowlingorderlist(),
                                        ))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(

                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Color(lightBlue),
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Text(
                                mathesfromserver['teams']['a']["name"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              iconColor: Colors.blue,
                              collapsedIconColor: Colors.white,
                              children: squadwidget(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                         // margin: EdgeInsets.only(top:10,right: 3,left:3),                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Color(lightBlue),
                           ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                title: Text(
                                  mathesfromserver['teams']['b']["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Color(lightBlue),
                                iconColor: Colors.white,
                                collapsedIconColor: Colors.white,
                                children: squadwidgetb()),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )));
    }

  }

  List<Widget> squadwidget() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < squada.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              mathesfromserver['players'][squada[i]]['player']
                                  ['legal_name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][squada[i]]['player']
                                          ['nationality'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][squada[i]]
                                      ['player']['nationality']['name'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List<Widget> battingorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < battingorderfirst.length; i++) {
      squadlist.add(
          Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal*39,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mathesfromserver['players']
                                          [battingorderfirst[i]]['player']
                                      ['legal_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  mathesfromserver['players']
                                                      [battingorderfirst[i]]
                                                  ['score']['1']['batting']
                                              ['dismissal'] ==
                                          null
                                      ? "Not Out"
                                      : mathesfromserver['players']
                                                      [battingorderfirst[i]]
                                                  ['score']['1']['batting']
                                              ['dismissal']["msg"]
                                          .toString(),
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingorderfirst[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : "${mathesfromserver['players'][battingorderfirst[i]]
                              ['score']['1']['batting']['score']
                              ["runs"]}"
                                     ,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingorderfirst[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingorderfirst[i]]
                                              ['score']['1']['batting']['score']
                                          ["balls"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingorderfirst[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingorderfirst[i]]
                                              ['score']['1']['batting']['score']
                                          ["fours"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingorderfirst[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingorderfirst[i]]
                                              ['score']['1']['batting']['score']
                                          ["sixes"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingorderfirst[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingorderfirst[i]]
                                              ['score']['1']['batting']['score']
                                          ["strike_rate"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                 ),
                child: Divider(
                  color: Color(lightBlue),
                ),
             ),
            ],
          ),
        ),
      )
      );
    }
    return squadlist;
  }

  List<Widget> batting2ndorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < battingordersecond.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                      width: SizeConfig.blockSizeHorizontal*39,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mathesfromserver['players']
                                          [battingordersecond[i]]['player']
                                      ['legal_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  mathesfromserver['players']
                                                      [battingordersecond[i]]
                                                  ['score']['1']['batting']
                                              ['dismissal'] ==
                                          null
                                      ? "Not Out"
                                      : mathesfromserver['players']
                                                      [battingordersecond[i]]
                                                  ['score']['1']['batting']
                                              ['dismissal']["msg"]
                                          .toString(),
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingordersecond[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingordersecond[i]]
                                              ['score']['1']['batting']['score']
                                          ["runs"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingordersecond[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingordersecond[i]]
                                              ['score']['1']['batting']['score']
                                          ["balls"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingordersecond[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingordersecond[i]]
                                              ['score']['1']['batting']['score']
                                          ["fours"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingordersecond[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingordersecond[i]]
                                              ['score']['1']['batting']['score']
                                          ["sixes"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][battingordersecond[i]]
                                          ['score']['1'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][battingordersecond[i]]
                                              ['score']['1']['batting']['score']
                                          ["strike_rate"]
                                      .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }
  List<Widget> bowlingorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingorder.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal*37,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mathesfromserver['players']
                                  [bowlingorder[i]]['player']
                                  ['legal_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling'] ==
                                  null
                                  ? "Not Yet"
                                  : "${mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["overs"][0].toString()+"."+mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["overs"][1].toString()}"
                              ,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["runs"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingorder[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'] [bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["wickets"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingorder[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["maiden_overs"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                           width: SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingorder[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingorder[i]]
                              ['score']['1']['bowling']['score']
                              ["economy"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List<Widget> bowlingsecondorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingordersecond.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal*37,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mathesfromserver['players']
                                  [bowlingordersecond[i]]['player']
                                  ['legal_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling']['score']
                              ['overs'][0].toString()
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling']['score']
                              ["runs"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling']['score']
                              ["wickets"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling']['score']
                              ["maiden_overs"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1'] ==
                                  null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][bowlingordersecond[i]]
                              ['score']['1']['bowling']['score']
                              ["economy"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List<Widget> squadwidgetb() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < squadb.length; i++) {
      squadlist.add(
          Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              mathesfromserver['players'][squadb[i]]['player']
                                  ['legal_name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              mathesfromserver['players'][squadb[i]]['player']
                                          ['nationality'] ==
                                      null
                                  ? "Not Yet"
                                  : mathesfromserver['players'][squadb[i]]
                                      ['player']['nationality']['name'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  dynamic mathesfromserver = new List();
  dynamic battingorderfirst = new List();
  dynamic battingordersecond = new List();
  dynamic bowlingorder = new List();
  dynamic bowlingordersecond = new List();
  void getfeaturedmatches() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await get(
          Uri.parse(
              'https://api.sports.roanuz.com/v5/cricket/RS_P_1415363533180375074/match/${widget.match['key']}/'),
          headers: {"rs-token": prefs.getString("token")});
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        setState(() {
          isLoading=false;
          mathesfromserver = responseJson['data'];

          teama = mathesfromserver['teams']['a']["code"];
          teamb = mathesfromserver['teams']['b']["code"];
          if (widget.status == "completed") {

            squada = mathesfromserver['squad']['a']['playing_xi'];
            battingorderfirst =
            mathesfromserver['play']['innings']['a_1']['batting_order'];
            battingordersecond =
            mathesfromserver['play']['innings']['b_1']['batting_order'];
            bowlingordersecond=   mathesfromserver['play']['innings']['b_1']['bowling_order'];
            bowlingorder=   mathesfromserver['play']['innings']['a_1']['bowling_order'];
            print("jnjov" + battingorderfirst.toString());
            squadb = mathesfromserver['squad']['b']['playing_xi'];
          } else {
            squada = mathesfromserver['squad']['a']['player_keys'];
            print("jnjov" + squada.toString());
            squadb = mathesfromserver['squad']['b']['player_keys'];
          }
          if(widget.status=="completed"){
            print("jknjino");
            sendMatchdatatoServer();
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

  Future<void> sendMatchdatatoServer() async {
    print("jknjinosss"+mathesfromserver['key']);
var data={

    "match_key":mathesfromserver['key'],
    "team_a":teama,
    "team_b":teamb,
    "teama_score":mathesfromserver['play']
    ['innings']['a_1']
    ['score_str'],
    "teamb_score":mathesfromserver['play']
    ['innings']['b_1']
    ['score_str'],
    "tournament_name":mathesfromserver['sub_title'],
    "match_date":widget.deatil.toString(),
    "result":mathesfromserver['play']['result']
    ['msg'],
    "status":"1"

};
      try {
        final response = await post(
            Uri.parse(
                'http://18.216.40.7/api/recentmatches'),
          body: {
            "match_key":mathesfromserver['key'],
            "team_a":teama,
            "team_b":teamb,
            "teama_score":mathesfromserver['play']
            ['innings']['a_1']
            ['score_str'],
            "teamb_score":mathesfromserver['play']
            ['innings']['b_1']
            ['score_str'],
            "tournament_name":mathesfromserver['sub_title'],
            "match_date":widget.deatil.toString(),
            "result":mathesfromserver['play']['result']
            ['msg'],
            "status":"1"
          },
           );
        print("bjkb" + response.body.toString());
        print("bjkb" + response.statusCode.toString());
        print("bjkb" + data.toString());
    }
    catch(e){
        print(e.toString());
        print(json.encode(data));
    }
  }
}
