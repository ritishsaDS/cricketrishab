import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';

class Privacy extends StatefulWidget{
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool isError = false;
 bool isLoading = false;
  @override
  void initState() {
    getPrivacy();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text(
          "Privacy - Policy",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Image.asset(
        //     'assets/icons/back.png',
        //     scale: SizeConfig.blockSizeVertical * 0.5,
        //   ),
        // ),
        elevation: 0.0,
        // actions: [
        //   Container(
        //     margin: EdgeInsets.all(8),
        //     child: CircleAvatar(
        //       minRadius: SizeConfig.blockSizeVertical * 2.5,
        //       backgroundImage: AssetImage('assets/bg/profile.jpg'),
        //     ),
        //   ),
        // ],
      ),
body:
  Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.02,
          vertical: SizeConfig.blockSizeVertical),
      child: ListView(children: newswidget())


  ),

    );

  }
  dynamic newsfromserver = new List();
  void getPrivacy() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await get(Uri.parse(
          'http://18.216.40.7/api/get-privacy'));

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        newsfromserver = responseJson['privacy'];

        print(newsfromserver);

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {

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
  List<Widget> newswidget() {
    List<Widget> productList = new List();
    for (int i = 0; i < newsfromserver.length; i++) {
      productList.add(
        Container(
          //height: SizeConfig.blockSizeVertical * 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(5),

                child: Html(
                 data: newsfromserver[i]['privacy'],

                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "${newsfromserver[i]['termscondition']}",textAlign: TextAlign.start,),
              )
            ],
          ),
        ),
      );
    }
    return productList;
  }
}