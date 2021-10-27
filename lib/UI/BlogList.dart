import 'dart:convert';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:CricScore_App/UI/quizdialog.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'OpenBlog.dart';
import 'Topstorydetail.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key key}) : super(key: key);

  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  bool isError = false;
  bool isLoading = false;
  List<String> teams = [
    'assets/bg/team1.png',
    'assets/bg/team2.png',
    'assets/bg/team3.png',
    'assets/bg/team4.png',
    'assets/bg/team1.png',
    'assets/bg/team2.png',
    'assets/bg/team3.png',
    'assets/bg/team4.png'
  ];
  @override
  void initState() {
    getnews();
    _createInterstitialAd();
    _createRewardedAd();
    // TODO: implement initState
    super.initState();
  }
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
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }

    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text(
          "News",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Image.asset(
        //     'assets/icons/back.png',
        //     scale: SizeConfig.blockSizeVertical * 0.5,
        //   ),
        // ),
        elevation: 0.0,
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
      body: Container(

        child: Column(

          children: [
           
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight*0.72,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical),
              child: ListView(children: newswidget())
                // Container(
                //   height: SizeConfig.blockSizeVertical * 32,
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           bottomRight: Radius.circular(10),
                //           bottomLeft: Radius.circular(10),
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10)),
                //     ),
                //     child: Column(
                //       children: [
                //         ClipRRect(
                //            borderRadius: BorderRadius.only(
                //
                //       topLeft: Radius.circular(10),
                //       topRight: Radius.circular(10)),
                //             child: Image.asset(
                //               "assets/bg/cricketTeam.jpg",
                //               fit: BoxFit.fitWidth,
                //               height: SizeConfig.blockSizeVertical * 18,
                //               width: SizeConfig.screenWidth,
                //             )),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //
                //           child: Text(
                //             "Lorem Ipsum Title of news Eng vs AUS match in lords",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //           child: Text(
                //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   height: SizeConfig.blockSizeVertical * 32,
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           bottomRight: Radius.circular(10),
                //           bottomLeft: Radius.circular(10),
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10)),
                //     ),
                //     child: Column(
                //       children: [
                //         ClipRRect(
                //             borderRadius: BorderRadius.only(
                //
                //                 topLeft: Radius.circular(10),
                //                 topRight: Radius.circular(10)),
                //             child: Image.asset(
                //               "assets/bg/cricketTeam.jpg",
                //               fit: BoxFit.fitWidth,
                //               height: SizeConfig.blockSizeVertical * 18,
                //               width: SizeConfig.screenWidth,
                //             )),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //
                //           child: Text(
                //             "Lorem Ipsum Title of news Eng vs AUS match in lords",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //           child: Text(
                //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   height: SizeConfig.blockSizeVertical * 32,
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           bottomRight: Radius.circular(10),
                //           bottomLeft: Radius.circular(10),
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10)),
                //     ),
                //     child: Column(
                //       children: [
                //         ClipRRect(
                //             borderRadius: BorderRadius.only(
                //
                //                 topLeft: Radius.circular(10),
                //                 topRight: Radius.circular(10)),
                //             child: Image.asset(
                //               "assets/bg/cricketTeam.jpg",
                //               fit: BoxFit.fitWidth,
                //               height: SizeConfig.blockSizeVertical * 18,
                //               width: SizeConfig.screenWidth,
                //             )),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //
                //           child: Text(
                //             "Lorem Ipsum Title of news Eng vs AUS match in lords",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //           child: Text(
                //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   height: SizeConfig.blockSizeVertical * 32,
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           bottomRight: Radius.circular(10),
                //           bottomLeft: Radius.circular(10),
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10)),
                //     ),
                //     child: Column(
                //       children: [
                //         ClipRRect(
                //             borderRadius: BorderRadius.only(
                //
                //                 topLeft: Radius.circular(10),
                //                 topRight: Radius.circular(10)),
                //             child: Image.asset(
                //               "assets/bg/cricketTeam.jpg",
                //               fit: BoxFit.fitWidth,
                //               height: SizeConfig.blockSizeVertical * 18,
                //               width: SizeConfig.screenWidth,
                //             )),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //
                //           child: Text(
                //             "Lorem Ipsum Title of news Eng vs AUS match in lords",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(5),
                //           child: Text(
                //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "),
                //         )
                //       ],
                //     ),
                //   ),
                // ),

            ),
            if (_anchoredBanner != null)
              Container(
                color: Colors.white,
                width: _anchoredBanner.size.width.toDouble(),
                height: _anchoredBanner.size.height.toDouble(),
                child: AdWidget(ad: _anchoredBanner),
              ),
          ],
        ),
      ),
    ));
  }

  dynamic newsfromserver = new List();
  void getnews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'http://18.216.40.7/api/get-news'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        newsfromserver = responseJson['top-news'];

        print(newsfromserver);

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

  List<Widget> newswidget() {
    List<Widget> productList = new List();
    for (int i = newsfromserver.length-1; i >=0; i--) {
      productList.add(
        GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>topstorydetail(
                image:newsfromserver[i]['image'],
                title:newsfromserver[i]['title'],
                description:newsfromserver[i]['description']


            )));
          },
          child: Container(
            padding: EdgeInsets.all(4),
            height: SizeConfig.blockSizeVertical * 32,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(

                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        newsfromserver[i]['image'],
                        fit: BoxFit.fitWidth,
                        height: SizeConfig.blockSizeVertical * 15,
                        width: SizeConfig.screenWidth,
                      )),
                  Container(
                    padding: EdgeInsets.all(5),

                    child: Text(
                        newsfromserver[i]['title'],maxLines:2, textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      newsfromserver[i]['description'],maxLines:2, textAlign: TextAlign.justify,),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return productList;
  }
}
