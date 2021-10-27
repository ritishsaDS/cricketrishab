import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/UI/AllMAtches.dart';
import 'package:CricScore_App/UI/BlogList.dart';
import 'package:CricScore_App/UI/Dashboard.dart';
import 'package:CricScore_App/UI/Profile.dart';
import 'package:CricScore_App/UI/Quizmain.dart';
import 'package:CricScore_App/UI/Team.dart';
import 'package:CricScore_App/UI/quizdialog.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Demotab.dart';
import 'More.dart';
import 'QUizScreen.dart';
import 'Quizmatches.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  GoogleSignInAccount _userObj;
  bool isLoggedIn = false;
  var name;
  var profileData;
  Map userfb = {};
  //var facebookLogin = FacebookLogin();
  int _radioValue = 1;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<Widget> widgetOptions = <Widget>[
    Dashboard(),
    Locationstat(),

   Quizscreen(),
    BlogList(),
    Morescreen(),

   // Profile(),
  ];

  int currentIndex = 0;
  @override
  void initState() {
    readData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(25),
        ),

        child: BottomNavigationBar(

          backgroundColor: Colors.grey[200],
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          showUnselectedLabels: true,
          elevation: 0.0,
          currentIndex: currentIndex,
         type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(Image.asset('assets/icons/home.png').image),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(Image.asset('assets/icons/matches.png').image),
              title: Text(
                "Matches",
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(Image.asset('assets/icons/win.png').image),
              title: Text(
                "Quiz",
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(Image.asset('assets/icons/blogs.png').image),
              title: Text(
                "News",
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(Image.asset('assets/icons/more.png').image),
              title: Text(
                "More",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],

        ),
      ),
      body: widgetOptions.elementAt(currentIndex),
    ));
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog<String>(
      context: context,

      builder: (BuildContext context) => new AlertDialog(

        content: Container(
          height: SizeConfig.screenHeight*0.15,
          child: Column(
            children: [
              ElevatedButton(
                child: Row(
                  children: [
                    Image.asset("assets/icons/facebook.png",scale: 22,),
                    Text(' Login with Facebook'),
                  ],
                ),
                onPressed: () {
                  initiateFacebookLogin();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0XFF3B5998),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Row(
                  children: [
                    Image.asset('assets/icons/google-plus.png',scale: 4,),
                    Text(' Login with Google'),
                  ],
                ),
                onPressed: () {

                  googlelogin();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0XFFDD4B39),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),

      ),
    );

  }
  Future<void> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
setState(() {
 name= prefs.getString("name");

});    print(";jnk;jnkasdv;jnko");
    databaseReference.once().then((DataSnapshot snapshot) {
      print('ranking : ${snapshot.value}');
    //  print('ranking : ${snapshot.value['ImagesOdi']}');


    });}
  googlelogin() {
    var data;
    print("jejk");
    _googleSignIn.signIn().then((userData) {
      setState(() async {
        //_isLoggedIn = true;
        _userObj = userData;
        print("jejjjnkjnkek"+_userObj.toString());
        print(_userObj.displayName);
        print(_userObj.id);
        print(_userObj.photoUrl);
        print(_userObj.email);
        print(_userObj.authHeaders);
        if (_userObj.displayName != null) {
          // //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpCook(
          //     name:_userObj.displayName,
          //     email:_userObj.email
          // )));
          data={
            "email": _userObj.email,
            'name':_userObj.displayName,

            'image':_userObj.photoUrl,
            "phone":null,
            "provider_id":_userObj.id,

            "provider":"Google"
          };
          try {
            final response = await post(Uri.parse("http://18.216.40.7/api/userlogin"),
                headers: {
                  "Accept":"application/json"
                },
                body: {"email": _userObj.email,
                  'name': _userObj.displayName,

                  'image': _userObj.photoUrl,
                  "phone": "99449",
                  "provider_id": _userObj.id,

                  "provider": "Google"}
            );
            print("bjkb" + response.statusCode.toString());
            print("bjkb" + json.encode(data).toString());
            if (response.statusCode == 200) {
              final responseJson = json.decode(response.body);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("name", responseJson['user']['name']);
              prefs.setString("email", responseJson['user']['email']);
              prefs.setString("image", responseJson['user']['image']);

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizscreen()));

              setState(() {


                print('setstate');
              });
            } else {
              print("bjkb" + response.statusCode.toString());

              setState(() {

              });
            }
          } catch (e) {
            print(e);
            setState(() {

            });
          }
          // signup(_userObj.displayName, _userObj.email,
          //     "google");
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error"+facebookLoginResult.errorMessage);
        //onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await get(
            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token='
                '${facebookLoginResult.accessToken.token}'
            ));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        //  onLoginStatusChanged(true, profileData: profile);
        break;
        // onLoginStatusChanged(true);
        break;
    }
  }


}
