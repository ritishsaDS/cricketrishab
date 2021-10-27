import 'dart:convert';

import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PointsTable extends StatefulWidget{
  dynamic id;
  PointsTable({this.id});
  @override
  _PointsTableState createState() => _PointsTableState();
}

class _PointsTableState extends State<PointsTable> {
  bool  isError = true;
 bool isLoading = false;
 @override
  void initState() {
   getlivescore();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
body:
      SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                padding:EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                    Container(width:SizeConfig.blockSizeHorizontal*30,child:   Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.start),),
                          Container(child: Text("P",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.center, )),
                          Container(child: Text("W",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.center, )),
                          Container(child: Text("L",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.center, )),
                         // Text("NRter,),
                          Container(child: Text("Pts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                          Container(child: Text("NRR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                        ]),
                                     ),
                Column(
                  children:
                    Noevents()

                ),
              ],
            ),
          ),
        ),
      ),

   );
  }
  dynamic scorefromserver = new List();

  void getlivescore() async {
    setState(() {
      isLoading=true;
    });

    try {
      final response = await post(Uri.parse('http://13.127.190.65/api2/points/0eeff2137825825ce7cfab876acc7c47?series_id=${widget.id}'));
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
  List<Widget> Noevents(){
    List<Widget> productList = new List();
    for(int i =0; i<scorefromserver.length;i++){
    productList.add(SingleChildScrollView
      (
      scrollDirection: Axis.vertical,
      child: Container(
        child:

        Container(
          color: i % 2 == 0 ? Colors.grey[300] : Colors.white,
            child:
              Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Container(padding:EdgeInsets.all(15),width:SizeConfig.blockSizeHorizontal*30,child:   Text(scorefromserver[i]['teams'], textAlign: TextAlign.start),),
                Text(scorefromserver[i]['P'], ),
                Text(scorefromserver[i]['W'],  ),
                Text(scorefromserver[i]['L'],  ),

                Text(scorefromserver[i]['Pts']),
                Text(scorefromserver[i]['NRR']),
              ]),

         )
      ),
    ));}
    return productList;

  }
}