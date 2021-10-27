import 'package:flutter/material.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'Quizclass.dart';
class Answer extends StatefulWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(

        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Color(lightBlue),),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          height: SizeConfig.blockSizeVertical*7,



          child: Text(widget.answerText,style: TextStyle(fontSize: 16,color: Colors.white,),),

        ),
        onTap:widget.selectHandler
      ), //RaisedButton
    ); //Container
  }
}