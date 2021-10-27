import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';

import 'ANswer.dart';
import 'Question.dart';
import 'Result.dart';
double progressValue;
class Quiz extends StatefulWidget {
  dynamic questions;
  int questionIndex;
  final Function answerQuestion;
  var length;

  Quiz({
     this.questions,
    this.length,
     this.answerQuestion,
     this.questionIndex,
  });

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _loading;
Color buttoncolor=Color(lightBlue);
Color buttoncolor2=Color(lightBlue);
Color buttoncolor3=Color(lightBlue);
Color buttoncolor4=Color(lightBlue);
var quesyinindex;
var chooseoption;
  @override
  void initState() {
    super.initState();
    quesyinindex=widget.questionIndex;
    _loading = false;
    progressValue = 0.0;
    _updateProgress();
  }
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        progressValue += 0.1;
        // we "finish" downloading here
        if (progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          print('length'+(widget.length-1).toString());
          setState(() {
            if ( widget.questionIndex< widget.length-1) {
              print(quesyinindex);
             // widget.questionIndex=widget.questionIndex+1;
              quesyinindex= widget.questionIndex;
              print(widget.questionIndex);
              print(quesyinindex);

            //  progressValue=0.0;
             // _updateProgress();
            }
            else{

            }

          });
          return;
        }
      });
    });
  }
  var sendanswer=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // LinearProgressIndicator(
      //   backgroundColor: Colors.cyanAccent,
      //   valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      //   value: progressValue,
      // ),
        Question(
          "Q-"+(widget.questionIndex+1).toString()+") "+widget.questions[widget.questionIndex]['questions'],
        ), //Question
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          30),
                      side: BorderSide(
                          color: Colors.black)))),
          onPressed: (){
            setState(() {
              if(buttoncolor2==Colors.green){
                buttoncolor2=Colors.blue;
              }
              else if(buttoncolor3==Colors.green){
                buttoncolor3=Colors.blue;
              }
              else if(buttoncolor4==Colors.green){
                buttoncolor4=Colors.blue;
              }
              buttoncolor=Colors.green;
              chooseoption="A";
            });

          },
          child: Container(
               margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              height: SizeConfig.blockSizeVertical*7,



              child: Text(widget.questions[widget.questionIndex]['optionA'],style: TextStyle(fontSize: 16,color: Colors.white,),),

            ),
            //onTap:widget.selectHandler
        ), //RaisedButton
      ),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor2),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor2),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          30),
                      side: BorderSide(
                          color: Colors.black)))),
          onPressed: (){
            setState(() {
              if(buttoncolor==Colors.green){
                buttoncolor=Colors.blue;
              }
              else if(buttoncolor3==Colors.green){
                buttoncolor3=Colors.blue;
              }
              else if(buttoncolor4==Colors.green){
                buttoncolor4=Colors.blue;
              }
              buttoncolor2=Colors.green;
              chooseoption="B";
            });

          },
          child: Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            height: SizeConfig.blockSizeVertical*7,



            child: Text(widget.questions[widget.questionIndex]['optionB'],style: TextStyle(fontSize: 16,color: Colors.white,),),

          ),
          //onTap:widget.selectHandler
        ), //RaisedButton
      ),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor3),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor3),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          30),
                      side: BorderSide(
                          color: Colors.black)))),
          onPressed: (){
            setState(() {
              if(buttoncolor==Colors.green){
                buttoncolor=Colors.blue;
              }
              else if(buttoncolor2==Colors.green){
                buttoncolor2=Colors.blue;
              }
              else if(buttoncolor4==Colors.green){
                buttoncolor4=Colors.blue;
              }
              buttoncolor3=Colors.green;
              chooseoption="C";
            });

          },
          child: Container(
           margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            height: SizeConfig.blockSizeVertical*7,



            child: Text(widget.questions[widget.questionIndex]['optionC'],style: TextStyle(fontSize: 16,color: Colors.white,),),

          ),
          //onTap:widget.selectHandler
        ), //RaisedButton
      ),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor4),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  buttoncolor4),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          30),
                      side: BorderSide(
                          color: Colors.black)))),
          onPressed: (){
            setState(() {
              if(buttoncolor==Colors.green){
                buttoncolor=Colors.blue;
              }
              else if(buttoncolor2==Colors.green){
                buttoncolor2=Colors.blue;
              }
              else if(buttoncolor3==Colors.green){
                buttoncolor3=Colors.blue;
              }
              buttoncolor4=Colors.green;
              chooseoption="D";
            });

          },
          child: Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            height: SizeConfig.blockSizeVertical*7,



            child: Text(widget.questions[widget.questionIndex]['optionD'],style: TextStyle(fontSize: 16,color: Colors.white,),),

          ),
          //onTap:widget.selectHandler
        ), //RaisedButton
      ),
       SizedBox(
         height: 80,
       ),

      Container(

        width: double.infinity,
        child: GestureDetector(
          onTap: (){
            setState(() {
              print(chooseoption);
              sendanswertoserver(widget.questions[widget.questionIndex]['id'].toString(),chooseoption);
              // print(widget.questions.length);
              // if(widget.questionIndex==widget.questions.length-1){
              //   sendanswer.add("OptionD+${widget.questions[widget.questionIndex]['id'].toString()}");
              //   print(sendanswer);
              //   sendanswertoserver(widget.questions[widget.questionIndex]['id'],"OptionD");
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(40,_resetQuiz)));
              // }
              // else{
              //
              //   sendanswertoserver(widget.questions[widget.questionIndex]['id'],"OptionD");
              // }
            });
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.grey,),
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            height: SizeConfig.blockSizeVertical*7,



            child: Text("SUBMIT",style: TextStyle(fontSize: 16,color: Colors.white,),),

          ),
          //onTap:widget.selectHandler
        ), //RaisedButton
      ),
        // ...(widget.questions[widget.questionIndex]['optionA']).map((answer) {
        //   return Answer(() => widget.answerQuestion(answer['score']), answer['text']);
        // }).toList()
      ],
    )); //Column
  }
  void _resetQuiz() {
    setState(() {
      widget.questionIndex = 0;
     // _totalScore = 0;
    });
  }
  Future<void> sendanswertoserver(id,option) async {
    try {
      final response = await post(Uri.parse(
          'http://18.216.40.7/api/attempt'),
          body: {
            "quizid":id.toString(),
            "userid":"1",
            "answered":option
          });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);


        setState(() {
          buttoncolor=Color(lightBlue);
          buttoncolor2=Color(lightBlue);
          buttoncolor3=Color(lightBlue);
          buttoncolor4=Color(lightBlue);
          if(widget.questionIndex==widget.questions.length-1){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(40,_resetQuiz)));
            }
            else{
            widget.questionIndex=widget.questionIndex+1;
            //  sendanswertoserver(widget.questions[widget.questionIndex]['id'],"OptionD");
            }

          //sendanswer.add("OptionD+${widget.questions[widget.questionIndex]['id'].toString()}");
          print(sendanswer);
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

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
    }
  }

}
class LinearProgressIndicatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState extends State<LinearProgressIndicatorApp> {
  bool _loading;
  double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
    _updateProgress();
  }
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Linear Progress Bar"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: _loading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LinearProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                value: _progressValue,
              ),
              Text('${(_progressValue * 100).round()}%'),
            ],
          )
              : Text("Press button for downloading", style: TextStyle(fontSize: 25)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _loading = !_loading;
            _updateProgress();
          });
        },
        tooltip: 'Download',
        child: Icon(Icons.cloud_download),
      ),
    );
  }
  // this function updates the progress value
}