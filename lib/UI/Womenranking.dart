import 'package:CricScore_App/UI/Odiranking.dart';
import 'package:CricScore_App/UI/Testranking.dart';
import 'package:CricScore_App/UI/t20rank.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'Notlivematch.dart';
class Womenranking extends StatefulWidget {

  @override
  _WomenrankingState createState() => _WomenrankingState();
}

class _WomenrankingState extends State<Womenranking>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  bool isLoading=false;
  bool isError=false;

  var  testmatch=[];
  var  testmatchimages=[];
  var  ODI=[];
  var  ODIimage=[];
  var  T20=[];
  var t20image=[];
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    getranking();
    readData();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }
  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('ranking : ${snapshot.value['Mens20']}');
      print('ranking : ${snapshot.value['ImagesOdi']}');
      T20.add(snapshot.value['Womens20']);
      t20image.add(snapshot.value['Womens20images']);
      ODI.add(snapshot.value['Womensodi']);
      ODIimage.add(snapshot.value['womensOdi']);


    });}

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
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
        length: 2,
        child: Scaffold(

          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            bottom:  TabBar(
              tabs: [
               // Tab(text: "Test"),
                Tab(text: "ODI"),
                Tab(text: "T20I"),
              ],
            ),
            title: const Text('Womens (Rankings)'),
          ),
          body:   Stack(
            children: [

              Container(
                child:isLoading==true?Center(child: CircularProgressIndicator(color: Colors.blue,),): TabBarView(
                  children: [
                   //TestRanking(testarray: testmatch,),
                    Odiranking(testarray: ODI,image: ODIimage,),
                    T20ranking(testarray: T20,image: t20image,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  dynamic scorefromserver=new List();
  void getranking() async {
    // print("jkejksdjk"+selectedDate.toString());
    setState(() {
      isLoading=true;
      //  print(selectedDate.toString());
    });
    // var newDate = new DateTime(selectedDate.year, selectedDate.month , selectedDate.day-2);
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
            if(scorefromserver[i]['type']=="TEST"&&scorefromserver[i]['gender']=="women"){
              setState(() {
                //testmatch.add(scorefromserver[i]);
              });
              setState(() {
                isLoading=false;
              });
            }
            else  if(scorefromserver[i]['type']=="ODI"&&scorefromserver[i]['gender']=="women"){
             // ODI.add(scorefromserver[i]);
              print(ODI);
              setState(() {
                isLoading=false;
              });
            }
            else if(scorefromserver[i]['type']=="T20I"&&scorefromserver[i]['gender']=="women"){
            //  T20.add(scorefromserver[i]);
              print(T20);
              setState(() {
                isLoading=false;
              });
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