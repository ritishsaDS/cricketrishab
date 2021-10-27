import 'dart:async';
import 'dart:convert';

import 'package:CricScore_App/UI/recenttabscorecard.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Dashboard.dart';
import 'Matchsquad.dart';

class LiveMatchdetail extends StatefulWidget {
  dynamic id;
  LiveMatchdetail({this.id});
  @override
  _LiveMatchdetailState createState() => _LiveMatchdetailState();
}

class _LiveMatchdetailState extends State<LiveMatchdetail> {
  int index = 0;
  int iii = 0;
  bool live = true;
  bool commentary = false;
  bool scoreboard = false;
  bool isLoading = false;
  bool isError = false;
  var url;
  @override
  void initState() {
     url= 'https://cricket.sportmonks.com/api/v2.0/livescores/${widget.id}?api_token=${matchkey}&include=runs,visitorteam,localteam,batting,bowling,tosswon,league,stage,lineup,firstUmpire,balls,venue,,balls.batsmanone,balls.batsmantwo';

    // getlivescore();
    getoutdate();
    getlivescore();
   // getlivescore();
    setUpTimedFetch();
   // getSquad();
   // getmatches();
    // getlivescore();


    super.initState();
  }

  setUpTimedFetch() {
   // getlivescore();
    Timer.periodic(Duration(seconds: 5), (timer) {
      getlivescore();
      // print("jnern"+timer.toString());
    });
  }

