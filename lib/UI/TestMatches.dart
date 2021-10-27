import 'dart:convert';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Completedmatchdetail.dart';
import 'TestMatchdetail.dart';
class TestMatches extends StatefulWidget{
  dynamic t20;
  dynamic one;
  dynamic test;
  var status;
  TestMatches({this.test,this.status});
  @override

  _UpcomingtabState createState() => _UpcomingtabState();
}

class _UpcomingtabState extends State<TestMatches> {
  bool isError=false;
  bool isLoading=false;
  var pastmatches=[];
  var selectedDate;
  var today;
  @override
  void initState() {
    selectedDate = DateTime.now();
    today = DateTime.now();
    getmatches();
    // TODO: implement initState
    super.initState();
  }
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
    return Scaffold(
      //  backgroundColor: Color(lightBlue),
        body:isLoading?Center(child: CircularProgressIndicator()):Container(
          child: mathesfromserver.length==0?Container(
            alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                ],
              )):Column(
                children: [
                  Container(
                    height: SizeConfig.screenHeight*0.635,
                    child: ListView(children:
           getEvetnts()
            ,),
                  ), if (_anchoredBanner != null)
                    Container(
                      color: Colors.green,
                      width: _anchoredBanner.size.width.toDouble(),
                      height: _anchoredBanner.size.height.toDouble(),
                      child: AdWidget(ad: _anchoredBanner),)

                ],
              ),
        )

    );

  }

  dynamic mathesfromserver=new List();
  var loacalteamid;
  var visitorteamid;
  void getmatches() async {
    var url;
    setState(() {
      isLoading=true;
    });
    if(widget.status=="recent"){
      url="https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=${matchkey}&include=runs,visitorteam,localteam,batting,bowling,league,stage,balls,firstUmpire,referee,venue&filter[status]=Finished&filter[starts_between]=${DateTime(today.year, today.month - 3, today.day).toString().substring(0,10)},${DateTime(today.year, today.month , today.day+1).toString().substring(0,10)}&filter[type]=Test/5Day&sort=starting_at";
    }
    else{
      url='https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=${matchkey}&include=runs,visitorteam,localteam,batting,bowling,league,stage,balls,firstUmpire,venue,referee&filter[type]=Test/5Day&filter[status]=NS&sort=starting_at';
    }
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var newDate = new DateTime(selectedDate.year, selectedDate.month , selectedDate.day+1);
    print(newDate);
    try {
      final response = await http.get(Uri.parse(url),headers: {
        "rs-token":prefs.getString("token")

      });
      print("bjkb" + response.request.url.toString());
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        mathesfromserver=responseJson['data'];
        print(mathesfromserver);
//        responseJson['data'];
// pastmatches=responseJson['data']['matches'];
//         print( pastmatches[0]['play']['innings']['b_1']['score_str']);

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
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = true;
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
  List<Widget> getEvetnts() {
    List<Widget> productList = new List();
    if(widget.status=="recent"){
      for(int i= mathesfromserver.length-1; i>=0;i--){
        loacalteamid=mathesfromserver[i]['localteam_id'];
        visitorteamid=mathesfromserver[i]['visitorteam_id'];
        var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
        String updatedDt = newFormat.format(DateTime.parse("2021-09-19T14:00:00.000000Z"));
        print(DateTime.parse("2021-09-19T14:00:00.000000Z").toLocal());
        print("updatedDt");
        // DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(mathesfromserver[i]['start_at'].toString().substring(0,10)) * 1000);
        // print(date.toString().substring(5,10).toString().split('-')[0]);
        productList.add( GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Testmatchdetail(id:mathesfromserver[i]['id'],status: widget.status,)));
            // if(mathesfromserver[i]['status']=='completed'){
            //
            // }
            // else if(mathesfromserver[i]['status']=='not_started'){
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => NotLivematch(shortname:mathesfromserver[i]['tournament']['short_name'],matchnumber:mathesfromserver[i]['tournament']['name']+' , '+mathesfromserver[i]['sub_title'],match:mathesfromserver[i],status:"not_started",deatil:(date.toString().substring(5,10)).toString().split('-')[1]+"th"+" - "+months[int.parse((date.toString().substring(5,10)).toString().split('-')[0])]+"  "+ DateFormat.jm().format(DateTime.parse(date.toString())))));
            //
            // }
            // else{
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => Livematch(shortname:mathesfromserver[i]['tournament']['short_name'],matchnumber:mathesfromserver[i]['tournament']['name']+' , '+mathesfromserver[i]['sub_title'],match:mathesfromserver[i],status:"started",deatil:(date.toString().substring(5,10)).toString().split('-')[1]+"th"+" - "+months[int.parse((date.toString().substring(5,10)).toString().split('-')[0])]+"  "+ DateFormat.jm().format(DateTime.parse(date.toString())))));
            //
            // }

          },
          child: Container(
            margin: EdgeInsets.all(5),
            // padding: EdgeInsets.all(5),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Container(

                padding: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          mathesfromserver[i]['league']['name']+" , "+mathesfromserver[i]['round'],
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateTime.parse(mathesfromserver[i]["starting_at"]).toLocal().toString().substring(0,16),
                          style: TextStyle(fontSize: 12),
                        ),

                        // Text(
                        //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                        // )
                      ],
                    ),
                    Text(mathesfromserver[i]['status']=="NS"?"Upcoming":"Completed" ,
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),

                    SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(   height: 40,
                          width: 40,

                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage( mathesfromserver[i]['localteam']['image_path'],
                              ),fit: BoxFit.fill)),

                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          mathesfromserver[i]['localteam']['code'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                        mathesfromserver[i]['runs'][0]['team_id']==loacalteamid?
                        Text(
                            mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][0]['score'].toString()+"/"+mathesfromserver[i]['runs'][0]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][0]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)): Text(
                            mathesfromserver[i]['runs'].length==1?"":mathesfromserver[i]['runs'][1]['score'].toString()+"/"+mathesfromserver[i]['runs'][1]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][1]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),

                        SizedBox(
                          width: 4,
                        ),
                        Text("&"),
                        SizedBox(
                          width: 4,
                        ),
