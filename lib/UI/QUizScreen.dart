import 'dart:convert';
import 'dart:io';

import 'package:CricScore_App/UI/MainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:CricScore_App/UI/Quizmain.dart';
import 'package:CricScore_App/UI/Quizmatches.dart';
import 'package:CricScore_App/UI/quizdialog.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quizscreen extends StatefulWidget {
  @override
  _QuizscreenState createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var name ;
  var image = 'www';
  GoogleSignInAccount _userObj;
  bool isLoggedIn = false;
  var profileData;
  Map userfb = {};
  //var facebookLogin = FacebookLogin();
  int _radioValue = 1;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;
  bool isError = true;
  String quiztext = '';
  final databaseReference = FirebaseDatabase.instance.reference();
  String testDevice = 'YOUR_DEVICE_ID';
  int maxFailedLoadAttempts = 3;
  int item = 0;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  var pastmatches=[];
  var selectedDate;
  var today;
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }
  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _anchoredBanner?.dispose();
  }
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.setImmersiveMode(true);
    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize size =
    await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-1988118332072011/9771093059',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }
  @override
  void initState() {

    _tabController = new TabController(length: 3, vsync: this);
    getuserdetail();
    readData();
    getDetail();
    getquizwinner();
    getprizes();
    // TODO: implement initState
    super.initState();
  }
  bool thirdrow=false;
  bool show=false;
  var secondrow="Player Email";

  @override
  Widget build(BuildContext context) {

    if(name==null){
      return Scaffold(body:

      Stack(
        children: [
          Container(

            padding: EdgeInsets.all(10),
            // height: SizeConfig.blockSizeVertical * 36,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: SizeConfig.screenWidth * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image:
                              AssetImage("assets/bg/quizbg.png"),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Cricket Quiz",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                SizeConfig.blockSizeVertical *
                                    4),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "( Play & Get A Chance to win Amazing Prizes )",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       getquizwinner();
                                //     },
                                //     style: ButtonStyle(
                                //         foregroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Color(0XffFFD700)),
                                //         backgroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Color(0XffFFD700)),
                                //         shape: MaterialStateProperty.all<
                                //             RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //                 borderRadius:
                                //                 BorderRadius.circular(
                                //                     30),
                                //                 side: BorderSide(
                                //                     color: Colors.black)))),
                                //     child: Text(
                                //       "Leaderboard",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 12),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       getprizes();
                                //     },
                                //     style: ButtonStyle(
                                //         foregroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Color(0XffFFD700)),
                                //         backgroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Color(0XffFFD700)),
                                //         shape: MaterialStateProperty.all<
                                //             RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //                 borderRadius:
                                //                 BorderRadius.circular(
                                //                     30),
                                //                 side: BorderSide(
                                //                     color: Colors.black)))),
                                //     child: Text(
                                //       "Prizes",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 12,
                                //           fontWeight:
                                //           FontWeight.w600),
                                //     ),
                                //   ),
                                // ),
                               
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          Center(
              child: Text(
                quiztext,
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w700),
              )),
          AlertDialog(

            content: Container(
              height: SizeConfig.screenHeight*0.15,
              child: Column(
                children: [
                  ElevatedButton(
                    child: Row(
                      children: [
                        Image.asset("assets/icons/facebook.png",scale: 22,),
                        Text(' Login with Facebook'),
                      ],
                    ),
                    onPressed: () {
                      initiateFacebookLogin();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0XFF3B5998),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    child: Row(
                      children: [
                        Image.asset('assets/icons/google-plus.png',scale: 4,),
                        Text(' Login with Google'),
                      ],
                    ),
                    onPressed: () {

                      googlelogin();
                     // Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0XFFDD4B39),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),);
    }
    else{
      if (!_loadingAnchoredBanner) {
        _loadingAnchoredBanner = true;
        _createAnchoredBanner(context);
      }

      return WillPopScope(
        onWillPop: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: Text(
                "Play And Win",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              elevation: 0.0,
              bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  //unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      text:('Play Now'),
                    ),
                    Tab(
                      text:('LeaderBoard'),
                    ),
                    Tab(
                      text:('Prizes'),
                    ),
                    // Tab(
                    //   text:('Live'),
                    // ),

                  ]),
              // actions: [
              //   Container(
              //     margin: EdgeInsets.all(8),
              //     child: CircleAvatar(
              //       minRadius: SizeConfig.blockSizeVertical * 2.5,
              //       backgroundImage: AssetImage('assets/bg/profile.jpg'),
              //     ),
              //   ),
              // ],
            ),
            body: TabBarView(
              controller: _tabController,
              children:<Widget> [
                isLoading?CircularProgressIndicator():  Column(children: [
                  Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        image == null ? "" : image))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: SizeConfig.screenWidth * 0.50,
                              child: Text(
                                name == null ? "" : name,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              )),
                          Expanded(child: SizedBox()),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.black),
                                  color: Color(0XffFFD700)),
                              child: Text(
                                "Points - ${userdetail[0]['score']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black),
                              )),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    // height: SizeConfig.blockSizeVertical * 36,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: SizeConfig.screenWidth * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                      AssetImage("assets/bg/quizbg.png"),
                                      fit: BoxFit.cover)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Cricket Quiz",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                        SizeConfig.blockSizeVertical *
                                            4),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "( Play & Get A Chance to win Amazing Prizes )",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      SizeConfig.blockSizeVertical * 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       getquizwinner();
                                        //     },
                                        //     style: ButtonStyle(
                                        //         foregroundColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Color(0XffFFD700)),
                                        //         backgroundColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Color(0XffFFD700)),
                                        //         shape: MaterialStateProperty.all<
                                        //             RoundedRectangleBorder>(
                                        //             RoundedRectangleBorder(
                                        //                 borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     30),
                                        //                 side: BorderSide(
                                        //                     color: Colors.black)))),
                                        //     child: Text(
                                        //       "Leaderboard",
                                        //       style: TextStyle(
                                        //           color: Colors.black,
                                        //           fontWeight: FontWeight.w600,
                                        //           fontSize: 12),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       getprizes();
                                        //     },
                                        //     style: ButtonStyle(
                                        //         foregroundColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Color(0XffFFD700)),
                                        //         backgroundColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Color(0XffFFD700)),
                                        //         shape: MaterialStateProperty.all<
                                        //             RoundedRectangleBorder>(
                                        //             RoundedRectangleBorder(
                                        //                 borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     30),
                                        //                 side: BorderSide(
                                        //                     color: Colors.black)))),
                                        //     child: Text(
                                        //       "Prizes",
                                        //       style: TextStyle(
                                        //           color: Colors.black,
                                        //           fontSize: 12,
                                        //           fontWeight:
                                        //           FontWeight.w600),
                                        //     ),
                                        //   ),
                                        // ),
                                        Container(

                                          width:SizeConfig.screenWidth*0.50,

                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Quizmatches()));
                                              //showAlertDialog(context);
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Color(0XffFFD700)),
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Color(0XffFFD700)),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                        side: BorderSide(
                                                            color: Colors.black)))),
                                            child: Text(
                                              "Play Now",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                        quiztext,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      )),
                  Expanded(child: SizedBox()),
                  if (_anchoredBanner != null)
                    Container(
                      color: Colors.green,
                      width: _anchoredBanner.size.width.toDouble(),
                      height: _anchoredBanner.size.height.toDouble(),
                      child: AdWidget(ad: _anchoredBanner),),
                ],),
                Column(children: [
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide( //                   <--- left side
                          color: Colors.black,
                          width: 2.0,
                        ),
                        top: BorderSide( //                    <--- top side
                          color: Colors.black,
                          width: 2.0,
                        ),
                        right: BorderSide( //                    <--- top side
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(6),
                        2: FlexColumnWidth(2),
                      },
                      //defaultColumnWidth: FixedColumnWidth(140.0),
                      border: TableBorder(


                          verticalInside: BorderSide(
                              width: 2, color: Colors.black)),

                      children: [
                        TableRow(children: [
                          Container(
                              child: Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Text('Rank',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.bold))
                                  ]))),
                          Container(
                              color: Colors.grey,
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                Text("Player Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black))
                              ])),

                          Container(
                              color: Colors.grey,
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                Text('Score',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black))
                              ]))

                          //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                        ])

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      border: Border.all(
                        width:
                        2, //                   <--- border width here
                      ),
                    ),
                    height: SizeConfig.screenHeight*0.45,
                    child: ListView(
                      children: winneelist(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Your Current Rank",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide( //                   <--- left side
                          color: Colors.black,
                          width: 2.0,
                        ),
                        top: BorderSide( //                    <--- top side
                          color: Colors.black,
                          width: 2.0,
                        ),
                        bottom: BorderSide( //                    <--- top side
                          color: Colors.black,
                          width: 2.0,
                        ),
                        right: BorderSide( //                    <--- top side
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),child:Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(6),
                      2: FlexColumnWidth(2),
                    },
                    //defaultColumnWidth: FixedColumnWidth(140.0),
                    border: TableBorder(


                        verticalInside: BorderSide(
                            width: 2, color: Colors.black)),

                    children: [

                      TableRow(children: [
                        Container(
                            child: Container(

                                padding: EdgeInsets.all(10),
                                child: Column(children: [
                                  Text(userdetail[0]['rank'].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight:
                                          FontWeight.bold))
                                ]))),
                        Container(

                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              Text(userdetail[0]['email'].toString(),
                                  style: TextStyle(

                                      color: Colors.black))
                            ])),

                        Container(

                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              Text(userdetail[0]['score'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black))
                            ])),


                        //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                      ])
                    ],
                  ),


                  ),
                  Expanded(child: SizedBox()),

                  // Center(
                  //      child: Text(
                  //        quiztext,
                  //        style: TextStyle(
                  //            color: Colors.red, fontWeight: FontWeight.w700),
                  //      )),
                ],),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide( //                   <--- left side
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  top: BorderSide( //                    <--- top side
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  right: BorderSide( //                    <--- top side
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Table(
                                //defaultColumnWidth: FixedColumnWidth(140.0),
                                border: TableBorder(


                                    verticalInside: BorderSide(
                                        width: 2, color: Colors.black)),

                                children: [
                                  TableRow(children: [
                                    Container(
                                        child: Container(
                                            color: Colors.grey,
                                            padding: EdgeInsets.all(10),
                                            child: Column(children: [
                                              Text('Rank',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                      FontWeight.bold))
                                            ]))),
                                    Container(
                                        color: Colors.grey,
                                        padding: EdgeInsets.all(10),
                                        child: Column(children: [
                                          Text("Prizes",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black))
                                        ])),



                                    //Container( padding:EdgeInsets.all(10),child: Column(children:[Text('Score', style: TextStyle(fontSize: 12.0))])),
                                  ]),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                border: Border.all(
                                  width:
                                  2, //                   <--- border width here
                                ),
                              ),
                              height: SizeConfig.screenHeight*0.4,
                              child: ListView(
                                children: Prizeslist(),
                              ),
                            )
                          ]),
                    ),
                    Expanded(child: SizedBox()),
                    if (_anchoredBanner != null)
                      Container(
                        color: Colors.green,
                        width: _anchoredBanner.size.width.toDouble(),
                        height: _anchoredBanner.size.height.toDouble(),
                        child: AdWidget(ad: _anchoredBanner),),
                  ],)
              ],
            ),
          ),
        ),
      );
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox();
      },
    );
  }

  Future<void> getDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      image = prefs.getString("image");
    });
  }

  dynamic prizes = new List();
  dynamic winner = new List();
  dynamic userdetail = new List();
  Future<void> getprizes() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await get(
        Uri.parse('http://18.216.40.7/api/getprizes'),
      );
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        prizes = responseJson;

        setState(() {
          thirdrow=false;
          show=true;
          secondrow="Prize";
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
  Future<void> getquizwinner() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await post(
        Uri.parse('http://18.216.40.7/api/apiwinner'),
      );
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        winner = responseJson;
print(winner);
print("winner");
        setState(() {
          secondrow="Player Email";
          thirdrow=true;
          show=true;
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
  Future<void> getuserdetail() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    try {
      final response = await post(
        Uri.parse('http://18.216.40.7/api/apiwinneruser'),
        body: {
          "provider_id":prefs.getString("provider_id")
        }
      );
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
       setState(() {
         userdetail = responseJson;
       });
print("userdetail");
print(userdetail);
        setState(() {
          secondrow="Player Email";
          thirdrow=true;
          show=true;
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

  List<Widget> winneelist() {
    List<Widget> prizewidget = new List();
    for (int i = 0; i < winner.length; i++) {
      prizewidget.add(Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(6),
            2: FlexColumnWidth(2),
          },

          border: TableBorder(
              horizontalInside: BorderSide(
                width: 5,
                color: Colors.grey[300],
                style: BorderStyle.solid,
              ),
              verticalInside: BorderSide(width: 2, color: Colors.black)),
          children: [

            TableRow(children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(winner[i]['rank'].toString(), style: TextStyle(fontSize: 14.0,color: Colors.black))
                  ])),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(winner[i]['name'].toString(), style: TextStyle(fontSize: 14.0,color: Colors.black))
                  ])),
              Container( padding:EdgeInsets.all(10),child: Column(children:[Text(winner[i]['score'].toString(), style: TextStyle(fontSize: 12.0))])),
            ])
          ]));
    }
    return prizewidget;
  }
  List<Widget> Prizeslist() {
    List<Widget> prizewidget = new List();
    for (int i = 0; i < prizes.length; i++) {
      prizewidget.add(Table(
          defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder(
              horizontalInside: BorderSide(
                width: 5,
                color: Colors.grey[300],
                style: BorderStyle.solid,
              ),
              verticalInside: BorderSide(width: 2, color: Colors.black)),
          children: [

            TableRow(children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(prizes[i]['rank'].toString(), style: TextStyle(fontSize: 14.0,color: Colors.black))
                  ])),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(prizes[i]['name'], style: TextStyle(fontSize: 14.0,color: Colors.black))
                  ])),

            ])
          ]));
    }
    return prizewidget;
  }

  void readData() {
    print(";jnk;jnkasdv;jnko");
    databaseReference.once().then((DataSnapshot snapshot) {
      print('ranking : ${snapshot.value}');
      //  print('ranking : ${snapshot.value['ImagesOdi']}');
      setState(() {
        quiztext = snapshot.value['QuizText'];
      });
    });
  }
  googlelogin() {
    var data;
    print("jejk");
    _googleSignIn.signIn().then((userData) {
      setState(() async {
        //_isLoggedIn = true;
        _userObj = userData;
        print("jejjjnkjnkek"+_userObj.toString());
        print(_userObj.displayName);
        print(_userObj.id);
        print(_userObj.photoUrl);
        print(_userObj.email);
        print(_userObj.authHeaders);
        if (_userObj.displayName != null) {
          // //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpCook(
          //     name:_userObj.displayName,
          //     email:_userObj.email
          // )));
          data={
            "email": _userObj.email,
            'name':_userObj.displayName,

            'image':_userObj.photoUrl,
            "phone":null,
            "provider_id":_userObj.id,

            "provider":"Google"
          };
          try {
            final response = await post(Uri.parse("http://18.216.40.7/api/userlogin"),
                headers: {
                  "Accept":"application/json"
                },
                body: {

                  "email": _userObj.email,
                  'name': _userObj.displayName,

                  'image': _userObj.photoUrl,
                  "phone": "",
                  "provider_id": _userObj.id,

                  "provider": "Google"}
            );
            print("bjkb" + response.statusCode.toString());
            print("bjkb" + json.encode(data).toString());
            if (response.statusCode == 200) {
              final responseJson = json.decode(response.body);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("name", _userObj.displayName);
              prefs.setString("email", _userObj.email);
              prefs.setString("image", _userObj.photoUrl);
              prefs.setString("provider_id", _userObj.id);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizscreen()));

              setState(() {
                isError = false;
                isLoading = false;
                print('setstate');
              });
            } else {
              print("bjkb" + response.statusCode.toString());

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
          // signup(_userObj.displayName, _userObj.email,
          //     "google");
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error"+facebookLoginResult.errorMessage);
        //onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await get(
            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token='
                '${facebookLoginResult.accessToken.token}'
            ));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        try {
          final response = await post(Uri.parse("http://18.216.40.7/api/userlogin"),
              headers: {
                "Accept":"application/json"
              },
              body: {
                "email": profile['email']==null?"":profile['email'],
                'name': profile['name'],

                'image': profile['picture']['data']['url'],
                "phone": "",
                "provider_id": profile['id'],

                "provider": "Facebook"}
          );
          print("bjkb" + response.statusCode.toString());
          // print("bjkb" + json.encode(data).toString());
          if (response.statusCode == 200) {

            final responseJson = json.decode(response.body);
            print(responseJson);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            prefs.setString("name", profile['name']);
            //  prefs.setString("email", responseJson['user']['email']);
            prefs.setString("image", profile['picture']['data']['url']);
            prefs.setString("provider_id", profile['id']);

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizscreen()));

            setState(() {
              isError = false;
              isLoading = false;
              print('setstate');
            });
          } else {
            print("bjkb" + response.statusCode.toString());

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

        //  onLoginStatusChanged(true, profileData: profile);
        break;
        // onLoginStatusChanged(true);
        break;
    }
  }
}