  var firstbatsmen;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     physics: BouncingScrollPhysics(),
    //     child: Stack(
    //       children: [
    //         Container(
    //           child: isLoading == true
    //               ? Container(
    //                   child: Center(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 )
    //               : Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       width: SizeConfig.screenWidth,
    //                       height: SizeConfig.screenHeight * 0.25,
    //                       decoration: BoxDecoration(
    //                           gradient: LinearGradient(
    //                             colors: [
    //                               Color(gradientColor1),
    //                               Color(gradientColor2).withOpacity(0.95),
    //                             ],
    //                             begin: Alignment(1.0, -3.0),
    //                             end: Alignment.bottomRight,
    //                           ),
    //                           borderRadius: BorderRadius.circular(20)),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Container(
    //                             decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.only(
    //                                     bottomLeft: Radius.circular(150),
    //                                     bottomRight: Radius.circular(150))),
    //                             width: SizeConfig.screenWidth * 0.25,
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                             alignment: Alignment.center,
    //                             child: Text(
    //                               "LIVE",
    //                               style: TextStyle(
    //                                   color: Color(0XFFDD2727),
    //                                   fontWeight: FontWeight.w600),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 20,
    //                           ),
    //                           Container(
    //                             width: SizeConfig.screenWidth,
    //                             margin: EdgeInsets.only(
    //                                 top: SizeConfig.blockSizeVertical * 1.5),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Container(
    //                                       // width: 70,
    //                                       // height: 80,
    //                                       // decoration: new BoxDecoration(
    //                                       //     shape: BoxShape.circle,
    //                                       //     image: new DecorationImage(
    //                                       //         fit: BoxFit.fill,
    //                                       //         image: new NetworkImage(pastmatches[i]["team_b_img"]==null?"www.google.png":pastmatches[i]["team_b_img"]
    //                                       //
    //                                       //         ))),
    //                                       child: CircleAvatar(
    //                                         radius: 35.0,
    //                                         backgroundImage: NetworkImage(
    //                                             scorefromserver["localteam"]['image_path']),
    //                                         backgroundColor: Colors.transparent,
    //                                       ),
    //                                     ),
    //                                     SizedBox(
    //                                       width:
    //                                           SizeConfig.blockSizeHorizontal *
    //                                               2,
    //                                     ),
    //                                     Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.start,
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       children: [
    //                                         Text(
    //                                           scorefromserver["localteam"]['code'],
    //                                           style: TextStyle(
    //                                               color: Colors.white,
    //                                               fontSize: SizeConfig
    //                                                       .blockSizeVertical *
    //                                                   2.50,
    //                                               fontWeight: FontWeight.bold),
    //                                         ),
    //                                         SizedBox(
    //                                           height:
    //                                               SizeConfig.blockSizeVertical,
    //                                         ),
    //                                         Text(
    //                                           scorefromserver['team_a_scores'],
    //                                           style: TextStyle(
    //                                               color: Colors.white,
    //                                               fontSize: SizeConfig
    //                                                       .blockSizeVertical *
    //                                                   2.10,
    //                                               fontWeight: FontWeight.bold),
    //                                         ),
    //                                         Text(
    //                                           scorefromserver['team_a_over'],
    //                                           style: TextStyle(
    //                                               color: Colors.white,
    //                                               fontSize: SizeConfig
    //                                                       .blockSizeVertical *
    //                                                   2,
    //                                               fontWeight: FontWeight.bold),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Container(
    //                                     alignment: Alignment.center,
    //                                     child: CircleAvatar(
    //                                       radius: 25.0,
    //                                       child: Text(
    //                                         "VS",
    //                                         style: TextStyle(
    //                                             fontSize: SizeConfig
    //                                                     .blockSizeVertical *
    //                                                 2,
    //                                             fontWeight: FontWeight.bold),
    //                                       ),
    //                                       backgroundColor: Colors.white,
    //                                     )),
    //                                 Row(
    //                                   children: [
    //                                     Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.start,
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       children: [
    //                                         Text(
    //                                           scorefromserver["visitorteam"]['code'],
    //                                           style: TextStyle(
    //                                               color: Colors.white,
    //                                               fontSize: SizeConfig
    //                                                       .blockSizeVertical *
    //                                                   2.5,
    //                                               fontWeight: FontWeight.bold),
    //                                         ),
    //                                         SizedBox(
    //                                           height:
    //                                               SizeConfig.blockSizeVertical,
    //                                         ),
    //                                         // Text(
    //                                         //   scorefromserver['team_b_scores'],
    //                                         //   style: TextStyle(
    //                                         //       color: Colors.white,
    //                                         //       fontSize: SizeConfig
    //                                         //               .blockSizeVertical *
    //                                         //           2.10,
    //                                         //       fontWeight: FontWeight.bold),
    //                                         // ),
    //                                         // Text(
    //                                         //   scorefromserver['team_b_over'],
    //                                         //   style: TextStyle(
    //                                         //       color: Colors.white,
    //                                         //       fontSize: SizeConfig
    //                                         //               .blockSizeVertical *
    //                                         //           2,
    //                                         //       fontWeight: FontWeight.bold),
    //                                         // ),
    //                                       ],
    //                                     ),
    //                                     SizedBox(
    //                                       width:
    //                                           SizeConfig.blockSizeHorizontal *
    //                                               1,
    //                                     ),
    //                                     Container(
    //                                       // width: 70,
    //                                       // height: 80,
    //                                       // decoration: new BoxDecoration(
    //                                       //     shape: BoxShape.circle,
    //                                       //     image: new DecorationImage(
    //                                       //         fit: BoxFit.fill,
    //                                       //         image: new NetworkImage(pastmatches[i]["team_b_img"]==null?"www.google.png":pastmatches[i]["team_b_img"]
    //                                       //
    //                                       //         ))),
    //                                       child: CircleAvatar(
    //                                         radius: 35.0,
    //                                         backgroundImage: NetworkImage(
    //                                             scorefromserver["visitorteam"]['image_path']),
    //                                         backgroundColor: Colors.transparent,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Text(
    //                             scorefromserver['note'],
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: SizeConfig.blockSizeVertical * 2,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       width: SizeConfig.screenWidth,
    //                       margin: EdgeInsets.symmetric(
    //                           horizontal: SizeConfig.screenWidth * 0.05,
    //                           vertical: SizeConfig.blockSizeVertical),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Container(
    //                             width: SizeConfig.screenWidth * 0.3,
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(25),
    //                                 color: live == true
    //                                     ? Color(lightBlue)
    //                                     : Colors.white),
    //                             child: MaterialButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   live = true;
    //                                   commentary = false;
    //                                   scoreboard = false;
    //                                 });
    //                               },
    //                               materialTapTargetSize:
    //                                   MaterialTapTargetSize.shrinkWrap,
    //                               child: Text(
    //                                 "Live",
    //                                 style: TextStyle(
    //                                     color: live == true
    //                                         ? Colors.white
    //                                         : Colors.black,
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 1.50,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             width: SizeConfig.screenWidth * 0.3,
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(25),
    //                                 color: commentary == true
    //                                     ? Color(lightBlue)
    //                                     : Colors.white),
    //                             child: MaterialButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   live = false;
    //                                   commentary = true;
    //                                   scoreboard = false;
    //                                 });
    //                               },
    //                               materialTapTargetSize:
    //                                   MaterialTapTargetSize.shrinkWrap,
    //                               child: Text(
    //                                 "Commentary",
    //                                 style: TextStyle(
    //                                     color: commentary == true
    //                                         ? Colors.white
    //                                         : Colors.black,
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 1.50,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             width: SizeConfig.screenWidth * 0.3,
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(25),
    //                                 color: scoreboard == true
    //                                     ? Color(lightBlue)
    //                                     : Colors.white),
    //                             child: MaterialButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   live = false;
    //                                   commentary = false;
    //                                   scoreboard = true;
    //                                 });
    //                               },
    //                               materialTapTargetSize:
    //                                   MaterialTapTargetSize.shrinkWrap,
    //                               child: Text(
    //                                 "Scoreboard",
    //                                 style: TextStyle(
    //                                     color: scoreboard == true
    //                                         ? Colors.white
    //                                         : Colors.black,
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 1.50,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     if (live == true)
    //                       Container(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Color(0XFFF0F0F0),
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Text("Batting"),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.5,
    //                                     margin: EdgeInsets.only(
    //                                         right:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Container(
    //                                           width:
    //                                               SizeConfig.screenWidth * 0.05,
    //                                           child: Text("R"),
    //                                         ),
    //                                         Container(
    //                                           width:
    //                                               SizeConfig.screenWidth * 0.05,
    //                                           child: Text("B"),
    //                                         ),
    //                                         Container(
    //                                           width:
    //                                               SizeConfig.screenWidth * 0.05,
    //                                           child: Text("4s"),
    //                                         ),
    //                                         Container(
    //                                           width:
    //                                               SizeConfig.screenWidth * 0.05,
    //                                           child: Text("6s"),
    //                                         ),
    //                                         Container(
    //                                           width:
    //                                               SizeConfig.screenWidth * 0.1,
    //                                           child: Text("S/R"),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.only(
    //                                   top: SizeConfig.blockSizeVertical),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Text(
    //                                       "1. ${scorefromserver['batting'][0]['player_id']}",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.5,
    //                                     margin: EdgeInsets.only(
    //                                         right:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Container(
    //                                           child: Text(
    //                                               " ${scorefromserver['batting'][0]['score']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               "${scorefromserver['batting'][0]['ball']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               "${scorefromserver['batting'][0]['four_x']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                             child: Text(
    //                                                 "${scorefromserver['batting'][0]['six_x']}"
    //                                                     .toString())),
    //                                         Container(
    //                                             child: Text(
    //                                                 "${scorefromserver['batting'][0]['rate']}"
    //                                                     .toString()))
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               width: SizeConfig.screenWidth * 0.4,
    //                               margin: EdgeInsets.only(
    //                                   left: SizeConfig.screenWidth * 0.02,
    //                                   top: SizeConfig.blockSizeVertical),
    //                               padding: EdgeInsets.only(
    //                                   left: SizeConfig.blockSizeHorizontal * 1),
    //                               child: Text(
    //                                 "Not Out",
    //                                 style: TextStyle(
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 1.80,
    //                                     color: Colors.blue),
    //                               ),
    //                             ),
    //                             Container(
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.symmetric(
    //                                   horizontal: SizeConfig.screenWidth * 0.02,
    //                                   vertical: SizeConfig.blockSizeVertical),
    //                               child: Divider(
    //                                 color: Color(lightBlue),
    //                               ),
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.only(
    //                                   top: SizeConfig.blockSizeVertical),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                         SizeConfig.screenWidth * 0.02),
    //                                     child: Text(
    //                                       "1. ${scorefromserver['batting'][0]['player_id']}",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.5,
    //                                     margin: EdgeInsets.only(
    //                                         right:
    //                                         SizeConfig.screenWidth * 0.02),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Container(
    //                                           child: Text(
    //                                               " ${scorefromserver['batting'][0]['score']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               "${scorefromserver['batting'][0]['ball']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               "${scorefromserver['batting'][0]['four_x']}"
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                             child: Text(
    //                                                 "${scorefromserver['batting'][0]['six_x']}"
    //                                                     .toString())),
    //                                         Container(
    //                                             child: Text(
    //                                                 "${scorefromserver['batting'][0]['rate']}"
    //                                                     .toString()))
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               width: SizeConfig.screenWidth * 0.4,
    //                               margin: EdgeInsets.only(
    //                                   left: SizeConfig.screenWidth * 0.02,
    //                                   top: SizeConfig.blockSizeVertical),
    //                               padding: EdgeInsets.only(
    //                                   left: SizeConfig.blockSizeHorizontal * 1),
    //                               child: Text(
    //                                 "Not Out",
    //                                 style: TextStyle(
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 1.80,
    //                                     color: Colors.blue),
    //                               ),
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Color(0XFFF0F0F0),
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.only(
    //                                   top: SizeConfig.blockSizeVertical * 2),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Text("Bowling"),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.5,
    //                                     margin: EdgeInsets.only(
    //                                         right:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Container(
    //                                           child: Text("O"),
    //                                         ),
    //                                         Container(
    //                                           child: Text("M"),
    //                                         ),
    //                                         Container(
    //                                           child: Text("R"),
    //                                         ),
    //                                         Container(
    //                                           child: Text("W"),
    //                                         ),
    //                                         Container(
    //                                           child: Text("Econ."),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.only(
    //                                   top: SizeConfig.blockSizeVertical),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Text(
    //                                       "1.  ${scorefromserver['bowling'][0]['player_id']}",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.5,
    //                                     margin: EdgeInsets.only(
    //                                         right:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Container(
    //                                           child: Text(
    //                                               scorefromserver['bowling'][0]['overs']
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               scorefromserver['bowling'][0]['medians']
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               scorefromserver['bowling'][0]['runs']
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text(
    //                                               scorefromserver['bowling'][0]['wickets']
    //                                                   .toString()),
    //                                         ),
    //                                         Container(
    //                                           child: Text("5.60"),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Color(0XFFF0F0F0),
    //                               ),
    //                               width: SizeConfig.screenWidth,
    //                               margin: EdgeInsets.only(
    //                                   top: SizeConfig.blockSizeVertical * 2),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth * 0.3,
    //                                     margin: EdgeInsets.only(
    //                                         left:
    //                                             SizeConfig.screenWidth * 0.02),
    //                                     child: Text("Squads"),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                                 alignment: Alignment.bottomCenter,
    //                                 margin: EdgeInsets.only(left: 7, top: 10),
    //                                 child: Text(
    //                                   teams['team_a']['name'],
    //                                   style: TextStyle(
    //                                       color: Colors.blue,
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: 16),
    //                                 )),
    //                             Container(
    //                               height: SizeConfig.blockSizeVertical * 35,
    //                               child: GridView.count(
    //                                   crossAxisCount: 2,
    //                                   childAspectRatio: 8 / 1,
    //                                   crossAxisSpacing: 2,
    //                                   mainAxisSpacing: 2,
    //                                   physics: NeverScrollableScrollPhysics(),
    //                                   children: squadwidget()),
    //                             ),
    //                             Divider(
    //                               height: 15,
    //                               thickness: 1.5,
    //                               color: Colors.grey[300],
    //                             ),
    //                             Container(
    //                                 alignment: Alignment.bottomCenter,
    //                                 margin: EdgeInsets.only(left: 7, top: 10),
    //                                 child: Text(teams['team_b']['name'],
    //                                     style: TextStyle(
    //                                         color: Colors.blue,
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 16))),
    //                             Container(
    //                               height: SizeConfig.blockSizeVertical * 35,
    //                               child: GridView.count(
    //                                   crossAxisCount: 2,
    //                                   childAspectRatio: 7 / 1,
    //                                   crossAxisSpacing: 2,
    //                                   mainAxisSpacing: 2,
    //                                   physics: NeverScrollableScrollPhysics(),
    //                                   children: squadwidget2()),
    //                             ),
    //                             Divider(
    //                               height: 15,
    //                               thickness: 1.5,
    //                               color: Colors.grey[300],
    //                             ),
    //                           ],
    //                         ),
    //                       )
    //                     else if (commentary == true)
    //                       Container(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               child: Text(
    //                                 "Last 36 Balls",
    //                                 style: TextStyle(
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 2.50,
    //                                     color: Colors.black),
    //                               ),
    //                               margin: EdgeInsets.only(
    //                                   left: SizeConfig.screenWidth * 0.02,
    //                                   top: SizeConfig.blockSizeVertical),
    //                             ),
    //                             Container(
    //                               margin: EdgeInsets.only(
    //                                   left: SizeConfig.screenWidth * 0.02,
    //                                   top: SizeConfig.blockSizeVertical),
    //                               width: SizeConfig.screenWidth,
    //                               height: SizeConfig.blockSizeVertical * 5,
    //                               child: SingleChildScrollView(
    //                                 scrollDirection: Axis.horizontal,
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceAround,
    //                                   children: Lastballs(),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             Row(
    //                               children: [
    //                                 Container(
    //                                   child: Text(
    //                                     "Last Wkt:  " +
    //                                         scorefromserver['lastwicket']
    //                                             ['player'] +
    //                                         " " +
    //                                         scorefromserver['lastwicket']['run']
    //                                             .toString() +
    //                                         "(" +
    //                                         scorefromserver['lastwicket']
    //                                                 ['ball']
    //                                             .toString() +
    //                                         ")",
    //                                     style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeVertical *
    //                                                 2,
    //                                         color: Colors.black),
    //                                   ),
    //                                   margin: EdgeInsets.only(
    //                                       left: SizeConfig.screenWidth * 0.02,
    //                                       top: SizeConfig.blockSizeVertical),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 10,
    //                                 ),
    //                                 Container(
    //                                   child: Text(
    //                                     "Partnership:  " +
    //                                         " " +
    //                                         scorefromserver['partnership']
    //                                                 ['run']
    //                                             .toString() +
    //                                         "(" +
    //                                         scorefromserver['partnership']
    //                                                 ['ball']
    //                                             .toString() +
    //                                         ")",
    //                                     style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeVertical *
    //                                                 2,
    //                                         color: Colors.black),
    //                                   ),
    //                                   margin: EdgeInsets.only(
    //                                       left: SizeConfig.screenWidth * 0.02,
    //                                       top: SizeConfig.blockSizeVertical),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             Container(
    //                               child: Text(
    //                                 "Next Batsmen:  " +
    //                                     scorefromserver['next_batsman'],
    //                                 style: TextStyle(
    //                                     fontSize:
    //                                         SizeConfig.blockSizeVertical * 2,
    //                                     color: Colors.black),
    //                               ),
    //                               margin: EdgeInsets.only(
    //                                   left: SizeConfig.screenWidth * 0.02,
    //                                   top: SizeConfig.blockSizeVertical),
    //                             ),
    //                             // Container(
    //                             //   width: SizeConfig.screenWidth,
    //                             //   margin: EdgeInsets.symmetric(
    //                             //       horizontal: SizeConfig.screenWidth * 0.02,
    //                             //       vertical: SizeConfig.blockSizeVertical
    //                             //   ),
    //                             //   child: Row(
    //                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             //     crossAxisAlignment: CrossAxisAlignment.start,
    //                             //     children: [
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.1,
    //                             //         child: Text("2"),
    //                             //       ),
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.8,
    //                             //         child: Text("Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
    //                             //           style: TextStyle(
    //                             //               fontSize: SizeConfig.blockSizeVertical * 1.50
    //                             //           ),
    //                             //           textAlign: TextAlign.justify,),
    //                             //       )
    //                             //     ],
    //                             //   ),
    //                             // ),
    //                             // Container(
    //                             //   width: SizeConfig.screenWidth,
    //                             //   margin: EdgeInsets.symmetric(
    //                             //       horizontal: SizeConfig.screenWidth * 0.02,
    //                             //       vertical: SizeConfig.blockSizeVertical
    //                             //   ),
    //                             //   child: Row(
    //                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             //     crossAxisAlignment: CrossAxisAlignment.start,
    //                             //     children: [
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.1,
    //                             //         child: Text("2"),
    //                             //       ),
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.8,
    //                             //         child: Text("Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
    //                             //           style: TextStyle(
    //                             //               fontSize: SizeConfig.blockSizeVertical * 1.50
    //                             //           ),
    //                             //           textAlign: TextAlign.justify,),
    //                             //       )
    //                             //     ],
    //                             //   ),
    //                             // ),
    //                             // Container(
    //                             //   width: SizeConfig.screenWidth,
    //                             //   margin: EdgeInsets.symmetric(
    //                             //       horizontal: SizeConfig.screenWidth * 0.02,
    //                             //       vertical: SizeConfig.blockSizeVertical
    //                             //   ),
    //                             //   child: Row(
    //                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             //     crossAxisAlignment: CrossAxisAlignment.start,
    //                             //     children: [
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.1,
    //                             //         child: Text("2"),
    //                             //       ),
    //                             //       Container(
    //                             //         width: SizeConfig.screenWidth * 0.8,
    //                             //         child: Text("Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
    //                             //           style: TextStyle(
    //                             //               fontSize: SizeConfig.blockSizeVertical * 1.50
    //                             //           ),
    //                             //           textAlign: TextAlign.justify,),
    //                             //       )
    //                             //     ],
    //                             //   ),
    //                             // ),
    //                           ],
    //                         ),
    //                       )
    //                     else
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: SizeConfig.screenWidth,
    //                             margin: EdgeInsets.symmetric(
    //                                 horizontal: SizeConfig.screenWidth * 0.05,
    //                                 vertical: SizeConfig.blockSizeVertical),
    //                             decoration: BoxDecoration(
    //                                 color: Color(lightBlue),
    //                                 borderRadius: BorderRadius.circular(15)),
    //                             child: Theme(
    //                               data: Theme.of(context).copyWith(
    //                                   dividerColor: Colors.transparent),
    //                               child: ExpansionTile(
    //                                   title: Text(
    //                                     pastmatches['scorecard']["1"]["team"]
    //                                         ['name'],
    //                                     style: TextStyle(
    //                                       color: Colors.white,
    //                                     ),
    //                                   ),
    //                                   backgroundColor: Color(lightBlue),
    //                                   iconColor: Colors.white,
    //                                   collapsedIconColor: Colors.white,
    //                                   children: [
    //                                     Column(
    //                                       children: getEvetnts(),
    //                                     ),
    //                                     Column(
    //                                       children: bowler(),
    //                                     )
    //                                   ]),
    //                             ),
    //                           ),
    //                           score2 == 'null'
    //                               ? Container()
    //                               : Container(
    //                                   width: SizeConfig.screenWidth,
    //                                   margin: EdgeInsets.symmetric(
    //                                       horizontal:
    //                                           SizeConfig.screenWidth * 0.05,
    //                                       vertical:
    //                                           SizeConfig.blockSizeVertical),
    //                                   decoration: BoxDecoration(
    //                                       color: Color(lightBlue),
    //                                       borderRadius:
    //                                           BorderRadius.circular(15)),
    //                                   child: Theme(
    //                                     data: Theme.of(context).copyWith(
    //                                         dividerColor: Colors.transparent),
    //                                     child: ExpansionTile(
    //                                       title: Text(
    //                                         pastmatches['scorecard']["2"]
    //                                             ["team"]['name'],
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       backgroundColor: Color(lightBlue),
    //                                       iconColor: Colors.white,
    //                                       collapsedIconColor: Colors.white,
    //                                       children: [
    //                                         Column(
    //                                           children: getEvetnts2(),
    //                                         ),
    //                                         Column(
    //                                           children: bowler2(),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                           score3 == 'null'
    //                               ? Container()
    //                               : Container(
    //                                   width: SizeConfig.screenWidth,
    //                                   margin: EdgeInsets.symmetric(
    //                                       horizontal:
    //                                           SizeConfig.screenWidth * 0.05,
    //                                       vertical:
    //                                           SizeConfig.blockSizeVertical),
    //                                   decoration: BoxDecoration(
    //                                       color: Color(lightBlue),
    //                                       borderRadius:
    //                                           BorderRadius.circular(15)),
    //                                   child: Theme(
    //                                     data: Theme.of(context).copyWith(
    //                                         dividerColor: Colors.transparent),
    //                                     child: ExpansionTile(
    //                                       title: Text(
    //                                         pastmatches['scorecard']["1"]
    //                                             ["team"]['name'],
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       backgroundColor: Color(lightBlue),
    //                                       iconColor: Colors.white,
    //                                       collapsedIconColor: Colors.white,
    //                                       children: [
    //                                         Column(
    //                                           children: getEvetnts3(),
    //                                         ),
    //                                         Column(
    //                                           children: bowler3(),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                           score4 == 'null'
    //                               ? Container()
    //                               : Container(
    //                                   width: SizeConfig.screenWidth,
    //                                   margin: EdgeInsets.symmetric(
    //                                       horizontal:
    //                                           SizeConfig.screenWidth * 0.05,
    //                                       vertical:
    //                                           SizeConfig.blockSizeVertical),
    //                                   decoration: BoxDecoration(
    //                                       color: Color(lightBlue),
    //                                       borderRadius:
    //                                           BorderRadius.circular(15)),
    //                                   child: Theme(
    //                                     data: Theme.of(context).copyWith(
    //                                         dividerColor: Colors.transparent),
    //                                     child: ExpansionTile(
    //                                       title: Text(
    //                                         pastmatches['scorecard']["2"]
    //                                             ["team"]['name'],
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       backgroundColor: Color(lightBlue),
    //                                       iconColor: Colors.white,
    //                                       collapsedIconColor: Colors.white,
    //                                       children: [
    //                                         Column(
    //                                           children: getEvetnts4(),
    //                                         ),
    //                                         Column(
    //                                           children: bowler4(),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                         ],
    //                       ),
    //                   ],
    //                 ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
   return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        debugShowCheckedModeBanner: false,
        home:
        isLoading?Scaffold(
            appBar: AppBar(
              title: Text(""),
              centerTitle: true,
              elevation: 0,
              leading: GestureDetector(onTap:(){
                Navigator.pop(context);
              },child:Icon(Icons.arrow_back)),
              backgroundColor: Color(lightBlue),
              iconTheme: IconThemeData(color: Colors.white),

            ),body: Center(
          child: Container(
            height: 60,
            child: CircularProgressIndicator(

            ),
          ),
        )): DefaultTabController(
            initialIndex: 1,
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text("${scorefromserver['localteam']['code']+ " vs "+scorefromserver['visitorteam']['code']}"),
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //     Matchsquad(firstteam: scorefromserver['localteam']['name'],firstsquad: squada,secondteam:scorefromserver['visitorteam']['name'] ,secondsquad: squadb,)));

                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text(scorefromserver['localteam']['code']),
                          ),
                        ),
                        Divider(
                            height: 5, thickness: 1.5, color: Colors.grey[200]),
                        GestureDetector(
                          onTap: (){
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //     Matchsquad(firstteam: scorefromserver['localteam']['name'],firstsquad: squada,secondteam:scorefromserver['visitorteam']['name'] ,secondsquad: squadb,)));

                          },
                          child: Container(
                            // color:Colors.grey,
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text(scorefromserver['visitorteam']['code']),
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
                                Text(scorefromserver['status'],
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
                                Text(scorefromserver['league']['name'],
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
                                Text(scorefromserver['type'],
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
                                    scorefromserver['tosswon']==null?"": scorefromserver['tosswon']['name'],
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
                                // Text(scorefromserver['firstumpire']['fullname'],
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
                                  "Venue",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Text("${scorefromserver['venue']==null?"":scorefromserver['venue']['name'].toString()}",
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
                            margin: EdgeInsets.all(5.0),
                            height: SizeConfig.screenHeight * 0.30,
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
                                padding: EdgeInsets.only(left:10.0,right:10,top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(

                                            width: SizeConfig.screenWidth*0.85,
                                            child: Text(scorefromserver['league']['name']+" ,"+scorefromserver['round'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 11),)),
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
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Text(
                                    //       scorefromserver['starting_at'].toString().substring(0,10).split("-")[2]+"-"+  months[int.parse(scorefromserver['starting_at'].toString().substring(0,10).split("-")[1])]+"-"+  scorefromserver['starting_at'].toString().substring(0,10).split("-")[0]
                                    //           +" , ",
                                    //       style: TextStyle(fontSize: 12),
                                    //     ),
                                    //
                                    //     Text(
                                    //         int.parse(scorefromserver['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(scorefromserver['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(scorefromserver['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                                    //     )
                                    //   ],
                                    // ),
                                    Text(
                                      DateTime.parse(scorefromserver["starting_at"])
                                          .toLocal().toString()
                                          .substring(0, 16),
                                      style: TextStyle(
                                          fontSize: SizeConfig.blockSizeVertical * 1.5),
                                    ),
                                    Text("Live",style: TextStyle(color: Colors.red),),

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container
                                          (
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(shape: BoxShape.circle,
                                              image: DecorationImage(image: NetworkImage(scorefromserver['localteam']['image_path']),)),
                                        ),
                                        Text(
                                          scorefromserver['localteam']['code'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(child: SizedBox()),
                                        scorefromserver['runs'].length==1?
                                        scorefromserver['toss_won_team_id']==teamaid&&scorefromserver['elected']=="batting" ?
                                        Text(scorefromserver['runs'][0]['score']
                                            .toString() + "/" +
                                            scorefromserver['runs'][0]['wickets']
                                                .toString() + " (" +
                                            scorefromserver['runs'][0]['overs']
                                                .toString() + ")",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)): scorefromserver['toss_won_team_id']==teamaid&&scorefromserver['elected']=="bowling" ?Text("0/0 (0.0)",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)): scorefromserver['toss_won_team_id']==teambid&&scorefromserver['elected']=="bowling" ?
                                        Text(scorefromserver['runs'][0]['score']
                                            .toString() + "/" +
                                            scorefromserver['runs'][0]['wickets']
                                                .toString() + " (" +
                                            scorefromserver['runs'][0]['overs']
                                                .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)):Text("0/0 (0.0)",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)):
                                       scorefromserver['runs'][0]['team_id'] == teamaid ?
                                        Text(
                                           scorefromserver['runs'].length == 0
                                                ? ""
                                                :scorefromserver['runs'][0]['score']
                                                .toString() + "/" +
                                               scorefromserver['runs'][0]['wickets']
                                                    .toString() + " (" +
                                               scorefromserver['runs'][0]['overs']
                                                    .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)) : Text(
                                           scorefromserver['runs'].length == 1
                                                ? ""
                                                :scorefromserver['runs'][1]['score']
                                                .toString() + "/" +
                                               scorefromserver['runs'][1]['wickets']
                                                    .toString() + " (" +
                                               scorefromserver['runs'][1]['overs']
                                                    .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))
                                        // Text(
                                        //     scorefromserver['runs'].length==1?"":scorefromserver['runs'][1]['score'].toString()+"/"+scorefromserver['runs'][1]['wickets'].toString()+" ("+scorefromserver['runs'][1]['overs'].toString()+")",
                                        //
                                        //     style: TextStyle(
                                        //         color: Colors.black,
                                        //         fontSize: 16,
                                        //         fontWeight: FontWeight.bold)),

                                        //Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container
                                          (
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(shape: BoxShape.circle,
                                              image: DecorationImage(image: NetworkImage(scorefromserver['visitorteam']['image_path']),)),
                                        ),
                                        Text(
                                          scorefromserver['visitorteam']['code'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(child: SizedBox()),
                                        scorefromserver['runs'].length==1?  scorefromserver['toss_won_team_id']==teamaid&&scorefromserver['elected']=="bowling" ?
                                        Text(scorefromserver['runs'][0]['score']
                                            .toString() + "/" +
                                            scorefromserver['runs'][0]['wickets']
                                                .toString() + " (" +
                                            scorefromserver['runs'][0]['overs']
                                                .toString() + ")",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)): scorefromserver['toss_won_team_id']==teamaid&&scorefromserver['elected']=="batting" ?Text("0/0 (0.0)",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: SizeConfig.blockSizeVertical * 2,
                                                fontWeight: FontWeight.bold)): scorefromserver['toss_won_team_id']==teambid&&scorefromserver['elected']=="batting" ?
                                        Text(scorefromserver['runs'][0]['score']
                                            .toString() + "/" +
                                            scorefromserver['runs'][0]['wickets']
                                                .toString() + " (" +
                                            scorefromserver['runs'][0]['overs']
                                                .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)):Text("0/0 (0.0)",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)):scorefromserver['runs'][1]['team_id'] ==
                                            teambid ?
                                        Text(
                                           scorefromserver['runs'].length == 0
                                                ? ""
                                                :scorefromserver['runs'][1]['score']
                                                .toString() + "/" +
                                               scorefromserver['runs'][1]['wickets']
                                                    .toString() + " (" +
                                               scorefromserver['runs'][1]['overs']
                                                    .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)) : Text(
                                           scorefromserver['runs'].length == 0
                                                ? ""
                                                :scorefromserver['runs'][0]['score']
                                                .toString() + "/" +
                                               scorefromserver['runs'][0]['wickets']
                                                    .toString() + " (" +
                                               scorefromserver['runs'][0]['overs']
                                                    .toString() + ")"
                                            ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text( scorefromserver['toss_won_team_id']==teamaid?scorefromserver['localteam']['code']+" Opt to "+scorefromserver['elected']:scorefromserver['visitorteam']['code']+" Opt to "+scorefromserver['elected']
                                      ,style: TextStyle(color: Colors.red),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),


                      Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0XFFF0F0F0),
                                                      ),
                                                      width: SizeConfig.screenWidth,
                                                      child:  Table(
                                                        columnWidths: {
                                                          0: FlexColumnWidth(6),
                                                          1: FlexColumnWidth(2),
                                                          2: FlexColumnWidth(2),
                                                          3: FlexColumnWidth(2),
                                                          4: FlexColumnWidth(2),
                                                          5: FlexColumnWidth(2.5),
                                                        },
                                                        //defaultColumnWidth: FixedColumnWidth(140.0),
                                                        border: TableBorder(


                                                        ),

                                                        children: [
                                                          TableRow(children: [
                                                            Container(
                                                                child: Container(

                                                                    padding: EdgeInsets.only(top:10,left:8),
                                                                    child: Text( "Batting",

                                                                        textAlign: TextAlign.start,
                                                                        style: TextStyle(
                                                                            fontSize: 16.0,
                                                                            fontWeight:
                                                                            FontWeight.bold)))),
                                                            Container(

                                                                padding: EdgeInsets.only(top:10),
                                                                child: Column(children: [
                                                                  Text(" R",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16,
                                                                          color: Colors.black))
                                                                ])),

                                                            Container(

                                                                padding: EdgeInsets.all(10),
                                                                child: Column(children: [
                                                                  Text( "B",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16,
                                                                          color: Colors.black))
                                                                ])),
                                                            Container(

                                                                padding: EdgeInsets.all(10),
                                                                child: Column(children: [
                                                                  Text( "4s",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16,
                                                                          color: Colors.black))
                                                                ])),
                                                            Container(

                                                                padding: EdgeInsets.all(10),
                                                                child: Column(children: [
                                                                  Text( "6s",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16,
                                                                          color: Colors.black))
                                                                ])),
                                                            Container(

                                                                padding: EdgeInsets.all(10),
                                                                child: Column(children: [
                                                                  Text( "SR",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16,
                                                                          color: Colors.black))
                                                                ]))

                                                            //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                                                          ])

                                                        ],
                                                      ),
                                                    ),
                        scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_one_on_creeze_id']==null?Container():
                        Table(
                          columnWidths: {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(2.5),
                          },
                          //defaultColumnWidth: FixedColumnWidth(140.0),
                        
                          children: [
                            TableRow(children: [
                              Container(
                                  child: Container(

                                      padding: EdgeInsets.only(top:10,left:8),
                                      child: Text(                                             teams[scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_one_on_creeze_id']],

                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              )))),
                              Container(

                                  padding: EdgeInsets.only(top:10),
                                  child: Column(children: [
                                    Text(" ${Strikerruns}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),

                              Container(
                                 
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${Strikerballs}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(
                               
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${Strikerfours}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${Strikersix}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(
                                 
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${Strikerrate}",
                                        style: TextStyle(
                                            
                                            fontSize: 16,
                                            color: Colors.black))
                                  ]))

                              //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                            ])

                          ],
                        ),
                        // Container(
                        //              decoration: BoxDecoration(
                        //                color: Colors.white,
                        //              ),
                        //              width: SizeConfig.screenWidth,
                        //              margin: EdgeInsets.only(
                        //                  top: SizeConfig.blockSizeVertical),
                        //              child: Row(
                        //                mainAxisAlignment:
                        //                    MainAxisAlignment.spaceBetween,
                        //                children: [
                        //                  Container(
                        //                    width: SizeConfig.screenWidth * 0.4,
                        //                    margin: EdgeInsets.only(
                        //                        left:
                        //                            SizeConfig.screenWidth * 0.01),
                        //                    child: Text(
                        //                      teams[scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_one_on_creeze_id']],
                        //                      style: TextStyle(
                        //                          fontWeight: FontWeight.bold),
                        //                    ),
                        //                  ),
                        //                  Container(
                        //                    width: SizeConfig.screenWidth * 0.515,
                        //                    margin: EdgeInsets.only(
                        //                        right:
                        //                            SizeConfig.screenWidth * 0.01),
                        //                    child: Row(
                        //                      mainAxisAlignment:
                        //                          MainAxisAlignment.spaceBetween,
                        //                      children: [
                        //                        Container(
                        //                          width:
                        //                          SizeConfig.screenWidth * 0.06,
                        //                          child: Text(
                        //                              " ${Strikerruns}"
                        //                                  .toString()),
                        //                        ),
                        //                        Container(
                        //                          width:
                        //                          SizeConfig.screenWidth * 0.05,
                        //                          child: Text(
                        //                              "${Strikerballs}"
                        //                                  .toString()),
                        //                        ),
                        //                        Container(
                        //                          width:
                        //                          SizeConfig.screenWidth * 0.05,
                        //                          child: Text(
                        //                              "${Strikerfours}"
                        //                                  .toString()),
                        //                        ),
                        //                        Container(
                        //                            width:
                        //                            SizeConfig.screenWidth * 0.05,
                        //                            child: Text(
                        //                                "${Strikersix}"
                        //                                    .toString())),
                        //                        Container(
                        //                            width:
                        //                            SizeConfig.screenWidth * 0.09,
                        //                            child: Text(
                        //                                "${Strikerrate}"
                        //                                    .toString()))
                        //                      ],
                        //                    ),
                        //                  ),
                        //                ],
                        //              ),
                        //            ),
                        scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_two_on_creeze_id']==null?Container():
                        Table(
                          columnWidths: {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(2.5),
                          },
                          //defaultColumnWidth: FixedColumnWidth(140.0),
                         

                          children: [
                            TableRow(children: [
                              Container(
                                  child: Container(

                                      padding: EdgeInsets.only(top:10,left:8),
                                      child: Text(     "${teams[scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_two_on_creeze_id']]}",

                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                             )))),
                              Container(

                                  padding: EdgeInsets.only(top:10),
                                  child: Column(children: [
                                    Text(" ${nonStrikerruns}",
                                        style: TextStyle(
                                         
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),

                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${nonStrikerballs}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${nonStrikerfours}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${nonStrikersix}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( "${nonStrikerrate}",
                                        style: TextStyle(
                                           
                                            fontSize: 16,
                                            color: Colors.black))
                                  ]))

                              //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                            ])

                          ],
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFF0F0F0),
                          ),
                          width: SizeConfig.screenWidth,
                          child:  Table(
                            columnWidths: {
                              0: FlexColumnWidth(6),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(2.5),
                            },
                            //defaultColumnWidth: FixedColumnWidth(140.0),
                            border: TableBorder(


                            ),

                            children: [
                              TableRow(children: [
                                Container(
                                    child: Container(

                                        padding: EdgeInsets.only(top:10,left:8),
                                        child:
                                          Text( "Bowling",

                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.bold))
                                        )),
                                Container(

                                    padding: EdgeInsets.only(top:10),
                                    child: Column(children: [
                                      Text(" O",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))
                                    ])),

                                Container(

                                    padding: EdgeInsets.all(10),
                                    child: Column(children: [
                                      Text( "R",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))
                                    ])),
                                Container(

                                    padding: EdgeInsets.all(10),
                                    child: Column(children: [
                                      Text( "W",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))
                                    ])),
                                Container(

                                    padding: EdgeInsets.all(10),
                                    child: Column(children: [
                                      Text( "M",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))
                                    ])),
                                Container(

                                    padding: EdgeInsets.all(10),
                                    child: Column(children: [
                                      Text( "Eco",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))
                                    ]))

                                //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                              ])

                            ],
                          ),
                        ),
                        scorefromserver ['balls'][scorefromserver['balls'].length-1]['bowler']==null?Container():  Table(
                          columnWidths: {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(2.5),
                          },
                          //defaultColumnWidth: FixedColumnWidth(140.0),
                        

                          children: [
                            TableRow(children: [
                              Container(
                                  child: Container(

                                      padding: EdgeInsets.only(top:10,left:8),
                                      child: Text(     "${scorefromserver['balls'][scorefromserver['balls'].length-1]['bowler']['fullname']}",

                                          textAlign: TextAlign.start,

                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,

                                             )))),
                              Container(

                                  padding: EdgeInsets.only(top:10),
                                  child: Column(children: [
                                    Text("  ${currentbowler['overs']}",
                                        style: TextStyle(
                                           
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),

                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( " ${currentbowler['runs']}",
                                        style: TextStyle(
                                           
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( " ${currentbowler['wickets']}",
                                        style: TextStyle(
                                            
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( " ${currentbowler['medians']}",
                                        style: TextStyle(
                                           
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                              Container(

                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text( " ${currentbowler['rate']}",
                                        style: TextStyle(

                                            fontSize: 16,
                                            color: Colors.black))
                                  ]))

                              //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                            ])

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

                        Container(
                          height: SizeConfig.screenHeight*0.24,
                          child: ListView(
                            children: balls(),
                          ),
                        )
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

                                // initiallyExpanded : index==selected,
                                // onExpansionChanged: ((newState){
                                //   if(newState)
                                //     setState(() {
                                //       Duration(seconds:  20000);
                                //       selected = index;
                                //     });
                                //   else
                                //     setState(() {
                                //       selected = -1;
                                //     });
                                // }),
                                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    teamaid== scorefromserver['runs'][0]['team_id']?
                                    Text(
                                      scorefromserver['localteam']["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ): Text(
                                      scorefromserver['visitorteam']["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    teamaid== scorefromserver['runs'][0]['team_id']?

                                    Text(
                                        scorefromserver['runs'].length==0?"mpksdmp;v":scorefromserver['runs'][0]['score'].toString()+"/"+scorefromserver['runs'][0]['wickets'].toString()+" ("+scorefromserver['runs'][0]['overs'].toString()+")",

                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)):
                                    Text(
                                        scorefromserver['runs'].length==1?scorefromserver['runs'][0]['score'].toString()+"/"+scorefromserver['runs'][0]['wickets'].toString()+" ("+scorefromserver['runs'][0]['overs'].toString()+")":scorefromserver['runs'][0]['score'].toString()+"/"+scorefromserver['runs'][0]['wickets'].toString()+" ("+scorefromserver['runs'][0]['overs'].toString()+")",

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

                                        children: bowlingorderlist(),
                                      ))

                                ],
                              )),


                        ),

                        scorefromserver['runs'].length==1?Container():Container(
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
                              // initiallyExpanded: index==selected,
                              // onExpansionChanged: ((newState){
                              //   if(newState)
                              //     setState(() {
                              //       selected=1;
                              //       Duration(seconds:  20000);
                              //       selected = index;
                              //     });
                              //   else
                              //     setState(() {
                              //       selected = -1;
                              //     });
                              // }),
                                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    teambid==scorefromserver['runs'][1]['team_id']?
                                    Text(
                                      scorefromserver['visitorteam']["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      )
                                    ):  Text(
                            scorefromserver['localteam']["name"],
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                                    teambid==scorefromserver['runs'][1]['team_id']?
                                    Text(
                                        scorefromserver['runs'].length==1?"vxkj":scorefromserver['runs'][1]['score'].toString()+"/"+scorefromserver['runs'][1]['wickets'].toString()+" ("+scorefromserver['runs'][1]['overs'].toString()+")"

                                        ,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)):Text(
                                        scorefromserver['runs'].length==0?"vxkj":scorefromserver['runs'][1]['score'].toString()+"/"+scorefromserver['runs'][1]['wickets'].toString()+" ("+scorefromserver['runs'][1]['overs'].toString()+")"

                                        ,style: TextStyle(
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
                                        children: bowlingsecondorderlist(),
                                      ))
                                ]),
                          ),
                        ),
                        scorefromserver['runs'].length<=2?Container():Container(
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
                              // initiallyExpanded: index==selected,
                              // onExpansionChanged: ((newState){
                              //   if(newState)
                              //     setState(() {
                              //       selected=1;
                              //       Duration(seconds:  20000);
                              //       selected = index;
                              //     });
                              //   else
                              //     setState(() {
                              //       selected = -1;
                              //     });
                              // }),
                                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    teambid==scorefromserver['runs'][2]['team_id']?
                                    Text(
                                        scorefromserver['visitorteam']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )
                                    ):  Text(
                                      scorefromserver['localteam']["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    teambid==scorefromserver['runs'][2]['team_id']?
                                    Text(
                                        scorefromserver['runs'].length==1?"vxkj":scorefromserver['runs'][2]['score'].toString()+"/"+scorefromserver['runs'][2]['wickets'].toString()+" ("+scorefromserver['runs'][2]['overs'].toString()+")"

                                        ,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)):Text(
                                        scorefromserver['runs'].length==0?"vxkj":scorefromserver['runs'][2]['score'].toString()+"/"+scorefromserver['runs'][2]['wickets'].toString()+" ("+scorefromserver['runs'][2]['overs'].toString()+")"

                                        ,style: TextStyle(
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
                                        children: batting3order(),
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
                                        children: bowlingthirdorderlist(),
                                      ))
                                ]),
                          ),
                        ),
                        scorefromserver['runs'].length<=3?Container():Container(
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
                              // initiallyExpanded: index==selected,
                              // onExpansionChanged: ((newState){
                              //   if(newState)
                              //     setState(() {
                              //       selected=1;
                              //       Duration(seconds:  20000);
                              //       selected = index;
                              //     });
                              //   else
                              //     setState(() {
                              //       selected = -1;
                              //     });
                              // }),
                                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    teambid==scorefromserver['runs'][3]['team_id']?
                                    Text(
                                        scorefromserver['visitorteam']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )
                                    ):  Text(
                                      scorefromserver['localteam']["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    teambid==scorefromserver['runs'][3]['team_id']?
                                    Text(
                                        scorefromserver['runs'].length==1?"vxkj":scorefromserver['runs'][3]['score'].toString()+"/"+scorefromserver['runs'][3]['wickets'].toString()+" ("+scorefromserver['runs'][3]['overs'].toString()+")"

                                        ,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)):Text(
                                        scorefromserver['runs'].length==0?"vxkj":scorefromserver['runs'][3]['score'].toString()+"/"+scorefromserver['runs'][3]['wickets'].toString()+" ("+scorefromserver['runs'][3]['overs'].toString()+")"

                                        ,style: TextStyle(
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
                                        children: batting4ndorder(),
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
                                        children: bowlingfourthorderlist(),
                                      ))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  // ListView(
                  //   children: [
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     Container(
                  //
                  //       width: SizeConfig.screenWidth,
                  //       decoration: BoxDecoration(
                  //         color: Color(lightBlue),
                  //       ),
                  //       child: Theme(
                  //         data: Theme.of(context)
                  //             .copyWith(dividerColor: Colors.transparent),
                  //         child: ExpansionTile(
                  //           initiallyExpanded: true,
                  //           title: Text(
                  //             scorefromserver['localteam']['name'],
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           iconColor: Colors.blue,
                  //           collapsedIconColor: Colors.white,
                  //           children: squadwidget(),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20),
                  //     Container(
                  //       // margin: EdgeInsets.only(top:10,right: 3,left:3),                          width: SizeConfig.screenWidth,
                  //       decoration: BoxDecoration(
                  //         color: Color(lightBlue),
                  //       ),
                  //       child: Theme(
                  //         data: Theme.of(context)
                  //             .copyWith(dividerColor: Colors.transparent),
                  //         child: ExpansionTile(
                  //             title: Text(
                  //               scorefromserver['visitorteam']['name'],
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             backgroundColor: Color(lightBlue),
                  //             iconColor: Colors.white,
                  //             collapsedIconColor: Colors.white,
                  //             children: squadwidgetb()),
                  //       ),
                  //     )
                  //   ],
                  // ),

                  Matchsquad(firstteam: scorefromserver['localteam']['name'],firstsquad: squada,secondteam:scorefromserver['visitorteam']['name'] ,secondsquad: squadb,)
                ],
              ),
            )));
    
  }

  dynamic scorefromserver = new List();
  var Commentary = new List();
  var teamaid;
  var squada=[];
  var squadb=[];
  var teambid;
 // dynamic scorefromserver=new List();
  dynamic scorecarda=new List();
  dynamic scorecardc=new List();
  dynamic scorecardd=new List();
  dynamic bowlingscorecarda=new List();
  dynamic bowlingscorecardb=new List();
  dynamic bowlingscorecardc=new List();
  dynamic bowlingscorecardd=new List();
  dynamic scorecardb=new List();
  dynamic recentballs=new List();
  var Striker;
  var Strikerruns;
  var Strikerballs;
  var Strikersix;
  var Strikerfours;
  var Strikerrate;
  var nonStriker;
  var nonStrikerruns;
  var nonStrikerballs;
  var nonStrikersix;
  var nonStrikerfours;
  var currentbowler;
  var teams={};
  dynamic scoredata=[];
  var outtypes={};
  var nonStrikerrate;
  dynamic nonstriker=new List();
  var coiunter=0;
  void getlivescore() async {
    setState(() {
      //  isLoading=true;
    });

    try {
      final response = await get(Uri.parse(url));

      print("bjkbjjj" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        scorefromserver = responseJson['data'];
        teamaid=scorefromserver['localteam_id'];
        teambid=scorefromserver['visitorteam_id'];
              recentballs=scorefromserver['balls'];

        List lista=[];
        coiunter=coiunter+1;
     if(coiunter==1){
       for(int i =0; i<scorefromserver['lineup'].length;i++){
         lista.add(User('User1', 23));
         lista.forEach((user) => teams[scorefromserver['lineup'][i]['id']] = scorefromserver['lineup'][i]['fullname']);

         
         if(scorefromserver['lineup'][i]['lineup']['team_id']==teamaid){
           squada.add(scorefromserver['lineup'][i]);
           print(scorefromserver['lineup'][i]);
           lista.add(User('User1', 23));
           lista.forEach((user) => playersa[scorefromserver['lineup'][i]['id']] = scorefromserver['lineup'][i]['fullname']);

         }
         else{
           squadb.add(scorefromserver['lineup'][i]);
           lista.add(User('User1', 23));
           lista.forEach((user) => playersb[scorefromserver['lineup'][i]['id']] = scorefromserver['lineup'][i]['fullname']);

         }
       }
       for(int i=0;i<scorefromserver['batting'].length;i++){
         if(scorefromserver['batting'][i]['scoreboard']=="S1"){
           scorecarda.add(scorefromserver['batting'][i]);
         }
         else if(scorefromserver['batting'][i]['scoreboard']=="S2"){
           scorecardb.add(scorefromserver['batting'][i]);
         }
         else if(scorefromserver['batting'][i]['scoreboard']=="S3"){
           scorecardc.add(scorefromserver['batting'][i]);
         }
         else{
           scorecardd.add(scorefromserver['batting'][i]);
         }

       }
       for(int i=0;i<scorefromserver['bowling'].length;i++){
         if(scorefromserver['bowling'][i]['scoreboard']=="S1"){
           bowlingscorecarda.add(scorefromserver['bowling'][i]);
         }
         else if(scorefromserver['bowling'][i]['scoreboard']=="S2"){
           bowlingscorecardb.add(scorefromserver['bowling'][i]);
         }
         else if(scorefromserver['bowling'][i]['scoreboard']=="S3"){
           bowlingscorecardc.add(scorefromserver['bowling'][i]);
         }
         else{
           bowlingscorecardd.add(scorefromserver['bowling'][i]);
         }

       }
     }
     else{
       print("jnkjnkcfff");
       for(int i=0;i<scorefromserver['batting'].length;i++){
         if(
         scorefromserver['batting'][i]['player_id']==scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_one_on_creeze_id']
         ){
           setState(() {
             print("mknao;vno");
             Striker=scorefromserver['batting'][i]["player_id"];
             Strikerballs=scorefromserver['batting'][i]["ball"];
             Strikerruns=scorefromserver['batting'][i]["score"];
             Strikersix=scorefromserver['batting'][i]["six_x"];
             Strikerfours=scorefromserver['batting'][i]["four_x"];
             Strikerrate=scorefromserver['batting'][i]["rate"];
           });
         }
         else if( scorefromserver['batting'][i]['player_id']==scorefromserver['balls'][scorefromserver['balls'].length-1]['batsman_two_on_creeze_id']){
           setState(() {
             nonstriker=scorefromserver['batting'][i]["player_id"];

             nonStrikerruns=scorefromserver['batting'][i]["score"];
             nonStrikerballs=scorefromserver['batting'][i]["ball"];
             nonStrikersix=scorefromserver['batting'][i]["six_x"];
             nonStrikerfours=scorefromserver['batting'][i]["four_x"];
             nonStrikerrate=scorefromserver['batting'][i]["rate"];
           });
         }
       }
       print("Striker"+[Striker].toString());
       print("Striker"+[nonstriker].toString());
     }

     for(int i =0;i<scorefromserver['balls'].length;i++){
       print('JJODKODKOWEKO');
       print(scorefromserver['balls'][i]['player_id']);
       if(scorefromserver['bowling'][i]['player_id']==scorefromserver['balls'][scorefromserver['balls'].length-1]['bowler']['id']){
         print('JJODKODKOWEKO');
         print("bowler"+scorefromserver['bowling'][i].toString());
         currentbowler=scorefromserver['bowling'][i];
         print("bowler"+currentbowler);
       }
       else{
         print('JKOWEKO');
       }
     }

        print("oasdvsdvo"+teams[nonstriker].toString());

        // for(int i=0;i<dishfromserver.length;i++){
        //   searcharray.add( dishfromserver[i]['name']);
        //   print(searcharray.toString());
        // }
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
         showToast(response.body);
        setState(() {
          url='https://cricket.sportmonks.com/api/v2.0/fixtures/${widget.id}?api_token=${matchkey}&include=runs,visitorteam,localteam,batting,bowling,tosswon,league,stage,lineup,firstUmpire,balls,venue,,balls.batsmanone,balls.batsmantwo';

          isError = true;
          isLoading = true;
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
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container
                            (
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage( squada[i]['image_path']),)),
                          ),
                          Container(
                            child: Text(
                              squada[i]['lineup']['captain']==true?squada[i]['fullname']+" (C) ": squada[i]['lineup']['wicketkeeper']==true?squada[i]['fullname']+" (wk) ":squada[i]['fullname'],

                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Container(
                          //   child: Text(
                          //       squada[i]['battingstyle'],
                          //     style: TextStyle(fontSize: 12),
                          //   ),
                          // ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container
                                (
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage( squadb[i]['image_path']),)),
                              ),
                              Container(
                                child: Text(
                                  squadb[i]['lineup']['captain']==true?squadb[i]['fullname']+" (c) ": squadb[i]['lineup']['wicketkeeper']==true?squadb[i]['fullname']+" (wk) ":squadb[i]['fullname'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Container(
                              //   child: Text(
                              //       squadb[i]['battingstyle'],
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
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
  List<Widget> battingorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < scorecarda.length; i++) {
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
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teams[scorecarda[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecarda[i]['score_id']]==null?"Not Out":outtypes[ scorecarda[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecarda[i]['score_id']].toString()=="Clean Bowled"?"b " +teams[scorecarda[i]['bowling_player_id']]:outtypes[ scorecarda[i]['score_id']].toString()=="LBW OUT"?"lbw "+teams[scorecarda[i]['bowling_player_id']]:outtypes[ scorecarda[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecarda[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecarda[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          "${scorecarda[i]['catch_stump_player_id']!=null? teams[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?teams[scorecarda[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecarda[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecarda[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"Not Out":
                                      teams[scorecarda[i]['runout_by_id']]!=null?"& "+teams[scorecarda[i]['runout_by_id']]:"b "+teams[scorecarda[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]["rate"]
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
                      horizontal: SizeConfig.screenWidth * 0.01,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.5,
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
    for (int i = 0; i < scorecardb.length; i++) {
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
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teams[scorecardb[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecardb[i]['score_id']]==null?"Not Out":outtypes[ scorecardb[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecardb[i]['score_id']].toString()=="Clean Bowled"?"b " +teams[scorecardb[i]['bowling_player_id']]:outtypes[ scorecardb[i]['score_id']].toString()=="LBW OUT"?"lbw "+teams[scorecardb[i]['bowling_player_id']]:outtypes[ scorecardb[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecardb[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecardb[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?"":
                                          "${scorecardb[i]['catch_stump_player_id']!=null? teams[scorecardb[i]['catch_stump_player_id']]:scorecardb[i]['runout_by_id']!=null?teams[scorecardb[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecardb[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecardb[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?"Not Out":
                                      teams[scorecardb[i]['runout_by_id']]!=null?"& "+teams[scorecardb[i]['runout_by_id']]:"b "+teams[scorecardb[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["rate"]
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
                      color: Colors.grey,
                      thickness: 1.5,
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
  List<Widget> batting3order() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < scorecardc.length; i++) {
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
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teams[scorecardc[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecardc[i]['score_id']]==null?"Not Out":outtypes[ scorecardc[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecardc[i]['score_id']].toString()=="Clean Bowled"?"b " +teams[scorecardc[i]['bowling_player_id']]:outtypes[ scorecardc[i]['score_id']].toString()=="LBW OUT"?"lbw "+teams[scorecardc[i]['bowling_player_id']]:outtypes[ scorecardc[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecardc[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecardc[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecardc[i]['bowling_player_id']==null&&scorecardc[i]['catch_stump_player_id']==null&&scorecardc[i]['runout_by_id']==null?"":
                                          "${scorecardc[i]['catch_stump_player_id']!=null? teams[scorecardc[i]['catch_stump_player_id']]:scorecardc[i]['runout_by_id']!=null?teams[scorecardc[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecardc[i]['bowling_player_id']==null&&scorecardc[i]['catch_stump_player_id']==null&&scorecardc[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecardc[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecardc[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecardc[i]['bowling_player_id']==null&&scorecardc[i]['catch_stump_player_id']==null&&scorecardc[i]['runout_by_id']==null?"Not Out":
                                      teams[scorecardc[i]['runout_by_id']]!=null?"& "+teams[scorecardc[i]['runout_by_id']]:"b "+teams[scorecardc[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecardc[i]['bowling_player_id']==null&&scorecardc[i]['catch_stump_player_id']==null&&scorecardc[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardc[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardc[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardc[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardc[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardc[i]["rate"]
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
                      horizontal: SizeConfig.screenWidth * 0.01,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.5,
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
  List<Widget> batting4ndorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < scorecardd.length; i++) {
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
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teams[scorecardd[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecardd[i]['score_id']]==null?"Not Out":outtypes[ scorecardd[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecardd[i]['score_id']].toString()=="Clean Bowled"?"b " +teams[scorecardd[i]['bowling_player_id']]:outtypes[ scorecardd[i]['score_id']].toString()=="LBW OUT"?"lbw "+teams[scorecardd[i]['bowling_player_id']]:outtypes[ scorecardd[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecardd[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecardd[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecardd[i]['bowling_player_id']==null&&scorecardd[i]['catch_stump_player_id']==null&&scorecardd[i]['runout_by_id']==null?"":
                                          "${scorecardd[i]['catch_stump_player_id']!=null? teams[scorecardd[i]['catch_stump_player_id']]:scorecardd[i]['runout_by_id']!=null?teams[scorecardd[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecardd[i]['bowling_player_id']==null&&scorecardd[i]['catch_stump_player_id']==null&&scorecardd[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecardd[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecardd[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecardd[i]['bowling_player_id']==null&&scorecardd[i]['catch_stump_player_id']==null&&scorecardd[i]['runout_by_id']==null?"Not Out":
                                      teams[scorecardd[i]['runout_by_id']]!=null?"& "+teams[scorecardd[i]['runout_by_id']]:"b "+teams[scorecardd[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecardd[i]['bowling_player_id']==null&&scorecardd[i]['catch_stump_player_id']==null&&scorecardd[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardd[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardd[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardd[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardd[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardd[i]["rate"]
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
                      color: Colors.grey,
                      thickness: 1.5,
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
  List<Widget> bowlingorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingscorecarda.length; i++) {
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
                                  teams[bowlingscorecarda[i]['player_id']]
                                  ,
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
                              bowlingscorecarda[i]['overs'].toString()
                              ,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['runs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['wickets']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['medians']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['rate']
                                  .toString(),maxLines: 1,
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
                  thickness: 1.5,
                  color: Colors.grey,
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
    for (int i = 0; i < bowlingscorecardb.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                  teams[bowlingscorecardb[i]['player_id']],
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
                              bowlingscorecardb[i]['overs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
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
                              bowlingscorecardb[i]
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
                              bowlingscorecardb[i]
                              ["medians"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
                              ["rate"]
                                  .toString(),maxLines: 1,
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
                  thickness: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }
  List<Widget> bowlingthirdorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingscorecardc.length; i++) {
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
                                  teams[bowlingscorecardc[i]['player_id']]
                                  ,
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
                              bowlingscorecardc[i]['overs'].toString()
                              ,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardc[i]['runs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardc[i]['wickets']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardc[i]['medians']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardc[i]['rate']
                                  .toString(),maxLines: 1,
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
                  thickness: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List<Widget> bowlingfourthorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingscorecardd.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                  teams[bowlingscorecardd[i]['player_id']],
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
                              bowlingscorecardd[i]['overs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardd[i]
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
                              bowlingscorecardd[i]
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
                              bowlingscorecardd[i]
                              ["medians"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardd[i]
                              ["rate"]
                                  .toString(),maxLines: 1,
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
                  thickness: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List <Widget>balls(){
    List<Widget> balllist = new List();
    for (int i = recentballs.length-1; i >= 0; i--) {
      balllist.add(Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5,),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(recentballs[i]['ball'].toString(),style: TextStyle(color: Colors.white,fontSize:12,fontWeight: FontWeight.w600),),),
                SizedBox(width: 5,),
                Text(recentballs[i]['bowler']['fullname'].toString(),style: TextStyle(fontSize:12,)),
                SizedBox(width: 5,),
                Text("to"),
                SizedBox(width: 5,),
                Text(recentballs[i]['batsman']['fullname'].toString()+" :",style: TextStyle(fontSize:12,)),
                SizedBox(width: 5,),
                Text(recentballs[i]['score']['name'].toString(),maxLines:2,style: TextStyle(fontWeight: FontWeight.w600,fontSize:12),),


              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ));
    }
    return balllist;
  }
  void getoutdate() async{
    var url="https://cricket.sportmonks.com/api/v2.0/scores?api_token=${matchkey}";
    setState(() {
      isLoading=true;
    });


    try {
      final response = await get(Uri.parse(url),headers: {


      });
      print("bjkb" + response.request.url.toString());
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        setState(() {
          scoredata=responseJson['data'];
          print("jkjklsdjk"+scoredata.toString());
        });
        List lista=[];
        for(int i=0; i<scoredata.length;i++){
          if(scoredata[i]['out']==true){
            lista.add(User('User1', 23));
            lista.forEach((user) => outtypes[scoredata[i]['id']] = scoredata[i]['name']);

          }
        }
      }}
    catch(e){

    }
  }
}

