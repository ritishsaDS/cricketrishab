import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cricscore_app/UI/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/Dashboard.dart';
import 'Utils/Colors.dart';

class Splash extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<Splash> {
  final databaseReference = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
    readData();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,

        child:Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.45,),
            Center(child: Image.asset("assets/icons/cricscorelogo.png",scale: 5,)),
          ],
        )
    );
  }
  Future<void> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    databaseReference.get().then((DataSnapshot snapshot) {

      setState(() {
        matchkey=(snapshot.value as Map)['Matchkeys']['Matachapikey'];
        fbbannerid=(snapshot.value as Map)['Matchkeys']['fb_bannerkey'];
        fbinterstetialid=(snapshot.value as Map)['Matchkeys']['fb_interstitialkey'];
        print('matchkey : ${matchkey}');
      });
      Timer(Duration(seconds: 1),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  MainScreen()
              )
          )
      );
      //  print('ranking : ${snapshot.value['ImagesOdi']}');


    });}
}