mathesfromserver[i]['runs'][2]['team_id']==loacalteamid?
Text(
    mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][2]['score'].toString()+"/"+mathesfromserver[i]['runs'][2]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][2]['overs'].toString()+")"
    ,
    style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold)): Text(
    mathesfromserver[i]['runs'].length==3?"":mathesfromserver[i]['runs'][3]['score'].toString()+"/"+mathesfromserver[i]['runs'][3]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][3]['overs'].toString()+")"
    ,
    style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(   height: 40,
                          width: 40,

                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(  mathesfromserver[i]['visitorteam']['image_path']  ))),

                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          mathesfromserver[i]['visitorteam']['code'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                        mathesfromserver[i]['runs'][1]['team_id']==visitorteamid?
                        Text(
                            mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][1]['score'].toString()+"/"+mathesfromserver[i]['runs'][1]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][1]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)): Text(
                            mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][0]['score'].toString()+"/"+mathesfromserver[i]['runs'][0]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][0]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 4,
                        ),
                        Text("&"),
                        mathesfromserver[i]['runs'][2]['team_id']==visitorteamid?
                        Text(
                            mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][2]['score'].toString()+"/"+mathesfromserver[i]['runs'][2]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][2]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                       :
                        Text(
                            mathesfromserver[i]['runs'].length==3?"":mathesfromserver[i]['runs'][3]['score'].toString()+"/"+mathesfromserver[i]['runs'][3]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][3]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width: SizeConfig.screenWidth*0.8,
                          child: Center(
                              child:
                              Text(

                                mathesfromserver[i]['note'],overflow: TextOverflow.ellipsis,softWrap: true,
                                style: TextStyle(fontSize: 12,color: Colors.red,fontWeight: FontWeight.bold),
                                maxLines: 2,
                              )
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),);
      }
    }
    else{
      for(int i= 0; i<mathesfromserver.length;i++){
        // DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(mathesfromserver[i]['start_at'].toString().substring(0,10)) * 1000);
        // print(date.toString().substring(5,10).toString().split('-')[0]);
        productList.add( GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Completedmatchdetail(id:mathesfromserver[i]['id'],status: widget.status)));

            // if(mathesfromserver[i]['status']=='completed'){
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => NotLivematch(shortname:mathesfromserver[i]['tournament']['short_name'],matchnumber:mathesfromserver[i]['tournament']['name']+' , '+mathesfromserver[i]['sub_title'],match:mathesfromserver[i],status:"completed",deatil:(date.toString().substring(5,10)).toString().split('-')[1]+"th"+" - "+months[int.parse((date.toString().substring(5,10)).toString().split('-')[0])]+"  "+ DateFormat.jm().format(DateTime.parse(date.toString())))));
            //
            // }
            // else if(mathesfromserver[i]['status']=='not_started'){
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => NotLivematch(shortname:mathesfromserver[i]['tournament']['short_name'],matchnumber:mathesfromserver[i]['tournament']['name']+' , '+mathesfromserver[i]['sub_title'],match:mathesfromserver[i],status:"not_started",deatil:(date.toString().substring(5,10)).toString().split('-')[1]+"th"+" - "+months[int.parse((date.toString().substring(5,10)).toString().split('-')[0])]+"  "+ DateFormat.jm().format(DateTime.parse(date.toString())))));
            //
            // }
            // else{
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => Livematch(shortname:mathesfromserver[i]['tournament']['short_name'],matchnumber:mathesfromserver[i]['tournament']['name']+' , '+mathesfromserver[i]['sub_title'],match:mathesfromserver[i],status:"started",deatil:(date.toString().substring(5,10)).toString().split('-')[1]+"th"+" - "+months[int.parse((date.toString().substring(5,10)).toString().split('-')[0])]+"  "+ DateFormat.jm().format(DateTime.parse(date.toString())))));
            //
            // }

          },
          child: Container(
            margin: EdgeInsets.all(5),
            // padding: EdgeInsets.all(5),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Container(

                padding: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          mathesfromserver[i]['league']['name']+" , "+mathesfromserver[i]['round'],
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          DateTime.parse(mathesfromserver[i]["starting_at"]).toLocal().toString().substring(0,16),
                        )
                      ],
                    ),
                    Text(mathesfromserver[i]['status']=="NS"?"Upcoming":"Completed" ,
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),

                    SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(   height: 40,
                          width: 40,

                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage( mathesfromserver[i]['localteam']['image_path'],
                              ),fit: BoxFit.fill)),

                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          mathesfromserver[i]['localteam']['name'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),

                        Text(
                            mathesfromserver[i]['runs'].length==0?"":mathesfromserver[i]['runs'][0]['score'].toString()+"/"+mathesfromserver[i]['runs'][0]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][0]['overs'].toString()+")"
                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),

                        SizedBox(
                          width: 7,
                        ),
                      ],
                    ),
                    SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(   height: 40,
                          width: 40,

                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(  mathesfromserver[i]['visitorteam']['image_path']  ))),

                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          mathesfromserver[i]['visitorteam']['name'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                            mathesfromserver[i]['runs'].toString()=="[]"?"":mathesfromserver[i]['runs'][1]['score'].toString()+"/"+mathesfromserver[i]['runs'][1]['wickets'].toString()+" ("+mathesfromserver[i]['runs'][1]['overs'].toString()+")"


                            ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 7,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width: SizeConfig.screenWidth*0.8,
                          child: Center(
                              child:
                              Text(

                                mathesfromserver[i]['venue']==null?"":mathesfromserver[i]['venue']['name']+" , "+mathesfromserver[i]['venue']['city'],overflow: TextOverflow.ellipsis,softWrap: true,
                                style: TextStyle(fontSize: 12,color: Colors.red,fontWeight: FontWeight.bold),
                                maxLines: 2,
                              )
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),);
      }
    }

    return productList;
  }
}