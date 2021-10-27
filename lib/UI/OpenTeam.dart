import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenTeam extends StatefulWidget {
  var arrays;
   OpenTeam({this.arrays});

  @override
  _OpenTeamState createState() => _OpenTeamState();
}

class _OpenTeamState extends State<OpenTeam> {

  List<String> player = ['Player Name',
    'Player Name',
    'Player Name',
    'Player Name(C)',
    'Player Name(Vc)',
    'Player Name',
    'Player Name',
    'Player Name',
    'Player Name',
    'Player Name',
    'Player Name',
    'Player Name',];

  List<String> skill =['Batsman',
    'Batsman',
    'Batsman',
    'Batsman',
    'Batsman/WK',
    'All Rounder',
    'Bowler',
    'Bowler',
    'Bowler',
    'Bowler',
    'Batsman',
    'Bowler'];
@override
  void initState() {
  print(widget.arrays[0]["bowler_to_batsma"].toString().split("to")[1]);
  print(widget.arrays[1]["bowler_to_batsma"].toString().split("to")[1]);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset('assets/icons/back.png',
            scale: SizeConfig.blockSizeVertical * 0.5,),
        ),
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: CircleAvatar(
              minRadius: SizeConfig.blockSizeVertical * 2.5,
              backgroundImage: AssetImage('assets/bg/profile.jpg'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.02,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/bg/team1.png',
                      width: SizeConfig.screenWidth * 0.3,),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Text("Team Name",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.75,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.5,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 0.5
                        ),
                        child: Text("Captain Name",
                        style: TextStyle(
                          color: Color(0XFF6A6A6A),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.25
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2
                        ),
                        width: SizeConfig.screenWidth * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("T20 Wins",
                                style: TextStyle(
                                  color: Color(0XFF6A6A6A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.50
                                ),),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Text("45",
                                style: TextStyle(
                                    color: Color(darkGrey),
                                    fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.25
                                ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("One Day Wins",
                                  style: TextStyle(
                                      color: Color(0XFF6A6A6A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.blockSizeVertical * 1.50
                                  ),),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Text("30",
                                  style: TextStyle(
                                      color: Color(darkGrey),
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.blockSizeVertical * 1.25
                                  ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Test Wins",
                                  style: TextStyle(
                                      color: Color(0XFF6A6A6A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.blockSizeVertical * 1.50
                                  ),),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Text("60",
                                  style: TextStyle(
                                      color: Color(darkGrey),
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.blockSizeVertical * 1.25
                                  ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.02,
                vertical: SizeConfig.blockSizeVertical
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(gradientColor1),
                    Color(gradientColor2).withOpacity(0.95),
                  ],
                  begin: Alignment(1.0, -3.0),
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25)
              ),
              child: MaterialButton(
                onPressed: (){},
                child: Text("Add To Favourite",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.02,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text("Team Player",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF6A6A6A),
                        ),),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text("Bat/Bowl",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF6A6A6A),
                          ),),
                      )
                    ],
                  ),
                  ListView.builder(itemBuilder: (context,int index){
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 0.5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: SizeConfig.screenWidth * 0.4,
                            child: Text(player[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(darkGrey),
                                fontSize: SizeConfig.blockSizeVertical * 2
                              ),),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Text(skill[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(darkGrey),
                                  fontSize: SizeConfig.blockSizeVertical * 2
                              ),),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: player.length,
                  shrinkWrap: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
