
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CricScore_App/Homepage.dart';
import 'package:CricScore_App/UI/MainScreen.dart';
import 'package:CricScore_App/splashscreen.dart';

import 'UI/Dashboard.dart';
import 'UI/Stopwatch.dart';
import 'UI/testingadd.dart';
import 'Utils/Colors.dart';
import 'animation_screen.dart';

import 'package:in_app_update/in_app_update.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fcmtoken;
  FirebaseMessaging messaging;
  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        print("fcm" + value);
        fcmtoken = value;
        // _getId();
      } );    super.initState();
  });
    checkForUpdate();
  }
  Future<void> checkForUpdate() async {
    print("Check Update");
    InAppUpdate.checkForUpdate().then((info) {
      print("Check Update");
      setState(() {
        _updateInfo = info;
        print("Check Update"+_updateInfo.flexibleUpdateAllowed.toString());
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(

          body: Stack(
              children: <Widget>[
                Scaffold(

                    body: Splash()
                ),

              ]
          ),
        )
    );
  }
}