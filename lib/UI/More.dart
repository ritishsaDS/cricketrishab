import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:CricScore_App/UI/PlayerRanking.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:CricScore_App/Utils/models/recentmatches.dart';
import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/Team.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'Privacy.dart';
import 'TeamRanking.dart';
import 'Womenranking.dart';
import 'Womenrankingplayer.dart';

class Morescreen extends StatefulWidget{
  @override
  _MorescreenState createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  String testDevice = 'YOUR_DEVICE_ID';
  int maxFailedLoadAttempts = 3;
  int item = 0;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  String appName;
  String packageName;
  String version;
  String buildNumber;
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
  void initState() {
    _createInterstitialAd();
    _createRewardedAd();
    packagedetail();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,

        title:  Text(
        "More",
        style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
    ),
    ),

    ),
      body: SafeArea(child:
      Stack(
        children: [

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

            child: Column(
            children: [
              Card(
                elevation: 3,
                child: Column(children: [
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Teams()));
                  },
                  leading: Image.asset("assets/icons/team.png"),
                  title: Text("Browse Teams"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
                ListTile(
                  leading: Image.asset("assets/icons/trophy.png"),
                  title: Text("Browse Series"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
                ListTile(
                  leading: Image.asset("assets/icons/user.png"),
                  title: Text("Browse Players"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],),),
              Divider(
                height: 5,
                thickness: 1,
                color: Colors.grey[200],
              ),
              Card(
                elevation: 3,
                child: Column(children: [
                ListTile(
                  onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamRanking()));

                  },
                  leading: Image.asset("assets/icons/youtube.png"),
                  title: Text("Youtube"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
                ListTile(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Womenranking()));
                  },
                  leading: Image.asset("assets/icons/insta.png"),
                 // trailing: Icon(Icons.send),
                  title: Text("Instagram"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
                ListTile(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerRanking()));

                  },
                  leading: Image.asset("assets/icons/fb.png"),
                  ///trailing: Icon(Icons.send),
                  title: Text("Facebook"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],),),
              Card(
                elevation: 3,
                child: Column(children: [
                  ListTile(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamRanking()));

                    },
                    leading: Image.asset("assets/icons/settings.png"),
                    // trailing: Icon(Icons.send),
                    title: Text("Settings"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Privacy()));
                    },
                    leading: Image.asset("assets/icons/privacy.png"),
                    // trailing: Icon(Icons.send),
                    title: Text("Privacy Policy"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),

                ],),),
            Text("App Version: "+version),
            Expanded(child: SizedBox()),
              if (_anchoredBanner != null)
                Container(
                  color: Colors.white,
                  width: _anchoredBanner.size.width.toDouble(),
                  height: _anchoredBanner.size.height.toDouble(),
                  child: AdWidget(ad: _anchoredBanner),
                ),
            ],
          ),),
        ],
      ),),
    );
  }
packagedetail(){
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    setState(() {
      appName      = packageInfo.appName;
      packageName = packageInfo.packageName;
      version     = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  });
}
}