import 'dart:convert';

import 'package:CricScore_App/UI/Notlivematch.dart';
import 'package:CricScore_App/UI/Oneday.dart';
import 'package:CricScore_App/UI/T20.dart';
import 'package:CricScore_App/UI/recenttabscorecard.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Livematches.dart';
import 'Upcomingmatches.dart';

class Recenttab extends StatefulWidget {
  @override
  _RecenttabState createState() => _RecenttabState();
}

class _RecenttabState extends State<Recenttab> {
  bool isError = false;
  bool isLoading = false;
  var pastmatches = [];
  var selectedDate;
  var selectedmonth;
  var selectedyear;
  var selectedday;
  @override
  void initState() {
    selectedDate = DateTime.now();

    getmatches();
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


            backgroundColor: Color(lightBlue),

            iconTheme: IconThemeData(color: Colors.white),
            bottom:  TabBar(
indicatorColor: Colors.white,
              indicatorWeight: 4,
              tabs: [
                Tab(child: Text("T20",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                Tab(child:Text("ODI",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                Tab(child:Text("TEST",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
              ],
            ),

          ),
          body:  TabBarView(
            children: [
              NestedTabBar(),
              Livematch(),
              Oneday()
            ],
          ),
        ),
      ),
    );

  }

  dynamic mathesfromserver = new List();
  void getmatches() async {
    setState(() {
      isLoading = true;
    });

    var newDate = new DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day - 2);
    print(newDate);
    try {
      final response = await http.post(Uri.parse(
          'http://13.127.190.65/api2/completeMatches/0eeff2137825825ce7cfab876acc7c47'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        pastmatches = responseJson['data'];

        print(pastmatches);

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

  List<Widget> getEvetnts() {
    List<Widget> productList = new List();
    for (int i = 0; i < pastmatches.length; i++) {
      productList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Recenttabscorecard(
                        id: pastmatches[i]["match_id"],
                        teama: pastmatches[i]['team_a_short'],
                        teamb: pastmatches[i]['team_b_short'],
                        date: pastmatches[i]['match_date'])));
          },
          child: Container(
            alignment: Alignment.center,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.27,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(gradientColor1),
                    Color(gradientColor2).withOpacity(0.95),
                  ],
                  begin: Alignment(1.0, -3.0),
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20)),
            // margin: EdgeInsets.all( 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pastmatches[i]['series'] + ",  " + pastmatches[i]['matchs'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 1.75,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  pastmatches[i]['match_time'] +
                      ",  " +
                      pastmatches[i]['match_date'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 1.50,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    NetworkImage(pastmatches[i]["team_a_img"]),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pastmatches[i]['team_a_short'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 2.12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              pastmatches[i]['team_a_over'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.15,
                              child: Text(
                                pastmatches[i]['team_a_scores'],
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 25.0,
                          child: Text(
                            "VS",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white,
                        )),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pastmatches[i]["team_b_short"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 2.12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              pastmatches[i]["team_b_over"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.15,
                              child: Text(
                                pastmatches[i]["team_b_scores"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   pastmatches[i]["team_b"],
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize:
                            //       SizeConfig.blockSizeVertical * 1.25,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            Container(
                              // width: 70,
                              // height: 80,
                              // decoration: new BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     image: new DecorationImage(
                              //         fit: BoxFit.fill,
                              //         image: new NetworkImage(pastmatches[i]["team_b_img"]==null?"www.google.png":pastmatches[i]["team_b_img"]
                              //
                              //         ))),
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    NetworkImage(pastmatches[i]["team_b_img"]),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  pastmatches[i]["result"],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      );
    }
    return productList;
  }
}
