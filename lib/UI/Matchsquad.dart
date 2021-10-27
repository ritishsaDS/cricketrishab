import 'package:flutter/material.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';

import 'Playerdetail.dart';
class Matchsquad extends StatefulWidget{
  dynamic firstteam;
  dynamic secondteam;
  dynamic firstsquad;
  dynamic secondsquad;
  dynamic match;
  Matchsquad({this.match,this.firstsquad,this.firstteam,this.secondsquad,this.secondteam});
  @override
  _MatchsquadState createState() => _MatchsquadState();
}

class _MatchsquadState extends State<Matchsquad>   with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

         
            body: Column(
              children: [


                Container(
                  margin: EdgeInsets.all(10),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: Color(lightBlue),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: widget.firstteam,
                      ),

                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: widget.secondteam,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                  children: [
                    Container(
                      child: Column(
                        children: [
SizedBox(height: 10,),
                          Container(
                            height: SizeConfig.screenHeight*0.75,
                            child: ListView(
                              children:squadwidget() ,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),

                          Container(
                            height: SizeConfig.screenHeight*0.75,
                            child: ListView(
                              children:squadwidgetb() ,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          
          );
  }
  List<Widget> squadwidget() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < widget.firstsquad.length; i++) {
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
                              widget.firstsquad[i]['lineup']['captain']==true?widget.firstsquad[i]['fullname']+" (C) ": widget.firstsquad[i]['lineup']['wicketkeeper']==true?widget.firstsquad[i]['fullname']+" (wk) ":widget.firstsquad[i]['fullname'],

                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container
                            (
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage( widget.firstsquad[i]['image_path']),)),
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
    for (int i = 0; i < widget.secondsquad.length; i++) {
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
                                  widget.secondsquad[i]['lineup']['captain']==true?widget.secondsquad[i]['fullname']+" (c) ": widget.secondsquad[i]['lineup']['wicketkeeper']==true?widget.secondsquad[i]['fullname']+" (wk) ":widget.secondsquad[i]['fullname'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container
                                (
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage( widget.secondsquad[i]['image_path']),)),
                              ),


                              // Container(
                              //   child: Text(
                              //       widget.secondsquad[i]['battingstyle'],
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
}