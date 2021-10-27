import 'dart:async';
import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/MainScreen.dart';

import 'UI/Dashboard.dart';

class Splash extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                MainScreen()
            )
        )
    );
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
}
