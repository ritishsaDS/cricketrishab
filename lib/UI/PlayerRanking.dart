import 'package:cricscore_app/UI/Odiranking.dart';
import 'package:cricscore_app/UI/Testranking.dart';
import 'package:cricscore_app/UI/t20rank.dart';
import 'package:cricscore_app/Utils/Colors.dart';
import 'package:cricscore_app/Utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class PlayerRanking extends StatefulWidget{
  @override
  _PlayerRankingState createState() => _PlayerRankingState();
}

class _PlayerRankingState extends State<PlayerRanking> with TickerProviderStateMixin {
  TabController? _nestedTabController;
  bool isLoading=false;
  bool isError=false;
  var  testmatch=[];
  var  testmatchimages=[];
  var  ODI=[];
  var  ODIimage=[];
  var  T20=[];
  var t20image=[];
  final databaseReference = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    getranking();
    super.initState();
    readData();
    _nestedTabController = TabController(length: 3, vsync: this);
  }
  void readData() {
    databaseReference.get().then((DataSnapshot snapshot) {
      print('ranking : ${(snapshot.value as Map)['Womens Ranking']['OneDay']}');
      print('ranking : ${(snapshot.value as Map)['ImagesOdi']}');
      T20.add((snapshot.value as Map)['MensRanking']['T20']);
      t20image.add((snapshot.value as Map)['MensRanking']['TestImages']);
      ODI.add((snapshot.value as Map)['MensRanking']['OneDay']);
      ODIimage.add((snapshot.value as Map)['MensRanking']['TestImages']);
      testmatch.add((snapshot.value as Map)['MensRanking']['Test']);
      testmatchimages.add((snapshot.value as Map)['MensRanking']['TestImages']);

    });}

  @override
  void dispose() {
    super.dispose();
    _nestedTabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),

      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            flexibleSpace:(
                Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(

                        colors: [
                          Color(gradientColor1),
                          Color(gradientColor2).withOpacity(0.95),
                        ],  begin: Alignment(-3.0, 1.0),
                        end: Alignment.bottomRight,),
                    ))),
            iconTheme: IconThemeData(color: Colors.white),
            bottom:  TabBar(
              tabs: [
                Tab(text: "Test"),
                Tab(text: "ODI"),
                Tab(text: "T20I"),
              ],
            ),
            title: const Text('ICC Mens (Rankings)'),
          ),
          body:  Stack(
            children: [

              Container(
                child:isLoading==true?Center(child: CircularProgressIndicator(color: Colors.blue,),): TabBarView(
                  children: [
                    TestRanking(testarray:testmatch,image:testmatchimages),
                    Odiranking(testarray:ODI,image:ODIimage),
                    T20ranking(testarray:T20,image:t20image),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  dynamic scorefromserver=[];
  void getranking() async {
    // print("jkejksdjk"+selectedDate.toString());
    setState(() {
      isLoading=true;
      //  print(selectedDate.toString());
    });
    // var newDate = DateTime(selectedDate.year, selectedDate.month , selectedDate.day-2);
    //  print(newDate);
        {
      final uri = 'https://cricket.sportmonks.com/api/v2.0/team-rankings';
      var response = await Dio().get(uri,
          queryParameters:
          {'api_token': "0YNv6UUNVd04Oh2V62ah0EwD0ORYSTKMg6X8WBi3babvT53ts8dFFfVAAK4I",},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            followRedirects: false,
          ));
      try {
        if (response.data != null) {
          print(uri.toString());
          //  print(response.data['data']);
          scorefromserver=response.data['data'];
          for(int i =0; i<scorefromserver.length;i++){
            if(scorefromserver[i]['type']=="TEST"&&scorefromserver[i]['gender']=="men"){
              setState(() {
                // testmatch.add(scorefromserver[i]);
              });
              setState(() {
                isLoading=false;
              });

              // print(testmatch);
            }
            else  if(scorefromserver[i]['type']=="ODI"&&scorefromserver[i]['gender']=="men"){
              // ODI.add(scorefromserver[i]);
              setState(() {
                isLoading=false;
              });

              //print(ODI);
            }
            else if(scorefromserver[i]['type']=="T20I"&&scorefromserver[i]['gender']=="men"){
              ///T20.add(scorefromserver[i]);
              setState(() {
                isLoading=false;
              });

              // print(T20);
            }
          }
          //final passEntity = VerifyOtpModal.fromJson(response.data);

          // return passEntity;
        } else {
          // return VerifyOtpModal(meta: response.data);
        }
      } catch (error, stacktrace) {}
    }
  }

}