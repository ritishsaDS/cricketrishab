import 'package:flutter/material.dart';

class topstorydetail extends StatefulWidget{
  var image;
  var title;
  var description;
  topstorydetail({this.description,this.image,this.title});
  @override
  _topstorydetailState createState() => _topstorydetailState();
}

class _topstorydetailState extends State<topstorydetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        elevation: 0.0,

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
          Image.network(widget.image),
          Text(widget.title,  textAlign: TextAlign.justify,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),),
          SizedBox(height: 10,),
          Text(widget.description,textAlign: TextAlign.justify),
      ],),
        ),),
    );
  }
}