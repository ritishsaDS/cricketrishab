import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/MainScreen.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
Image.asset("assets/icons/cup.png"),
           SizedBox(height: 20,), Text(
              "You Can See Your Score After Match End in Leaderboard",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white),
              textAlign: TextAlign.center,

            ), //Text
SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                      RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),


                      )
                  )
              ),
              child: Text(
                'Return to Main Screen!',
              ), //Text

              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ), //FlatButton
          ], //<Widget>[]
        ), //Column
      ),
    ); //Center
  }
}