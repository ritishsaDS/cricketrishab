import 'dart:convert';

import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Recenttabscorecard extends StatefulWidget{
  dynamic id;
  dynamic teama;
  dynamic teamb;
  dynamic date;
  Recenttabscorecard({this.id,this.teama,this.teamb,this.date});
  @override
  _RecenttabscorecardState createState() => _RecenttabscorecardState();
}

class _RecenttabscorecardState extends State<Recenttabscorecard> {
 bool isError = true;
 bool isLoading = false;
 @override
  void initState() {
   getmatches();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
           Container(child:  isLoading==true ? Container(child: Center(child: CircularProgressIndicator()),)
           :
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 width: SizeConfig.screenWidth,
                 height: SizeConfig.screenHeight * 0.25,

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
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.only(
                               bottomLeft: Radius.circular(150),
                               bottomRight: Radius.circular(150))),
                       width: SizeConfig.screenWidth * 0.25,
                       height: SizeConfig.blockSizeVertical * 3,
                       alignment: Alignment.center,
                       child: Text(
                         widget.date,
                         style: TextStyle(
                             color: Color(0XFFDD2727),
                             fontWeight: FontWeight.w600),
                       ),
                     ),
                     Container(
                       width: SizeConfig.screenWidth,
                       margin: EdgeInsets.only(
                           top: SizeConfig.blockSizeVertical * 1.5),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                     shape: BoxShape.rectangle),
                                 width: SizeConfig.screenWidth * 0.2,
                                 height: SizeConfig.screenHeight * 0.1,
                                 margin: EdgeInsets.only(
                                   top: SizeConfig.blockSizeVertical * 4,
                                 ),
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(15),
                                   child: Image.network(pastmatches['scorecard']["1"]["team"]['flag']),
                                 ),
                               ),
                               SizedBox(
                                 width: SizeConfig.blockSizeHorizontal * 2,
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     height: SizeConfig.blockSizeVertical * 4,
                                   ),
                                   Text(
                                     widget.teama,
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 1.50,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(
                                     height: SizeConfig.blockSizeVertical,
                                   ),
                                   Text(
                                     pastmatches['scorecard']["1"]["team"]['score'].toString()+"/"+pastmatches['scorecard']["1"]["team"]['wicket'].toString(),
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 1.80,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(height: 5,),
                                   Text(
                                     "Overs "+pastmatches['scorecard']["1"]["team"]['over'].toString(),
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 2,
                                         fontWeight: FontWeight.bold),
                                   ),

                                 ],
                               ),
                             ],
                           ),
                           Container(
                             alignment: Alignment.center,
                             margin: EdgeInsets.only(
                                 left: SizeConfig.blockSizeHorizontal * 4,
                                 right: SizeConfig.blockSizeHorizontal * 4,
                                 top: SizeConfig.blockSizeVertical * 3),
                             child: Text(
                               "Vs.",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                           Row(
                             children: [
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     height: SizeConfig.blockSizeVertical * 4,
                                   ),
                                   Text(
                                     widget.teamb,
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 1.50,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(
                                     height: SizeConfig.blockSizeVertical,
                                   ),
                                   Text(
                                     pastmatches['scorecard']["2"]["team"]['score'].toString()+"/"+pastmatches['scorecard']["2"]["team"]['wicket'].toString(),
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 1.80,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(height: 5,),
                                   Text(
                                     "Overs"+pastmatches['scorecard']["2"]["team"]['over'].toString(),
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize:
                                         SizeConfig.blockSizeVertical * 2,
                                         fontWeight: FontWeight.bold),
                                   ),

                                 ],
                               ),

                               Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                     shape: BoxShape.rectangle),
                                 width: SizeConfig.screenWidth * 0.185,
                                 height: SizeConfig.screenHeight * 0.1,
                                 margin: EdgeInsets.only(
                                   top: SizeConfig.blockSizeVertical * 4,
                                 ),
                                 child: ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child: Image.network(pastmatches['scorecard']["2"]["team"]['flag'],)
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Text(pastmatches['result'], style: TextStyle(
                         color: Colors.white,
                         fontSize:
                         SizeConfig.blockSizeVertical * 2.5,
                         fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),

               Container(
                 width: SizeConfig.screenWidth,
                 margin: EdgeInsets.symmetric(
                     horizontal: SizeConfig.screenWidth * 0.05,
                     vertical: SizeConfig.blockSizeVertical
                 ),
                 decoration: BoxDecoration(
                     color: Color(lightBlue),
                     borderRadius: BorderRadius.circular(15)
                 ),
                 child: Theme(
                   data: Theme.of(context).copyWith(
                       dividerColor: Colors.transparent
                   ),
                   child: ExpansionTile(title: Text(pastmatches['scorecard']["1"]["team"]['name'],
                     style: TextStyle(
                       color: Colors.white,
                     ),),
                     backgroundColor: Color(lightBlue),
                     iconColor: Colors.white,
                     collapsedIconColor: Colors.white,
                     children:getEvetnts(),),
                 ),
               ),
               Container(
                 width: SizeConfig.screenWidth,
                 margin: EdgeInsets.symmetric(
                     horizontal: SizeConfig.screenWidth * 0.05,
                     vertical: SizeConfig.blockSizeVertical
                 ),
                 decoration: BoxDecoration(
                     color: Color(lightBlue),
                     borderRadius: BorderRadius.circular(15)
                 ),
                 child: Theme(
                   data: Theme.of(context).copyWith(
                       dividerColor: Colors.transparent
                   ),
                   child: ExpansionTile(title: Text(pastmatches['scorecard']["2"]["team"]['name'],
                     style: TextStyle(
                       color: Colors.white,
                     ),),
                     backgroundColor: Color(lightBlue),
                     iconColor: Colors.white,
                     collapsedIconColor: Colors.white,
                     children:
                     getEvetnts2()
                     ,),
                 ),
               )
             ],
           ),)

      ),
    );
  }
  dynamic pastmatches=new List();
  dynamic score=new List();
  dynamic score2=new List();
  void getmatches() async {
    setState(() {
      isLoading=true;
    });


    try {
      final response = await post(Uri.parse('http://13.127.190.65/api2/scorecard/0eeff2137825825ce7cfab876acc7c47?match_id=${widget.id}'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        pastmatches = responseJson['data'];
        score=responseJson['data']['scorecard']["1"]['batsman'];
        score2=responseJson['data']['scorecard']["2"]['batsman'];

        print(pastmatches);

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        // for(int i=0;i<pastmatches.length;i++){
        //   searcharray.add( pastmatches[i]['name']);
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
    for(int i= 0; i<score.length;i++){
      productList.add( GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Recenttabscorecard(
            // Ekey: pastmatches[i]["event_key"]
          )));
        },
        child:  Container(
          color:Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFF0F0F0),
                ),
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.3,
                      margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.02),
                      child: Text("Batting"),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.5,
                      margin: EdgeInsets.only(
                          right: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.05,
                            child: Text("R"),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.05,
                            child: Text("B"),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.05,
                            child: Text("4s"),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.05,
                            child: Text("6s"),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.1,
                            child: Text("S/R"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin:
                EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.3,
                      margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.02),
                      child: Text(

                        score[i]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.5,
                      margin: EdgeInsets.only(
                          right: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(  score[i]['run'].toString()),
                          ),
                          Container(
                            child: Text( score[i]['ball'].toString()),
                          ),
                          Container(
                            child: Text( score[i]['fours'].toString()),
                          ),
                          Container(
                            child: Text( score[i]['sixes'].toString()),
                          ),
                          Container(
                            child: Text( score[i]['strike_rate'].toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth * 0.4,
                margin: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.02,
                    top: SizeConfig.blockSizeVertical),
                padding: EdgeInsets.all(
                   10),

                child: Text(
                    score[i]['out_by'],
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 1.80,color: Colors.blue),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),

            ],
          ),
        )
      ),);
    }
    return productList;
  }
 List<Widget> getEvetnts2() {
   List<Widget> productList = new List();
   for(int i= 0; i<score2.length;i++){
     productList.add( GestureDetector(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>Recenttabscorecard(
             // Ekey: pastmatches[i]["event_key"]
           )));
         },
         child:  Container(
           color:Colors.white,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 decoration: BoxDecoration(
                   color: Color(0XFFF0F0F0),
                 ),
                 width: SizeConfig.screenWidth,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       width: SizeConfig.screenWidth * 0.3,
                       margin: EdgeInsets.only(
                           left: SizeConfig.screenWidth * 0.02),
                       child: Text("Batting"),
                     ),
                     Container(
                       width: SizeConfig.screenWidth * 0.5,
                       margin: EdgeInsets.only(
                           right: SizeConfig.screenWidth * 0.02),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             width: SizeConfig.screenWidth * 0.05,
                             child: Text("R"),
                           ),
                           Container(
                             width: SizeConfig.screenWidth * 0.05,
                             child: Text("B"),
                           ),
                           Container(
                             width: SizeConfig.screenWidth * 0.05,
                             child: Text("4s"),
                           ),
                           Container(
                             width: SizeConfig.screenWidth * 0.05,
                             child: Text("6s"),
                           ),
                           Container(
                             width: SizeConfig.screenWidth * 0.1,
                             child: Text("S/R"),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                 ),
                 width: SizeConfig.screenWidth,
                 margin:
                 EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       width: SizeConfig.screenWidth * 0.3,
                       margin: EdgeInsets.only(
                           left: SizeConfig.screenWidth * 0.02),
                       child: Text(

                         score2[i]['name'],
                         style: TextStyle(fontWeight: FontWeight.bold),
                       ),
                     ),
                     Container(
                       width: SizeConfig.screenWidth * 0.5,
                       margin: EdgeInsets.only(
                           right: SizeConfig.screenWidth * 0.02),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             child: Text(  score2[i]['run'].toString()),
                           ),
                           Container(
                             child: Text( score2[i]['ball'].toString()),
                           ),
                           Container(
                             child: Text( score2[i]['fours'].toString()),
                           ),
                           Container(
                             child: Text( score2[i]['sixes'].toString()),
                           ),
                           Container(
                             child: Text( score2[i]['strike_rate'].toString()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                 width: SizeConfig.screenWidth * 0.4,
                 margin: EdgeInsets.only(
                     left: SizeConfig.screenWidth * 0.02,
                     top: SizeConfig.blockSizeVertical),
                 padding: EdgeInsets.only(
                     left: SizeConfig.blockSizeHorizontal * 4),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(25),
                     border: Border.all(
                       color: Color(darkGrey),
                     )),
                 child: Text(
                  score2[i]['out_by'],
                   style: TextStyle(
                       fontSize: SizeConfig.blockSizeVertical * 1.25),
                 ),
               ),
               Container(
                 width: SizeConfig.screenWidth,
                 margin: EdgeInsets.symmetric(
                     horizontal: SizeConfig.screenWidth * 0.02,
                     vertical: SizeConfig.blockSizeVertical),
                 child: Divider(
                   color: Color(lightBlue),
                 ),
               ),

             ],
           ),
         )
     ),);
   }
   return productList;
 }
}