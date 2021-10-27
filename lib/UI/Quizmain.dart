import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:CricScore_App/UI/quizdialog.dart';
import 'package:CricScore_App/Utils/Colors.dart';

import 'package:http/http.dart'as http;
import 'Quizclass.dart';
import 'Result.dart';


class Quizmain extends StatefulWidget {
  var id;
  Quizmain({this.id});
  @override
  State<StatefulWidget> createState() {
    return _QuizmainState();
  }
}

class _QuizmainState extends State<Quizmain> {
  bool isError = false;
 bool isLoading = false;
  var _questions = [
    // {
    //   'questionText': 'Q1.Who has the highest test Ranking?',
    //   'answers': [
    //     {'text': 'Rahul Dravid', 'score': -2},
    //     {'text': 'Sachin Tendulakr', 'score': -2},
    //     {'text': 'S.D.Bradman', 'score': 10},
    //     {'text': 'Brian Lara', 'score': -2},
    //   ],
    // },
    // {
    //   'questionText': 'Q2. Who wins the ICC Test Championship 2021?',
    //   'answers': [
    //     {'text': 'India(IND)', 'score': -2},
    //     {'text': 'England(ENG)', 'score': -2},
    //     {'text': 'Australia(AUS)', 'score': -2},
    //     {
    //       'text':
    //       'New Zealand(NZ)',
    //       'score': 10
    //     },
    //   ],
    // },
    // {
    //   'questionText': ' Q3. Who won the first World Cup, 1975? ',
    //   'answers': [
    //     {'text': 'India', 'score': -2},
    //     {'text': 'England', 'score': 10},
    //     {'text': 'WestIndies', 'score': -2},
    //     {'text': 'Australia', 'score': -2},
    //   ],
    // },
    // {
    //   'questionText': 'Q4. India achieved its first Test victory against Australia in:',
    //   'answers': [
    //     {'text': '1959-60', 'score': 10},
    //     {'text': '1960-61', 'score': -2},
    //     {'text': '1980-81', 'score': -2},
    //     {'text': '2000-01', 'score': -2},
    //   ],
    // },
    // {
    //   'questionText':
    //   'Q5. When and where did India play her first one day International?',
    //   'answers': [
    //     {
    //       'text': 'In 1970 at Oval, England.',
    //       'score': -2,
    //     },
    //     {'text': 'In 1974 at Leeds, England.', 'score': 10},
    //     {
    //       'text': 'In 1970 at Headingly, England.',
    //       'score': -2,
    //     },
    //     {'text': 'In 1972 at Leeds, Lords.', 'score': -2},
    //   ],
    // },
  ];
@override
  void initState() {
  getQuiz();
    // TODO: implement initState
    super.initState();
  }
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
      progressValue=0.0;
      const oneSec = const Duration(seconds: 1);
      new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        progressValue += 0.1;});});
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          backgroundColor: Color(lightBlue),
        ),
        body:isLoading?CircularProgressIndicator(): Stack(
          children: [
             SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill,width: double.infinity,),
            // CustomDialogBox(),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: _questionIndex < _questions.length
                  ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                length:_questions.length
              ) //Quiz
                  : Result(_totalScore, _resetQuiz),
            ),
          ],
        ), //Padding
      //Scaffold
    ); //MaterialApp
  }
dynamic answers=[];
  Future<void> getQuiz() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(Uri.parse(
          'http://18.216.40.7/api/get-quiz'),

      body: {
        "matchid":widget.id.toString()
      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        _questions = responseJson['questions'];

        print(_questions);

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
}