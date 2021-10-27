import 'dart:async';
import 'dart:convert';

import 'package:countdown_timer_simple/countdown_timer_simple.dart';
import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/Quizmain.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';

import 'package:http/http.dart';
class Quizmatches extends StatefulWidget{
  @override
  _QuizmatchesState createState() => _QuizmatchesState();
}

class _QuizmatchesState extends State<Quizmatches> with SingleTickerProviderStateMixin{
  bool  isLoading = true;
  bool isError=true;
  AnimationController _controller;
  var countdownDuration;
  Duration duration = Duration();
  Timer timer;
  String twoDigits(int n) => n.toString().padLeft(2,'0');
  var hours  ;
  var minutes;
  var seconds;
  bool countDown =true;
  var currentTime = DateTime.now();
  var diff ;
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    getQuizMatches();
     hours =twoDigits(duration.inHours);
     minutes =twoDigits(duration.inMinutes.remainder(60));
     seconds =twoDigits(duration.inSeconds.remainder(60));



    reset();
    startTimer();
    //minutesToTimeOfDay();
    // TODO: implement initState
    super.initState();
  }TimeOfDay minutesToTimeOfDay(int minutes) {
    Duration duration = Duration(minutes: 1123);
    List<String> parts = duration.toString().split(':');
    print(TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])));
    print("TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]))");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  void reset(){
    if (countDown){
      setState(() =>
      duration = countdownDuration);
    } else{
      setState(() =>
      duration = Duration());
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);

      }
    });
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer?.cancel());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        title:Text( "Quiz Matches"),
      centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            //unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text:('Upcoming'),
              ),
              Tab(
                text:('Completed'),
              ),
              // Tab(
              //   text:('Live'),
              // ),

            ]),
      ),
      body:  TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
        child: Container(
          //margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,),
          child: ListView(children:
            getquizMtcheswidget()
          ,),
        ),
      ),
            Container(
              child: Container(
                //margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,),
                child: ListView(children:
                getCompletedMtcheswidget()
                  ,),
              ),
            ),

    ]));
  }
  dynamic matches=[];
  dynamic Upcomingmatches=[];
  dynamic Completedmatches=[];
  Future<void> getQuizMatches() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await get(Uri.parse(
          'http://18.216.40.7/api/getquizmatches'),

         );
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        matches=responseJson;
        print(matches);
        for(int i=0; i<matches.length;i++){
          if(DateTime.parse(matches[i]["date"]).difference(currentTime).inMinutes >0){
Upcomingmatches.add(matches[i]);

          }
          else{
            Completedmatches.add(matches[i]);
          }
        }
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

  List<Widget>getquizMtcheswidget(){
    List<Widget>matchwidget=new List();
    for(int i=0;i<Upcomingmatches.length;i++){
     diff= DateTime.parse(Upcomingmatches[i]["date"]).difference(currentTime).inMinutes;
     print(diff);

     countdownDuration = Duration(minutes: diff);
      matchwidget.add(GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizmain(id:matches[i]['match_key'])));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Upcomingmatches[i]['league_name']+" , "+Upcomingmatches[i]['round'],
                        style: TextStyle(fontSize: 12),
                      ),
                      //Expanded(child: SizedBox()),
                      //Expanded(child: SizedBox()),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(
                              Upcomingmatches[i]['teama_logo'],

                      ),)),),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Upcomingmatches[i]['team_a'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox()),
                      // Text(
                      //   DateTime.parse(matches[i]["date"]).toLocal().toString().substring(10,16),
                      // ),
                      //buildTime(),
                    ]
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(
                              Upcomingmatches[i]['teamb_logo'],

                        ),)),),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Upcomingmatches[i]['team_b'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox()),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text("Finishes in: "),
                      CountdownTimerSimple(
                          textStyle: TextStyle(color: Colors.red,fontSize: 14),
                          endTime: DateTime.now().millisecondsSinceEpoch + 1000 *60*diff ,

                          onEnd: () {

                            // print(endTime+"Your time is up!");
                          }
                      ),
Expanded(child: SizedBox()),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.black),
                              color: Color(0XffFFD700)
                          ),
                          child: Text("Play Now",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),)),
                    ],
                  ),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Eden Gardens",
                  //       style: TextStyle(fontSize: 12),
                  //       maxLines: 2,
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //     Icon(
                  //       Icons.notifications_active,
                  //       color: Color(lightBlue),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),);
    }
    return matchwidget;
  }
  List<Widget>getCompletedMtcheswidget(){
    List<Widget>matchwidget=new List();
    for(int i=0;i<Completedmatches.length;i++){


      matchwidget.add(GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizmain(id:Completedmatches[i]['match_key'])));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Completedmatches[i]['league_name']+" , "+Completedmatches[i]['round'],
                        style: TextStyle(fontSize: 12),
                      ),
                      //Expanded(child: SizedBox()),
                      //Expanded(child: SizedBox()),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Finished "),

                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(
                                Completedmatches[i]['teama_logo'],

                              ),)),),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Completedmatches[i]['team_a'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                        // Text(
                        //   DateTime.parse(matches[i]["date"]).toLocal().toString().substring(10,16),
                        // ),
                        //buildTime(),
                      ]
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(
                              Completedmatches[i]['teamb_logo'],

                            ),)),),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Completedmatches[i]['team_b'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox()),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //
                      //         padding: EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.0),
                      //             border: Border.all(color: Colors.black),
                      //             color: Color(0XffFFD700)
                      //         ),
                      //         child: Text("Play Now",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),)),
                      //   ],
                      // ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Eden Gardens",
                  //       style: TextStyle(fontSize: 12),
                  //       maxLines: 2,
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //     Icon(
                  //       Icons.notifications_active,
                  //       color: Color(lightBlue),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),);
    }
    return matchwidget;
  }
  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours =twoDigits(duration.inHours);
    final minutes =twoDigits(duration.inMinutes.remainder(60));
    final seconds =twoDigits(duration.inSeconds.remainder(60));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimeCard(time: hours, header:'HOURS'),
          SizedBox(width: 8,),
          buildTimeCard(time: minutes, header:'MINUTES'),
          SizedBox(width: 8,),
          buildTimeCard(time: seconds, header:'SECONDS'),
        ]
    );
  }
  Widget buildTimeCard({@required String time, @required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Text(
              time, style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black,fontSize: 20),),
          ),
          SizedBox(height: 5,),
          Text(header,style: TextStyle(color: Colors.black45)),
        ],
      );
}class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes.remainder(60).toString()}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
