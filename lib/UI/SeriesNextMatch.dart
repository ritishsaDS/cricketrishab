import 'dart:convert';

import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SeriesNextmatch extends StatefulWidget{
  dynamic id;
  SeriesNextmatch({this.id});
  @override
  _SeriesNextmatchState createState() => _SeriesNextmatchState();
}

class _SeriesNextmatchState extends State<SeriesNextmatch> {
bool isError = false;
bool isLoading = false;
  @override
  void initState() {
    getnextmatch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: SafeArea(
       child: ListView(children: getEvetnts(),),
     ),
   );
  }
  dynamic scorefromserver = new List();
  Future<void> getnextmatch() async {
    try {
      final response = await post(Uri.parse('http://13.127.190.65/api2/seriesMatches/0eeff2137825825ce7cfab876acc7c47?series_id=${widget.id}'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        scorefromserver = responseJson['data'];

        print(scorefromserver);

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

      },
      child: Container(
        padding: EdgeInsets.all(10),
       // alignment: Alignment.center,
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.26,
        margin: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Event Starts :   "+scorefromserver[i]["date_wise"], style: TextStyle(
                color: Colors.white,
                fontSize:
                SizeConfig.blockSizeVertical * 1.50,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(


                     children: [

                       Container(

                         child:CircleAvatar(
                             radius: 40.0,
                             backgroundColor: Colors.transparent,
                             backgroundImage: NetworkImage(scorefromserver[i]["team_a_img"]==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGs1ELfuOS4lslVPFDcxL2cU_8OZ9yrMPHJw&usqp=CAU':scorefromserver[i]["team_a_img"],)
                         ),
                       ),
                       SizedBox(width: 20,),
                       Container(
                         width: SizeConfig.screenWidth*0.30,
                         child: Text(
                           scorefromserver[i]["team_a"],maxLines: 2,textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.white,
                               fontSize:
                               SizeConfig.blockSizeVertical * 2,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     ],
                   ),
                   Container(
                       alignment: Alignment.center,

                       child:Column(
                         children: [
                           CircleAvatar(
                             radius: 25.0,
                             child: Text("VS" ,style: TextStyle(

                                 fontSize:
                                 SizeConfig.blockSizeVertical * 2,
                                 fontWeight: FontWeight.bold),),
                             backgroundColor: Colors.white,
                           ),
                           SizedBox(height: 5,),
                           Text(scorefromserver[i]['matchs'],style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                         ],
                       )
                   ),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment
                         .center,
                     children: [
                       Container(
                         child:  CircleAvatar(
                           radius: 40.0,
                           backgroundColor: Colors.transparent,
                           backgroundImage: NetworkImage(scorefromserver[i]["team_b_img"]==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGs1ELfuOS4lslVPFDcxL2cU_8OZ9yrMPHJw&usqp=CAU':scorefromserver[i]["team_b_img"],),
                         ),
                       ),

                       SizedBox(width: 20,),
                       Container(
                         width: SizeConfig.screenWidth*0.30,
                         child: Text(
                           scorefromserver[i]["team_b"],textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.white,
                               fontSize:
                               SizeConfig.blockSizeVertical * 2,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),





          ],
        ),
      ),
    ),);
  }
  return productList;
}
  }

