import 'dart:convert';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';

import 'Dashboard.dart';
import 'Matchsquad.dart';

class Completedmatchdetail extends StatefulWidget{
  var id;
  var status;
  Completedmatchdetail({this.id,this.status});
  @override
  _CompletedmatchdetailState createState() => _CompletedmatchdetailState();
}

class _CompletedmatchdetailState extends State<Completedmatchdetail> {
  @override
  void initState() {
    getoutdate();
    getmatchdetail();
    // TODO: implement initState
    super.initState();
  }
  var months=[
    '',
    ' ',
    'JAN',
    'FEB',
    'MAR',
    "APR"
        'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  bool  isError = false;
 bool isLoading = false;
 var squada=[];
 var squadb=[];
  var teamaid;
 var teambid;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  int maxFailedLoadAttempts = 3;
  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;

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
          ? '${fbbannerid}'
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
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }
    // TODO: implement buil
    if(widget.status=='recent'){
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
          home:
          isLoading?Scaffold(
              appBar: AppBar(
                title: Text(""),
                centerTitle: true,
                elevation: 0,
                leading: GestureDetector(onTap:(){
                  Navigator.pop(context);
                },child:Icon(Icons.arrow_back)),
                backgroundColor: Color(lightBlue),
                iconTheme: IconThemeData(color: Colors.white),

              ),body: Center(
            child: Container(
              height: 60,
              child: CircularProgressIndicator(

              ),
            ),
          )):
          DefaultTabController(
              initialIndex: 1,
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("${mathesfromserver['localteam']['code']+ " vs "+mathesfromserver['visitorteam']['code']}"),
                  centerTitle: true,
                  elevation: 0,
                  leading: GestureDetector(onTap:(){
                    Navigator.pop(context);
                  },child:Icon(Icons.arrow_back)),
                  backgroundColor: Color(lightBlue),
                  iconTheme: IconThemeData(color: Colors.white),
                  bottom: TabBar(
                    unselectedLabelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text("INFO",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("LIVE",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SCORECARD",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SQUADS",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                        child: Column(children: [
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text("SQUADS"),
                          ),
                          GestureDetector(
                            onTap: (){
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //     Matchsquad(firstteam: mathesfromserver['localteam']['name'],firstsquad: squada,secondteam:mathesfromserver['visitorteam']['name'] ,secondsquad: squadb,)));

                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['localteam']['code']),
                            ),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          GestureDetector(
                            onTap: (){
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //     Matchsquad(firstteam: mathesfromserver['localteam']['name'],firstsquad: squada,secondteam:mathesfromserver['visitorteam']['name'] ,secondsquad: squadb,)));

                            },
                            child: Container(
                              // color:Colors.grey,
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['visitorteam']['code']),
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text("INFO"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Match",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['status'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Series",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['league']['name'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Match Type",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['type'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Toss",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                      mathesfromserver['tosswon']['name'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Umpires",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text("${mathesfromserver['firstumpire']==null?"":mathesfromserver['firstumpire']['fullname']}",
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),


                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Venue",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text("${mathesfromserver['venue']==null?"":mathesfromserver['venue']['name'].toString()}",
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                        ])),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              height: SizeConfig.screenHeight * 0.35,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(left:10.0,right:10,top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(

                                            width: SizeConfig.screenWidth*0.85,
                                              child: Text(mathesfromserver['league']['name']+" ,"+mathesfromserver['round'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),)),
                                          // Container(
                                          //   width: 100,
                                          //   height: 25,
                                          //   child: ElevatedButton(onPressed: (){var i=0;
                                          //   i++;}, style: ButtonStyle(
                                          //       foregroundColor: MaterialStateProperty.all<Color>(Color(lightBlue)),
                                          //       backgroundColor: MaterialStateProperty.all<Color>(Color(lightBlue)),
                                          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          //           RoundedRectangleBorder(
                                          //               borderRadius: BorderRadius.circular(30),
                                          //               side: BorderSide(color: Colors.white)
                                          //           )
                                          //       )
                                          //
                                          //   ),child: Text("Live",style: TextStyle(color: Colors.white,fontSize: 14),),),
                                          // )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            mathesfromserver['starting_at'].toString().substring(0,10).split("-")[2]+"-"+  months[int.parse(mathesfromserver['starting_at'].toString().substring(0,10).split("-")[1])]+"-"+  mathesfromserver['starting_at'].toString().substring(0,10).split("-")[0]
                                                +" , ",
                                            style: TextStyle(fontSize: 12),
                                          ),

                                          Text(
                                              int.parse(mathesfromserver['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                                          )
                                        ],
                                      ),

                                      Text(mathesfromserver['status'],style: TextStyle(color: Colors.red),),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container
                                            (
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(shape: BoxShape.circle,
                                                image: DecorationImage(image: NetworkImage(mathesfromserver['localteam']['image_path']),)),
                                          ),
                                          Text(
                                            mathesfromserver['localteam']['code'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          teamaid== mathesfromserver['runs'][0]['team_id']?
                                          Text(
                                              mathesfromserver['runs'].length==0?"":mathesfromserver['runs'][0]['score'].toString()+"/"+mathesfromserver['runs'][0]['wickets'].toString()+" ("+mathesfromserver['runs'][0]['overs'].toString()+")",

                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)):
                                          Text(
                                              mathesfromserver['runs'].length==1?"":mathesfromserver['runs'][1]['score'].toString()+"/"+mathesfromserver['runs'][1]['wickets'].toString()+" ("+mathesfromserver['runs'][1]['overs'].toString()+")",

                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),

                                          //Text("  (50 Overs)",style: TextStyle(color: Colors.black,fontSize: 12,)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container
                                            (
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(shape: BoxShape.circle,
                                                image: DecorationImage(image: NetworkImage(mathesfromserver['visitorteam']['image_path']),)),
                                          ),
                                          Text(
                                            mathesfromserver['visitorteam']['code'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          teambid==mathesfromserver['runs'][1]['team_id']?
                                          Text(
                                              mathesfromserver['runs'].length==1?"":mathesfromserver['runs'][1]['score'].toString()+"/"+mathesfromserver['runs'][1]['wickets'].toString()+" ("+mathesfromserver['runs'][1]['overs'].toString()+")"

                                              ,style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)):Text(
                                              mathesfromserver['runs'].length==0?"":mathesfromserver['runs'][0]['score'].toString()+"/"+mathesfromserver['runs'][0]['wickets'].toString()+" ("+mathesfromserver['runs'][0]['overs'].toString()+")"

                                              ,style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(mathesfromserver['note']
                                        ,style: TextStyle(color: Colors.red),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Player Of the Match: "),
                              Text(
                                "${mathesfromserver['manofmatch']==null?"":mathesfromserver['manofmatch']['fullname']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          // Container(
                          //   child: Text(
                          //     "Balls",
                          //     style: TextStyle(
                          //         fontSize: SizeConfig.blockSizeVertical * 1.50,
                          //         color: Colors.black),
                          //   ),
                          //   margin: EdgeInsets.only(
                          //       left: SizeConfig.screenWidth * 0.02,
                          //       top: SizeConfig.blockSizeVertical),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       left: SizeConfig.screenWidth * 0.02,
                          //       top: SizeConfig.blockSizeVertical),
                          //   width: SizeConfig.screenWidth * 0.4,
                          //   height: SizeConfig.blockSizeVertical * 3,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(25),
                          //       border: Border.all(
                          //         color: Color(lightBlue),
                          //       )),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Color(lightBlue),
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           child: Text(
                          //             "2",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //       Container(
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.grey[400],
                          //           ),
                          //           padding: EdgeInsets.all(4),
                          //           width: SizeConfig.blockSizeHorizontal * 3.5,
                          //           child: Text(
                          //             "",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize:
                          //                     SizeConfig.blockSizeVertical *
                          //                         1.25),
                          //           )),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: SizeConfig.screenWidth * 0.02,
                          //       vertical: SizeConfig.blockSizeVertical),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.1,
                          //         child: Text("2"),
                          //       ),
                          //       Container(
                          //         width: SizeConfig.screenWidth * 0.8,
                          //         child: Text(
                          //           "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                          //           style: TextStyle(
                          //               fontSize: SizeConfig.blockSizeVertical *
                          //                   1.50),
                          //           textAlign: TextAlign.justify,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),

                          Container(
                            height: SizeConfig.screenHeight*0.35,
                            child: ListView(
                              children: balls(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenHeight*0.80,
                      child: ListView(

                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10,),
                            width: SizeConfig.screenWidth,
                            color: Color(lightBlue),
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(

                                  // initiallyExpanded : index==selected,
                                  // onExpansionChanged: ((newState){
                                  //   if(newState)
                                  //     setState(() {
                                  //       Duration(seconds:  20000);
                                  //       selected = index;
                                  //     });
                                  //   else
                                  //     setState(() {
                                  //       selected = -1;
                                  //     });
                                  // }),
                                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['localteam']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      teamaid== mathesfromserver['runs'][0]['team_id']?
                                      Text(
                                          mathesfromserver['runs'].length==0?"":mathesfromserver['runs'][0]['score'].toString()+"/"+mathesfromserver['runs'][0]['wickets'].toString()+" ("+mathesfromserver['runs'][0]['overs'].toString()+")",

                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)):
                                      Text(
                                          mathesfromserver['runs'].length==1?"":mathesfromserver['runs'][1]['score'].toString()+"/"+mathesfromserver['runs'][1]['wickets'].toString()+" ("+mathesfromserver['runs'][1]['overs'].toString()+")",

                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children: [
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(

                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Batting"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("B"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("4s"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("6s"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("S/R"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        child: Column(
                                            children:  battingorder()

                                        )),
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Bowling"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("O"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("W"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("M"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("Eco."),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        child: Column(

                                          children: bowlingsecondorderlist(),
                                        ))

                                  ],
                                )),


                          ),

                          Container(
                            margin: EdgeInsets.only(top:10,),
                            color: Color(lightBlue),
                            width: SizeConfig.screenWidth,
                            // decoration: BoxDecoration(
                            //     color: Color(lightBlue),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                // initiallyExpanded: index==selected,
                                // onExpansionChanged: ((newState){
                                //   if(newState)
                                //     setState(() {
                                //       selected=1;
                                //       Duration(seconds:  20000);
                                //       selected = index;
                                //     });
                                //   else
                                //     setState(() {
                                //       selected = -1;
                                //     });
                                // }),
                                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mathesfromserver['visitorteam']["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      teambid==mathesfromserver['runs'][1]['team_id']?
                                      Text(
                                          mathesfromserver['runs'].length==1?"":mathesfromserver['runs'][1]['score'].toString()+"/"+mathesfromserver['runs'][1]['wickets'].toString()+" ("+mathesfromserver['runs'][1]['overs'].toString()+")"

                                          ,style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)):Text(
                                          mathesfromserver['runs'].length==0?"":mathesfromserver['runs'][0]['score'].toString()+"/"+mathesfromserver['runs'][0]['wickets'].toString()+" ("+mathesfromserver['runs'][0]['overs'].toString()+")"

                                          ,style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  backgroundColor: Color(lightBlue),
                                  iconColor: Colors.white,
                                  collapsedIconColor: Colors.white,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Batting"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("B"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("4s"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("6s"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("S/R"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        child: Column(
                                          children: batting2ndorder(),
                                        )),
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF0F0F0),
                                      ),
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Text("Bowling"),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            margin: EdgeInsets.only(
                                                right: SizeConfig.screenWidth *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("O"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("R"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("W"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.05,
                                                  child: Text("M"),
                                                ),
                                                Container(
                                                  width:
                                                  SizeConfig.screenWidth *
                                                      0.1,
                                                  child: Text("Eco."),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Column(
                                          children: bowlingorderlist(),
                                        ))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),


                    Matchsquad(firstteam: mathesfromserver['localteam']['name'],firstsquad: squada,secondteam:mathesfromserver['visitorteam']['name'] ,secondsquad: squadb,)
                  ],
                ),
              )));
    }

    else

    {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
          home: isLoading?Scaffold(
              appBar: AppBar(
                title: Text(""),
                centerTitle: true,
                elevation: 0,
                leading: GestureDetector(onTap:(){
                  Navigator.pop(context);
                },child:Icon(Icons.arrow_back)),
                backgroundColor: Color(lightBlue),
                iconTheme: IconThemeData(color: Colors.white),

              ),body: Center(
            child: Container(
              height: 60,
              child: CircularProgressIndicator(

              ),
            ),
          )):DefaultTabController(
              initialIndex: 0,
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("${mathesfromserver['localteam']['code']+" Vs "+ mathesfromserver['visitorteam']['code']}"),
                  centerTitle: true,
                  elevation: 0,

                  leading: GestureDetector(onTap:(){
                    Navigator.pop(context);
                  },child: Icon(Icons.arrow_back)),
                  backgroundColor: Color(lightBlue),
                  iconTheme: IconThemeData(color: Colors.white),
                  bottom: TabBar(
                    unselectedLabelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text("INFO",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("LIVE",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SCORECARD",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text("SQUADS",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                        child: Column(children: [
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text("SQUADS"),
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['localteam']['code']),
                            ),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          GestureDetector(
                            onTap: (){
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Matchsquad(
                              //           firstteam: mathesfromserver['localteam']['code']
                              //           ,
                              //           secondteam: mathesfromserver['visitorteam']['code'],
                              //
                              //           match: mathesfromserver,
                              //         )));
                            },
                            child: Container(
                              // color:Colors.grey,
                              padding: EdgeInsets.all(10),
                              width: SizeConfig.screenWidth,
                              child: Text(mathesfromserver['visitorteam']['code']),
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Text("INFO"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Match",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['status'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Series",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['league']['name'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Match Type",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['type'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Toss",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  // Text(
                                  //     mathesfromserver['tosswon']['name'],
                                  //     style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Umpires",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(mathesfromserver['firstumpire']==null?"":mathesfromserver['firstumpire']['fullname'],
                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),

                          Container(
                            padding: EdgeInsets.all(10),
                            width: SizeConfig.screenWidth,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Venue",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(                                mathesfromserver['venue']==null?"":mathesfromserver['venue']['name']+" , "+mathesfromserver['venue']['city'],overflow: TextOverflow.ellipsis,softWrap: true,

                                      style: TextStyle(color: Colors.black))
                                ]),
                          ),
                          Divider(
                              height: 5, thickness: 1.5, color: Colors.grey[200]),
                        ])),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/stop-watch.png",
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Match Not Started Yet",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveMatch()));
                            },
                            child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/stop-watch.png",
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Match Not Started Yet",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "assets/icons/stop-watch.png",
                          scale: 5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Match Not Available Yet",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                        // Container(
                        //   margin: EdgeInsets.only(top:10,left:3,right:3),
                        //   width: SizeConfig.screenWidth,
                        //   decoration: BoxDecoration(
                        //       color: Color(lightBlue),
                        //       borderRadius: BorderRadius.circular(15)),
                        //   child: Theme(
                        //     data: Theme.of(context)
                        //         .copyWith(dividerColor: Colors.transparent),
                        //     child: ExpansionTile(
                        //       initiallyExpanded: true,
                        //       title: Text(
                        //         mathesfromserver['teams']['a']["name"],
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       iconColor: Colors.blue,
                        //       collapsedIconColor: Colors.white,
                        //       children: squadwidget(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // Container(
                        //   margin: EdgeInsets.only(top:10,left:3,right:3),
                        //   width: SizeConfig.screenWidth,
                        //   decoration: BoxDecoration(
                        //       color: Color(lightBlue),
                        //       borderRadius: BorderRadius.circular(15)),
                        //   child: ExpansionTile(
                        //       title: Text(
                        //         mathesfromserver['teams']['b']["name"],
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       backgroundColor: Colors.white,
                        //       iconColor: Colors.white,
                        //       collapsedIconColor: Colors.white,
                        //       children: squadwidgetb()),
                        // )
                      ],
                    ),
                  ],
                ),
              )));
    }

  }
  dynamic mathesfromserver=new List();
  dynamic scorecarda=new List();
  dynamic bowlingscorecarda=new List();
  dynamic bowlingscorecardb=new List();
  dynamic scorecardb=new List();
  dynamic recentballs=new List();
  dynamic scoredata=new List();
  var outtypes={};
  void getmatchdetail() async {
    var url="https://cricket.sportmonks.com/api/v2.0/fixtures/${widget.id}?api_token=${matchkey}&include=balls,runs,visitorteam,localteam,batting,bowling,league,stage,manofmatch,tosswon,lineup,venue,firstUmpire";
    setState(() {
      isLoading=true;
    });


    try {
      final response = await http.get(Uri.parse(url),headers: {


      });
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);


        mathesfromserver=responseJson['data'];
        print( mathesfromserver);
        teamaid=mathesfromserver['localteam_id'];
        teambid=mathesfromserver['visitorteam_id'];
        recentballs=mathesfromserver['balls'];
        List lista=[];
for(int i =0; i<mathesfromserver['lineup'].length;i++){
  if(mathesfromserver['lineup'][i]['lineup']['team_id']==teamaid){
    squada.add(mathesfromserver['lineup'][i]);
    lista.add(User('User1', 23));
    lista.forEach((user) => playersa[mathesfromserver['lineup'][i]['id']] = mathesfromserver['lineup'][i]['fullname']);

  }
  else{
    squadb.add(mathesfromserver['lineup'][i]);
    lista.add(User('User1', 23));
    lista.forEach((user) => playersb[mathesfromserver['lineup'][i]['id']] = mathesfromserver['lineup'][i]['fullname']);

  }
}
for(int i=0;i<mathesfromserver['batting'].length;i++){
  if(mathesfromserver['batting'][i]['team_id']==teamaid){
    scorecarda.add(mathesfromserver['batting'][i]);
  }else{
    scorecardb.add(mathesfromserver['batting'][i]);
  }

}
        for(int i=0;i<mathesfromserver['bowling'].length;i++){
          if(mathesfromserver['bowling'][i]['team_id']==teamaid){
            bowlingscorecarda.add(mathesfromserver['bowling'][i]);
          }else{
            bowlingscorecardb.add(mathesfromserver['bowling'][i]);
          }

        }
print(scorecarda);
print(scorecardb);
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        // for(int i=0;i<pastmatches.length;i++){
        //   searcharray.add( pastmatches[i]['name']);
        //   print(searcharray.toString());
        // }

      } else {
        print("bjkb" + response.statusCode.toString());
         showToast(response.body);
        setState(() {
          isError = true;
          isLoading = true;
        });
      }
    } catch (e) {
      print(e);
      showToast(e);
      setState(() {
        isError = true;
        isLoading = true;
      });
    }
  }
  void getoutdate() async{
    var url="https://cricket.sportmonks.com/api/v2.0/scores?api_token=${matchkey}";
    setState(() {
      isLoading=true;
    });


    try {
      final response = await http.get(Uri.parse(url),headers: {


      });
      print("bjkb" + response.request.url.toString());
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
       setState(() {
         scoredata=responseJson['data'];
         print("jkjklsdjk"+scoredata.toString());
       });
        List lista=[];
for(int i=0; i<scoredata.length;i++){
 if(scoredata[i]['out']==true){
   lista.add(User('User1', 23));
   lista.forEach((user) => outtypes[scoredata[i]['id']] = scoredata[i]['name']);

 }
}
      }}
      catch(e){

      }
      }
  List<Widget> squadwidget() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < squada.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container
                            (
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage( squada[i]['image_path']),)),
                          ),
                          Container(
                            child: Text(
                               squada[i]['lineup']['captain']==true?squada[i]['fullname']+" (C) ": squada[i]['lineup']['wicketkeeper']==true?squada[i]['fullname']+" (wk) ":squada[i]['fullname'],

                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Container(
                          //   child: Text(
                          //       squada[i]['battingstyle'],
                          //     style: TextStyle(fontSize: 12),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical),
                child: Divider(
                  color: Color(lightBlue),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }
  List<Widget> squadwidgetb() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < squadb.length; i++) {
      squadlist.add(
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.9,
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container
                                (
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage( squadb[i]['image_path']),)),
                              ),
                              Container(
                                child: Text(
                                  squadb[i]['lineup']['captain']==true?squadb[i]['fullname']+" (c) ": squadb[i]['lineup']['wicketkeeper']==true?squadb[i]['fullname']+" (wk) ":squadb[i]['fullname'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Container(
                              //   child: Text(
                              //       squadb[i]['battingstyle'],
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                    child: Divider(
                      color: Color(lightBlue),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
    return squadlist;
  }
  List<Widget> battingorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < scorecarda.length; i++) {
      squadlist.add(
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.9,
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      playersa[scorecarda[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecarda[i]['score_id']]==null?"Not Out":outtypes[ scorecarda[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecarda[i]['score_id']].toString()=="Clean Bowled"?"b " +playersb[scorecarda[i]['bowling_player_id']]:outtypes[ scorecarda[i]['score_id']].toString()=="LBW OUT"?"lbw "+playersb[scorecarda[i]['bowling_player_id']]:outtypes[ scorecarda[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecarda[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecarda[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          "${scorecarda[i]['catch_stump_player_id']!=null? playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?playersb[scorecarda[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecarda[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecarda[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"Not Out":
                                      playersb[scorecarda[i]['runout_by_id']]!=null?"& "+playersb[scorecarda[i]['runout_by_id']]:"b "+playersb[scorecarda[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                 scorecarda[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecarda[i]["rate"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.01,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
    return squadlist;
  }
  List<Widget> batting2ndorder() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < scorecardb.length; i++) {
      squadlist.add(
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.9,
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal*40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      playersb[scorecardb[i]['player_id']].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outtypes[ scorecardb[i]['score_id']]==null?"Not Out":outtypes[ scorecardb[i]['score_id']].toString()=="Catch Out"?"c ":outtypes[ scorecardb[i]['score_id']].toString()=="Clean Bowled"?"b " +playersa[scorecardb[i]['bowling_player_id']]:outtypes[ scorecardb[i]['score_id']].toString()=="LBW OUT"?"lbw "+playersa[scorecardb[i]['bowling_player_id']]:outtypes[ scorecardb[i]['score_id']].toString()=="Run Out"?"run out ":outtypes[ scorecardb[i]['score_id']].toString().substring(0,2)+" ",maxLines: 1,softWrap: true,overflow: TextOverflow.clip
                                          // scorecarda[i]['bowling_player_id']==null&&scorecarda[i]['catch_stump_player_id']==null&&scorecarda[i]['runout_by_id']==null?"":
                                          // "${scorecarda[i]['catch_stump_player_id']!=null?"c "+ playersb[scorecarda[i]['catch_stump_player_id']]:scorecarda[i]['runout_by_id']!=null?"rn"+playersb[scorecarda[i]['runout_by_id']]:""}",
                                          , style: TextStyle(color: outtypes[ scorecardb[i]['score_id']]==null?Colors.green:Colors.red,fontSize: 12),
                                        ),
                                        Text(
                                          scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?"":
                                          "${scorecardb[i]['catch_stump_player_id']!=null? playersa[scorecardb[i]['catch_stump_player_id']]:scorecardb[i]['runout_by_id']!=null?playersa[scorecardb[i]['runout_by_id']]:""}",
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    //
                                    scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?Container():
                                    outtypes[ scorecardb[i]['score_id']].toString()=="Clean Bowled"?Container():
                                    outtypes[ scorecardb[i]['score_id']].toString()=="LBW OUT"?Container():

                                    Text(
                                      scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null?"Not Out":
                                      playersa[scorecardb[i]['runout_by_id']]!=null?"& "+playersa[scorecardb[i]['runout_by_id']]:"b "+playersa[scorecardb[i]['bowling_player_id']]
                                          .toString(),
                                      style: TextStyle(fontSize: 12,color:scorecardb[i]['bowling_player_id']==null&&scorecardb[i]['catch_stump_player_id']==null&&scorecardb[i]['runout_by_id']==null? Colors.green:Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]['score'].toString()
                                  ,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]['ball']
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["four_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["six_x"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width:
                                SizeConfig.screenWidth *
                                    0.05,
                                child: Text(
                                  scorecardb[i]["rate"]
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
    return squadlist;
  }
  List<Widget> bowlingorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingscorecarda.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 playersa[bowlingscorecarda[i]['player_id']]
                                 ,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['overs'].toString()
                              ,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['runs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['wickets']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['medians']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecarda[i]['rate']
                                  .toString(),maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                child: Divider(
                  thickness: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List<Widget> bowlingsecondorderlist() {
    List<Widget> squadlist = new List();
    for (int i = 0; i < bowlingscorecardb.length; i++) {
      squadlist.add(Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(


                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.9,
                      margin:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  playersb[bowlingscorecardb[i]['player_id']],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]['overs']
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
                              ["runs"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
                              ["wickets"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
                              ["medians"]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width:
                            SizeConfig.screenWidth *
                                0.05,
                            child: Text(
                              bowlingscorecardb[i]
                              ["rate"]
                                  .toString(),maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    ),
                child: Divider(
                  thickness: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return squadlist;
  }

  List <Widget>balls(){
    List<Widget> balllist = new List();
    for (int i = recentballs.length-1; i >= 0; i--) {
      balllist.add(Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5,),
                CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(recentballs[i]['ball'].toString(),style: TextStyle(color: Colors.white,fontSize:12,fontWeight: FontWeight.w600),),),
                SizedBox(width: 5,),
                Text(recentballs[i]['bowler']['fullname'].toString(),style: TextStyle(fontSize:12,)),
                SizedBox(width: 5,),
                Text("to"),
                SizedBox(width: 5,),
                Text(recentballs[i]['batsman']['fullname'].toString()+" :",style: TextStyle(fontSize:12,)),
                SizedBox(width: 5,),
                Text(recentballs[i]['score']['name'].toString(),maxLines:2,style: TextStyle(fontWeight: FontWeight.w600,fontSize:12),),


              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ));
  }
return balllist;
}}