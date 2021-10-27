import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
class playerdetail extends StatefulWidget{
  var tournamentkey;
  var playerkey;
  playerdetail({this.playerkey,this.tournamentkey});
  @override
  _playerdetailState createState() => _playerdetailState();
}

class _playerdetailState extends State<playerdetail> {
  bool isLoading=false;
  @override
  void initState() {
getplayerstats();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(playerdetail['stats']['player']['name']),centerTitle: true,),
      body: Container(

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth,
              child: Text("PERSONAL INFO."),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name"),
                  Text(playerdetail['stats']['player']['name']),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Birth Palace"),
                  Text(playerdetail['stats']['player']['nationality']['name']),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Role"),
                  Text(playerdetail['stats']['player']['seasonal_role']),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Batting Style"),
                  Text(playerdetail['stats']['player']['batting_style']),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Born"),
                  Text("${playerdetail['stats']['player']['date_of_birth']}"),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth,
              child: Text("Tournament Stats"),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth,
              child: Text("Batting"),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Total Matches Played"),
                  Text(playerdetail['stats']['batting']['matches'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),

            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Runs"),
                  Text(playerdetail['stats']['batting']['runs'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Best"),
                  Text(playerdetail['stats']['batting']['best']["runs"].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Strike Rate"),
                  Text(playerdetail['stats']['batting']['best']['strike_rate'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10),
              width: SizeConfig.screenWidth,
              child: Text("Bowling"),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Total Matches Played"),
                  Text(playerdetail['stats']['bowling']['matches'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),

            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Wickets"),
                  Text(playerdetail['stats']['bowling']['wickets'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Best"),
                  Text(playerdetail['stats']['bowling']['wickets'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Strike Rate"),
                  Text(playerdetail['stats']['bowling']['economy'].toString()),
                ],
              ),
            ),
            Divider(thickness: 1.5,),

          ],
      ),
        ),),
    );
  }
dynamic playerdetail = new List();
  Future<void> getplayerstats() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await get(
          Uri.parse(
              'https://api.sports.roanuz.com/v5/cricket/RS_P_1415363533180375074/tournament/${widget.tournamentkey}/player/${widget.playerkey}/stats/'),
          headers: {"rs-token": prefs.getString("token")});
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
       setState(() {
         playerdetail=responseJson['data'];
         print(playerdetail);
       });
      }
    }
    catch(e){

    }
  }
}