import 'package:CricScore_App/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Teamsquad extends StatefulWidget{
  dynamic squad;
  dynamic name;
  Teamsquad({this.squad,this.name});
  @override
  _TeamsquadState createState() => _TeamsquadState();
}

class _TeamsquadState extends State<Teamsquad> {
  var split;
  @override
  void initState() {
    print(widget.squad);
     split = widget.squad.split(',');
    print(split);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    appBar: AppBar(
      flexibleSpace:(
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(

                  colors: [
                    Color(gradientColor1),
                    Color(gradientColor2).withOpacity(0.95),
                  ],  begin: Alignment(-3.0, 1.0),
                  end: Alignment.bottomRight,),
              ))),
      title: Text("Team Squad "+widget.name),
    ),
   body: SafeArea(
     child: Container(child: ListView(children: showplayer(),),),
   ),
  );
  }
  List<Widget>showplayer(){
    List<Widget> testlist=new List();
    for(int i=0; i<split.length;i++){
      testlist.add(
        Container(margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("${i+1}".toString()+").   ",style: TextStyle(fontSize: 16,color: Colors.black),),
                  Text(split[i],style: TextStyle(fontSize: 16,color: Colors.black),),
                ],
              ),
           Divider(
             thickness: 1.5,
             height: 5,
             color: Colors.grey[200],
           )
            ],
          ),
        )
      );
    }
    return testlist;
  }
}