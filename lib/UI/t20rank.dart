import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class T20ranking extends StatefulWidget{
  dynamic testarray;
  dynamic image;
  dynamic screen;
  T20ranking({this.testarray,this.image,this.screen});
  @override
  __T20rankingState createState() => __T20rankingState();
}

class __T20rankingState extends State<T20ranking> {
  var testranking=new List();
  var teamlength=10;
  @override
  void initState()  {
    if(widget.screen=="womens"){
      teamlength=5;
    }
    else{
      teamlength=10;
    }
    print("jkbasjb"+widget.testarray.toString());
    print("klnnlnnnk");
    gettestarray();



    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(child: ListView(
          children: getTestRank(),
        ),),
      )
      ,
    );
  }

  List<Widget> getTestRank() {
    List<Widget> testlist=new List();
    for(int i =0; i<teamlength;i++){
      print('Rank${i+1}');
      testlist.add(Container(margin: EdgeInsets.all(15),child: Row(children: [
        Container(child: ClipRRect(  borderRadius: BorderRadius.circular(70.0),child: Image.network(widget.image[0]["Rank${i+1}"],width: 70,height: 70,fit: BoxFit.fitHeight,),)),SizedBox(width: 10,),

        Text(widget.testarray[0]['Rank${i+1}'].toString()),
        // SizedBox(width: 10,),
        // Text(widget.testarray[0]['team'][i]['name']+"("+widget.testarray[0]['team'][i]['code']+")"),
      ],),));
    }
    return testlist;
  }

  void gettestarray()  {
    testranking.add(widget.testarray);
    //print(testranking);
    setState(() {

      //testranking.add(widget.testarray[0]['team']);
    });
  }
}
