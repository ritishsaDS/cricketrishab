import 'dart:convert';

import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Notlivematch.dart';

class SearchMatch extends StatefulWidget {
  const SearchMatch({Key key}) : super(key: key);

  @override
  _SearchMatchState createState() => _SearchMatchState();
}

class _SearchMatchState extends State<SearchMatch> {
  DateTime selectedDate;
bool isLoading=false;
bool isError=false;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now();
    getmatches(selectedDate);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
           Navigator.pop(context);
          },
          child: Image.asset('assets/icons/back.png',
            scale: SizeConfig.blockSizeVertical * 0.5,),
        ),
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: CircleAvatar(
              minRadius: SizeConfig.blockSizeVertical * 2.5,
              backgroundImage: AssetImage('assets/bg/profile.jpg'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarDatePicker(initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2050),
                onDateChanged: (date){
              setState(() {
                selectedDate = date;
                print(selectedDate);
                getmatches(selectedDate);
              });
                }),
           Container(height:SizeConfig.screenHeight*0.5,child: ListView(children: getEvetnts(),),)
          ],
        ),
      ),
    ));
  }
  dynamic scorefromserver=new List();
  void getmatches(date) async {
    print("jkejksdjk"+selectedDate.toString());
    setState(() {
      isLoading=true;
      print(selectedDate.toString());
    });
    var newDate = new DateTime(selectedDate.year, selectedDate.month , selectedDate.day-2);
    print(newDate);
    try {
      final response = await http.post(Uri.parse('https://api.api-cricket.com/cricket/?method=get_events&APIkey=0c0684c94f7a4e8c1149da662d4c41eca9e253d3247e0cd8ffd6c8b1da6c7c8d&date_start=${newDate.toString().substring(0,10)}&date_stop=${selectedDate.toString().substring(0,10)}'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

       setState(() {
         scorefromserver = responseJson['result'];

         print("jksdkjb"+scorefromserver.toString());

       });
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        // for(int i=0;i<dishfromserver.length;i++){
        //   searcharray.add( dishfromserver[i]['name']);
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
    for(int i= 0; i<scorefromserver.length;i++){
      productList.add( GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotLivematch(
            // hometeamscore:scorefromserver[i]['event_home_final_result'],
            // hometeamrr:scorefromserver[i]['event_home_rr'],
            // hometeamname:  scorefromserver[i]["event_home_team"],
            // hometeamsimage:scorefromserver[i]["event_home_team_logo"],
            // awayteamscore : scorefromserver[i]["event_away_final_result"],
            // awayteamrr:scorefromserver[i]['event_away_rr'],
            // awayteamimage:scorefromserver[i]["event_away_team_logo"],
            // awayteamname: scorefromserver[i]["event_away_team"],
            // event_status:scorefromserver[i]["event_status"],
            // league_name:scorefromserver[i]["league_name"],
            // league_key:scorefromserver[i]["league_key"],
            // event_status_info:scorefromserver[i]["event_status_info"],
          )));
        },
        child:  Center(
          child: Container(
            alignment: Alignment.center,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.25,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 15),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(

                  children: [
                    Row(

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Text(
                              scorefromserver[i]["event_home_team"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle),
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenHeight * 0.1,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:Image.network(scorefromserver[i]["event_home_team_logo"]==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGs1ELfuOS4lslVPFDcxL2cU_8OZ9yrMPHJw&usqp=CAU':scorefromserver[i]["event_home_team_logo"],)

                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [

                            Text(
                              scorefromserver[i]['event_home_final_result'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Overs",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.50,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              scorefromserver[i]['event_home_rr'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 5,
                      ),
                      child: Text(
                        "Vs.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [

                            Text(
                              scorefromserver[i]["event_away_final_result"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Overs",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.50,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              scorefromserver[i]["event_away_rr"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Text(
                              scorefromserver[i]["event_away_team"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle),
                              // width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenHeight * 0.1,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(scorefromserver[i]["event_away_team_logo"]==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGs1ELfuOS4lslVPFDcxL2cU_8OZ9yrMPHJw&usqp=CAU':scorefromserver[i]["event_away_team_logo"],),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),

                  ],
                ),
                // Text(scorefromserver[i]["event_status_info"],style: TextStyle(
                //     color: Colors.white,
                //     fontSize:
                //     SizeConfig.blockSizeVertical * 1.25,
                //     fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      ),);
    }
    return productList;
  }
}
