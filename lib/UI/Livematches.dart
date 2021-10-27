import 'dart:async';
import 'dart:convert';

import 'package:flutter_html/flutter_html.dart';
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

class Livematch extends StatefulWidget {
  dynamic match;
  var status;
  dynamic deatil;
  var matchnumber;
  var shortname;
  Livematch(
      {this.match,this.status,this.deatil,this.shortname,this.matchnumber});

  @override
  _NotLivematchState createState() => _NotLivematchState();
}

class _NotLivematchState extends State<Livematch> {
  int index = 0;
  bool live = true;
  bool commentary = false;
  bool  isError = false;
  bool isLoading = false;
  var teama;
  var teamb;
  bool scoreboard = false;
  var map;
  var squada=[];
  var squad=[];
  var squadb=[];
  @override
  void initState() {



    setUpTimedFetch();
    getKeysFromMap();
    super.initState();
  }
  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 3000), (timer) {
      getfeaturedmatches();
      // print("jnern"+timer.toString());
    });
  }
  void getKeysFromMap(  ) {
    print('----------');
    print('Get keys:');
    // Get all keys
    widget.match['players'].keys.forEach((key) {

      squad.add(key);

    });
    getlist();
  }
  void getlist(){
    print(squad);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text("Squads"),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['teams']['a']["name"]),
                            ),
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
                            Container(
                              // color:Colors.grey,
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['teams']['b']["name"]),
                            ),
                            Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text("Info"),
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
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                                    Text(mathesfromserver['short_name'],
                                        style: TextStyle(color: Colors.black))
                                  ]),
                            ),
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                                    Text(mathesfromserver['format'], style: TextStyle(color: Colors.black))
                                  ]),
                            ),
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                                    Text("${mathesfromserver['toss']['winner']=='a'?teama:teamb } opted to ${mathesfromserver['toss']['elected']}",
                                        style: TextStyle(color: Colors.black))
                                  ]),
                            ),
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
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
                            Divider(height: 5, thickness: 1.5, color: Colors.grey[200]),
                          ]),
                        )),
                   SingleChildScrollView(child:  Container(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         GestureDetector(
                           onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                           },
                           child: Container(
                             margin:EdgeInsets.all(10.0),

                             height: SizeConfig.screenHeight*0.32,
                             child: Card(
                               elevation: 3,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.only(
                                     bottomRight: Radius.circular(10),
                                     bottomLeft: Radius.circular(10),
                                     topLeft: Radius.circular(10),
                                     topRight: Radius.circular(10)),),
                               child: Container(
                                 padding:EdgeInsets.all(5.0),
                                 child: Column(children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Container(
                                         width: SizeConfig.screenWidth*0.8,
                                         child: Text(widget.matchnumber,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                       )
                                     ],),
                                   Text(widget.deatil.toString()),
                                   Row(mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text( "Live",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),
                                       SizedBox(width: 10,),
                                      mathesfromserver['format']=="test"? Text("(Day - "+mathesfromserver['play']['day_number'].toString()+")",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),):Container(),
                                     ],
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Image.asset("assets/bg/team1.png",scale: 5,),
                                       Text(teama,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                       Expanded(child: SizedBox()),

                                       Text( mathesfromserver['play']
    ['innings']['a_1']
    ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
    ['innings']['a_1']
    ['score_str'].toString().split('in')[1].substring(1)+")",
    style: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold)),
                                       //Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                     ],
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Image.asset("assets/bg/team2.png",scale: 5,),
                                       Text(teamb,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                       Expanded(child: SizedBox()),
                                       Text(mathesfromserver['play']
    ['innings']['b_1']
    ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
    ['innings']['b_1']
    ['score_str'].toString().split('in')[1].substring(1)+")",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                                       // Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                     ],
                                   )
                                   ,
                                   SizedBox(height: 5,),
                                   //Text(mathesfromserver['play']['live']['batting_team']=="b"?"${mathesfromserver['toss']['winner']=='a'?teama:teamb } opted to ${mathesfromserver['toss']['elected']}":teama+mathesfromserver['play']['live']['required_score']['title'],style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),)
                                 ],),
                               ),
                             ),),
                         ),


                         Divider(
                           thickness: 1.5,
                         ),
                         Container(

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 width:SizeConfig.blockSizeHorizontal*20,
                                 child: Text(
                                   "Batter",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),
                               Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   "R",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),Container(
                                   width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   "B",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),Container(
                                   width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   "4s",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   "6s",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   "SR",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.w600),
                                 ),
                               ),
                             ],
                           ),
                           margin: EdgeInsets.only(
                               left: SizeConfig.screenWidth * 0.02,
                               right: 10,
                               top: SizeConfig.blockSizeVertical),
                         ),
                         Divider(
                           thickness: 1.5,
                         ),
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 width:SizeConfig.blockSizeHorizontal*20,
                                 child: Text(
                                   striker==null?"" :mathesfromserver['players'][striker]['player']['name']+"*",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),
                               
                               Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   striker==null?"" : mathesfromserver['players'][striker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][striker]['score']['1']['batting']['score']["runs"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                   width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   striker==null?"" : mathesfromserver['players'][striker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][striker]['score']['1']['batting']['score']["balls"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   striker==null?"" :  mathesfromserver['players'][striker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][striker]['score']['1']['batting']['score']["fours"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                   width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   striker==null?"" :  mathesfromserver['players'][striker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][striker]['score']['1']['batting']['score']["sixes"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(

                                 child: Text(

                                   striker==null?"" : mathesfromserver['players'][striker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][striker]['score']['1']['batting']['score']["strike_rate"].toString(),
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.50,
                                       color: Colors.black),
                                 ),
                               ),
                             ],
                           ),
                           margin: EdgeInsets.only(
                               left: SizeConfig.screenWidth * 0.02,
                               right: 5,
                               top: SizeConfig.blockSizeVertical),
                         ),
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 width:SizeConfig.blockSizeHorizontal*20,
                                 child: Text(
                                   nonstriker==null?"":  mathesfromserver['players'][nonstriker]['player']['name'],
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),
                               Container(
                                   width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   nonstriker==null?"":  mathesfromserver['players'][nonstriker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][nonstriker]['score']['1']['batting']['score']["runs"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   nonstriker==null?"":    mathesfromserver['players'][nonstriker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][nonstriker]['score']['1']['batting']['score']["balls"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   nonstriker==null?"":   mathesfromserver['players'][nonstriker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][nonstriker]['score']['1']['batting']['score']["fours"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Container(
                                 width:
                                 SizeConfig.screenWidth *
                                     0.05,
                                 child: Text(
                                   nonstriker==null?"":   mathesfromserver['players'][nonstriker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][nonstriker]['score']['1']['batting']['score']["sixes"].toString(),

                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),Text(
                                 nonstriker==null?"":  mathesfromserver['players'][nonstriker]['score']['1']['batting']==null?"Not Yet":mathesfromserver['players'][nonstriker]['score']['1']['batting']['score']["strike_rate"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.50,
                                     color: Colors.black),
                               ),
                             ],
                           ),
                           margin: EdgeInsets.only(
                               left: SizeConfig.screenWidth * 0.02,
                               right:  5,
                               top: SizeConfig.blockSizeVertical),
                         ),
                         Divider(
                           thickness: 1.5,
                         ),
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 width:SizeConfig.blockSizeHorizontal*20,
                                 child: Text(
                                   "Bowler",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black,fontWeight: FontWeight.bold),
                                 ),
                               ),
                               Text(
                                 "O",
                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black,fontWeight: FontWeight.bold),
                               ),Text(
                                 "R",
                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black,fontWeight: FontWeight.bold),
                               ),Text(
                                 "W",
                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black,fontWeight: FontWeight.bold),
                               ),Text(
                                 "M",
                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black,fontWeight: FontWeight.bold),
                               ),Text(
                                 "Eco",
                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black,fontWeight: FontWeight.bold),
                               ),
                             ],
                           ),
                           margin: EdgeInsets.only(
                               left: SizeConfig.screenWidth * 0.02,
                               right: 5,
                               top: SizeConfig.blockSizeVertical),
                         ),
                         Divider(
                           thickness: 1.5,
                         ),
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 width:SizeConfig.blockSizeHorizontal*20,
                                 child: Text(
                                   currentbowler==null?"" :mathesfromserver['players'][currentbowler]['player']['name']+"*",
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical * 1.80,
                                       color: Colors.black),
                                 ),
                               ),
                               Text(
                                 currentbowler==null?"" : mathesfromserver['players'][currentbowler]['score']['1']['bowling']==null?"Not Yet":mathesfromserver['players'][currentbowler]['score']['1']['bowling']['score']["runs"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black),
                               ),Text(
                                 currentbowler==null?"" : mathesfromserver['players'][currentbowler]['score']['1']['bowling']==null?"Not Yet":mathesfromserver['players'][currentbowler]['score']['1']['bowling']['score']["balls"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black),
                               ),Text(
                                 currentbowler==null?"" :  mathesfromserver['players'][currentbowler]['score']['1']['bowling']==null?"Not Yet":mathesfromserver['players'][currentbowler]['score']['1']['bowling']['score']["wickets"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black),
                               ),Text(
                                 currentbowler==null?"" :  mathesfromserver['players'][currentbowler]['score']['1']['bowling']==null?"Not Yet":mathesfromserver['players'][currentbowler]['score']['1']['bowling']['score']["wickets"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black),
                               ),Text(
                                 currentbowler==null?"" : mathesfromserver['players'][currentbowler]['score']['1']['bowling']==null?"Not Yet":mathesfromserver['players'][currentbowler]['score']['1']['bowling']['score']["economy"].toString(),

                                 style: TextStyle(
                                     fontSize: SizeConfig.blockSizeVertical * 1.80,
                                     color: Colors.black),
                               ),
                             ],
                           ),
                           margin: EdgeInsets.only(
                               left: SizeConfig.screenWidth * 0.02,
                               right:5,
                               top: SizeConfig.blockSizeVertical),
                         ),
                         // Container(
                         //   height: SizeConfig.screenHeight*0.35,
                         //   child: ListView(
                         //     children: relatedballslist(),
                         //   ),
                         // )

                         Divider(
                           thickness: 1.5,
                         )
                       ],
                     ),
                   ),),
                    Container(
                      height: SizeConfig.screenHeight*0.80,
                      child: ListView(

                        children: [

                          Container(
                            margin: EdgeInsets.only(top:10),
                            width: SizeConfig.screenWidth,
                            color: Color(lightBlue),
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child:battingorderfirst.length==0?Container(): ExpansionTile(
                                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['teams']['a']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text( mathesfromserver['play']
                                      ['innings']['a_1']
                                      ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                      ['innings']['a_1']
                                      ['score_str'].toString().split('in')[1].substring(1)+")",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),

                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children:[
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth * 0.02),
                                            child: Text("Batting"),
                                          ),
                                          Container(

                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth * 0.02),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.05,
                                                  child: Text("B"),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.05,
                                                  child: Text("4s"),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.05,
                                                  child: Text("6s"),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.1,
                                                  child: Text("S/R"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: SizeConfig.screenHeight*0.62,
                                        child: ListView(children:  battingorder(),)),
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
                                  ]
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top:10),
                            width: SizeConfig.screenWidth,
                            color: Color(lightBlue),
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child:battingordersecond.length==0?Container():
                              ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['teams']['b']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text( mathesfromserver['play']
                                      ['innings']['b_1']
                                      ['score_str'].toString().split('in')[0]+"("+ mathesfromserver['play']
                                      ['innings']['b_1']
                                      ['score_str'].toString().split('in')[1].substring(1)+")",
                                          style: TextStyle(
                                              color: Colors.white,

                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  //backgroundColor: Color(lightBlue),
                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children:
                                  [
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
                                            children:  batting2ndorder()

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

                                  ]

                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              color: Color(lightBlue),
                             ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
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

                          width: SizeConfig.screenWidth,
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
                                children:
                                squadwidgetb()

                            ),
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              )));


  }
  List<Widget>squadwidget(){
    List<Widget>squadlist=new List();
    for(int i = 0; i<squada.length;i++){
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth *
                            0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(

                          child: Text(
                            mathesfromserver['players'][squada[i]]['player']['legal_name'],
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][squada[i]]['player']['nationality']==null?"Not Yet":mathesfromserver['players'][squada[i]]['player']['nationality']['name'],
                            style: TextStyle(
                                fontSize: 12
                            ),
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
                  horizontal:
                  SizeConfig.screenWidth * 0.02,
                  vertical:
                  SizeConfig.blockSizeVertical),
              child: Divider(
                color: Color(lightBlue),
              ),
            ),
          ],),
        ),));
    }
    return squadlist;
  }
  List<Widget>battingorder(){
    List<Widget>squadlist=new List();
    for(int i = 0; i<battingorderfirst.length;i++){
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth *
                            0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(
                          width:SizeConfig.blockSizeHorizontal*37,
                          child: Column(
                            children: [
                              Text(
                                mathesfromserver['players'][battingorderfirst[i]]['player']['legal_name'],
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              Text(
                                mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['dismissal']==null?"Not Out":   mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['dismissal']["msg"].toString(),
                                style:TextStyle(color:Colors.red)
                              )
                            ],
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingorderfirst[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['score']["runs"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),

                        Container(

                          child: Text(
                            mathesfromserver['players'][battingorderfirst[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['score']["balls"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingorderfirst[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['score']["fours"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingorderfirst[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['score']["sixes"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingorderfirst[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingorderfirst[i]]['score']['1']['batting']['score']["strike_rate"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
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
                  horizontal:
                  SizeConfig.screenWidth * 0.02,
                  vertical:
                  SizeConfig.blockSizeVertical),
              child: Divider(
                color: Color(lightBlue),
              ),
            ),
          ],),
        ),));
    }
    return squadlist;
  }
  List<Widget>batting2ndorder(){
    List<Widget>squadlist=new List();
    for(int i = 0; i<battingordersecond.length;i++){
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: SizeConfig.screenWidth,

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth *
                            0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(
                          width:150,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text(
                                mathesfromserver['players'][battingordersecond[i]]['player']['legal_name'],
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              Text(
                                mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['dismissal']==null?"Not Out":   mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['dismissal']["msg"].toString(),style:TextStyle(color:Colors.red,fontSize:12)
                              )
                            ],
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingordersecond[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['score']["runs"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),

                        Container(

                          child: Text(
                            mathesfromserver['players'][battingordersecond[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['score']["balls"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingordersecond[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['score']["fours"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingordersecond[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['score']["sixes"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][battingordersecond[i]]['score']['1']==null?"Not Yet":mathesfromserver['players'][battingordersecond[i]]['score']['1']['batting']['score']["strike_rate"].toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 10,
              color: Colors.grey[300],
            )
          ],),
        ),));
    }
    return squadlist;
  }


  List<Widget>squadwidgetb(){
    List<Widget>squadlist=new List();
    for(int i = 0; i<squadb.length;i++){
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth *
                            0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(

                          child: Text(
                            mathesfromserver['players'][squadb[i]]['player']['legal_name'],
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                        Container(

                          child: Text(
                            mathesfromserver['players'][squadb[i]]['player']['nationality']==null?"Not Yet": mathesfromserver['players'][squadb[i]]['player']['nationality']['name'],
                            style: TextStyle(
                                fontSize: 12
                            ),
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
                  horizontal:
                  SizeConfig.screenWidth * 0.02,
                  vertical:
                  SizeConfig.blockSizeVertical),
              child: Divider(
                color: Color(lightBlue),
              ),
            ),
          ],),
        ),));
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
                            width: SizeConfig.blockSizeHorizontal*40,
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
                                0.06,
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
                              style: TextStyle(fontSize: 10),
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
                                  .toString().substring(0,3),
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
                    horizontal: SizeConfig.screenWidth * 0.01,
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

  dynamic mathesfromserver = new List();
  dynamic battingorderfirst = new List();
  dynamic battingordersecond = new List();
  dynamic bowlingordersecond = new List();
  dynamic bowlingorder = new List();
  dynamic relatedballs = new List();
  dynamic striker = new List();
  dynamic nonstriker = new List();
  dynamic currentbowler = new List();
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

       setState(() {
         final responseJson = json.decode(response.body);
         mathesfromserver = responseJson['data'];
         teama=mathesfromserver['teams']['a']["code"];
         teamb=mathesfromserver['teams']['b']["code"];
         battingorderfirst=mathesfromserver['play']['innings']['a_1']['batting_order'];
         battingordersecond=mathesfromserver['play']['innings']['b_1']['batting_order'];
         print("knmvjkod");
         relatedballs=mathesfromserver['play']['live']['recent_overs'];
         print("knmvjkod"+relatedballs[0].toString());
         striker=mathesfromserver['play']['live']['striker_key'];
         nonstriker=mathesfromserver['play']['live']['non_striker_key'];
currentbowler=mathesfromserver['play']['live']['bowler_key'];
         bowlingordersecond=   mathesfromserver['play']['innings']['b_1']['bowling_order'];
         bowlingorder=   mathesfromserver['play']['innings']['a_1']['bowling_order'];
         print("battingordersecond"+bowlingorder.toString());
         if(widget.status=="completed"){
           squada=mathesfromserver['squad']['a']['playing_xi'];


           squadb=mathesfromserver['squad']['b']['playing_xi'];
         }
         else{
           squada=mathesfromserver['squad']['a']['player_keys'];
           print("jnjov"+bowlingordersecond.toString());
           squadb=mathesfromserver['squad']['b']['player_keys'];
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
//   List <Widget> relatedballslist(){
//     List<Widget> relatedlist=new List();
//     for(int i =0; i<mathesfromserver['play']['live']['recent_overs'].length;i++){
//       for(int j =0; j<mathesfromserver['play']['live']['recent_overs'][i]['ball_keys'].length;j++){
//         print("blalkeysnu"+mathesfromserver['play']['live']['recent_overs'][i]['ball_keys'][j]);
//         print(mathesfromserver['play']['related_balls'][mathesfromserver['play']['live']['recent_overs'][i]['ball_keys'][j]]['comment']);
//       relatedlist.add(Container(
// margin: EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 Text((mathesfromserver['play']['live']['recent_overs'][i]["overnumber"]).toString()+"."+j.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
// SizedBox(height: 5,),
//                 CircleAvatar(
//   backgroundColor: Colors.red,
//   radius: 15,
//   child: Center(child: Text(mathesfromserver['play']['related_balls'][mathesfromserver['play']['live']['recent_overs'][i]['ball_keys'][j]]['comment'].toString().split(":")[1].substring(0,2),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
//     )
//               ],
//             ),
//            SizedBox(width: 15,),
//             Container(
//                 width: SizeConfig.screenWidth-70,
//                 child: Html(data:mathesfromserver['play']['related_balls'][mathesfromserver['play']['live']['recent_overs'][i]['ball_keys'][j]]['comment'])),
//           ],
//         ),
//       ));
//       }
//     }
//     return relatedlist;
//   }
}
