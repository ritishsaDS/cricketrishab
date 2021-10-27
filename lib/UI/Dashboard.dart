import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:CricScore_App/UI/TestMatchdetail.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'package:http/http.dart' as http;
import 'package:CricScore_App/UI/LiveMatchdetail.dart';
import 'package:CricScore_App/UI/LoginScreen.dart';
import 'package:CricScore_App/UI/Quizmain.dart';
import 'package:CricScore_App/UI/quizdialog.dart';
import 'package:CricScore_App/UI/testingadd.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Completedmatchdetail.dart';
import 'Notlivematch.dart';
import 'Livematches.dart';
import 'QUizScreen.dart';
import 'Quizmatches.dart';
import 'Topstories.dart';
import 'Topstorydetail.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  static const double padding = 16;
  static const double spacing = 8;
  static const int crossAxisCount = 2;
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
  List<String> teams = [
    'assets/bg/team1.png',
    "assets/icons/wi.png",
    'assets/bg/team4.png',
    "assets/icons/pak.png",
    "assets/icons/zim.png",
    'assets/bg/team3.png',
    "assets/icons/eng.png",
    'assets/bg/team2.png',
    "assets/icons/sl.png",
    "assets/icons/Sa.png",
    "assets/icons/ire.png",
  ];
  List<String> teamName = [
    "India (IND)",
    "West Indies (WI)",
    "Bangladesh (BAN)",
    "Pakistan (PAK)",
    "Zimbabwe (ZIM)",
    "Australia (AUS)",
    "England (ENG)",
    "NewZealand (NZ)",
    "Sri Lanka (SL)",
    "South Africa (SA)",
    "Ireland (IRE)",
  ];
  GoogleSignInAccount _userObj;
  bool isLoggedIn = false;
  var profileData;
  Map userfb = {};
  //var facebookLogin = FacebookLogin();
  int _radioValue = 1;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<String> teamsquad = [
    "Rohit Sharma, Shubman Gill, Mayank Agarwal, Cheteshwar Pujara, Virat Kohli (Captain), Ajinkya Rahane (vice-captain), Hanuma Vihari, Rishabh Pant (wicket-keeper), R. Ashwin, Ravindra Jadeja, Axar Patel, Washington Sundar, Jasprit Bumrah, Ishant Sharma, Mohd. Shami, Md. Siraj, Shardul Thakur, Umesh Yadav, KL Rahul , Wriddhiman Saha (wicket-keeper). ",
    "Chris Gayle,Darren Bravo,Evin Lewis,Lendl Simmons,Shimron Hetmyer,Andre Russell, Dwayne Bravo, Fabian Allen,Jason Holder, Kieron Pollard, Andre Fletcher, Nicholas Pooran,Akeal Hosein, Fidel Edwards,Hayden Wals, Kevin Sinclai,Obed McCoy,Oshane Thomas,Romario Shepherd,",
    "Mohammad Naim,Mosaddek Hossain,Afif Hossain,Mahedi Hasan, Mahmudullah, ,Mohammad Saifuddin, Shamim Hossain, Shamim Hossain, Soumya Sarkar,Mohammad Mithun, Mohammad Mithun,Nurul Hasan",
    "Abdullah Shafique,Abid Ali,Azhar Ali,Babar Azam,Fawad Alam,Imran Butt,Faheem Ashraf,Mohammad Nawaz,Saud Shakeel,Mohammad Rizwan,Sarfaraz Ahmed,Haris Rauf,Hasan Ali,Mohammad Abbas,Naseem Shah,Nauman Ali,Sajid Khan,Shaheen Afridi,Shahnawaz Dhani,Yasir Shah,Zahid Mahmood",
    "Shumba,Milton Shumba,Tarisai MusakandA,Tinashe Kamunhukamwe,Wesley Madhevere,Dion Myers,Ryan Burl,Sikandar Raza,Regis Chakabva,Tadiwanashe Marumani,Blessing Muzarabani,Donald Tiripano,Luke Jongwe,Richard Ngarava,Tendai Chatara",
    "Ashton Turner,Ben McDermott,Ashton Agar,Dan Christian,Mitchell Marsh,Moises Henriques,Alex Carey,Josh Philippe,Matthew Wade,Adam Zampa,Andrew Tye,Jason Behrendorff,Josh Hazlewood,Mitchell Starc,Mitchell Swepson,Nathan Ellis,Riley Meredith,Tanveer Sangha,Wes Agar",
    "Joe Root (Yorkshire) , James Anderson,Jonny Bairstow (Yorkshire),Dom Bess (Yorkshire), Stuart Broad (Nottinghamshire), Rory Burns (Surrey), Jos Buttler (Lancashire), Zak Crawley (Kent), Sam Curran (Surrey), Haseeb Hameed (Nottinghamshire), Dan Lawrence (Essex), Jack Leach (Somerset), Ollie Pope (Surrey), Ollie Robinson (Sussex), Dom Sibley (Warwickshire), Ben Stokes (Durham), Mark Wood (Durham)",
    "Devon Conway, Henry Nicholls,Kane Williamson, Ross Taylor,Will Young, Colin de Grandhomme, BJ Watling,Tom Blundell, Tom Latham,Ajaz Patel, Kyle Jamieson,Matt Henry, Neil Wagner,Tim Southee, Trent Boult",
    " Asghar Afghan,Fareed Ahmad,Hashmatullah Shahidi,Ibrahim Zadran,Najibullah Zadran,Usman Ghani,Karim Janat,Mohammad Nabi,Sharafuddin Ashraf,Afsar Zazai,Rahmanullah Gurbaz,Amir Hamza,Fazal Haque,Naveen-ul-Haq,Rashid Khan",
    "Aiden Markram,David Miller, Janneman Malan, Rassie van der Dussen, Reeza Hendricks, Temba Bavuma, Andile Phehlukwayo, George Linde, Wiaan Mulder, Heinrich Klaasen, Kyle Verreynne, Quinton de Kock, Anrich Nortje, Beuran Hendricks, Bjorn Fortuin, Kagiso Rabada, Keshav Maharaj, Lizaad Williams, Lungi Ngidi, Tabraiz Shamsi",
    "Andy Balbirnie, Harry Tector,William McClintock, George Dockrell,Kevin OBrien, Mark Adair,Paul Stirling, Shane Getkate,Simi Singh, Lorcan Tucker,Stephen Doheny, Barry McCarthy,Benjamin White, Craig Young,Josh Little"
  ];
  List<String> teamsname = [
    "India",
    "New Zealand",
    "Australia",
    "Bangladesh",
    "Sri Lanka",
    "West Indies",
    "Zimbabwe",
    "South Africa",
    "Pakistan",
    "England",
    "Ireland",
  ];
  get newItemCount => (teams.length / crossAxisCount).round();
  final _currentPageNotifier = ValueNotifier<int>(0);
  void jumpToItem(int item) {
    final width = controller.position.maxScrollExtent +
        context.size.width -
        padding * 2 +
        spacing;
    final value = item / newItemCount * width;
    final valueSpace = padding + value;
    final newValue = valueSpace > controller.position.maxScrollExtent
        ? controller.position.maxScrollExtent
        : valueSpace;
    controller.jumpTo(newValue);
  }

  // BooksApi booksApi = BooksApi();
  PageController controllers;

  // GlobalKey<PageContainerState> key = GlobalKey();

  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  bool _isRewardedVideoComplete = false;

  /// All widget ads are stored in this variable. When a button is pressed, its
  /// respective ad widget is set to this variable and the view is rebuilt using
  /// setState().
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );




  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "4643035165748950_4643194452399688",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
          _isRewardedVideoComplete = true;

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            value["invalidated"] == true) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }
  int counter = 0;
  bool isError = false;
  bool isLoading = false;
  var selectedDate;
  void _createInterstitialAd() {

    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
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
  final NativeAdListener listener = NativeAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
    // Called when a click is recorded for a NativeAd.
    onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
  );
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
  static final _kAdIndex = 4;
  NativeAd _ad;
  bool _isAdLoaded = false;
  List<Object> itemList = [];

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
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

  void _createNativeAd() {
    NativeAd(
      adUnitId: 'ca-app-pub-1988118332072011/3595640901',
      factoryId: 'adFactoryExample',
      request: AdRequest(),
      listener: NativeAdListener(),
    );
    //print(listener.onAdLoaded());
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
          : 'ca-app-pub-3940256099942544/6300978111',
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


    gettopStories();


    getLivematches();


    getteamlogoStories();
    controllers = PageController();
    selectedDate = DateTime.now();

//    _loadRewardedVideoAd();


  //  getmatches();
    _ad = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();

    for (int i = 1; i <= 20; i++) {
      itemList.add("Row $i");
    }


    super.initState();
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
  // setUpTimedFetch() {
  //   Timer.periodic(Duration(milliseconds: 3000), (timer) {
  //     getlivescore();
  //     // print("jnern"+timer.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
    child:
          SafeArea(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.33,
            width: SizeConfig.screenWidth,
            color: Color(lightBlue),
            padding: EdgeInsets.all(10),
            child: Container(
              // height: 120.0,

              child: Column(
                children: [
                  Container(
                    height: SizeConfig.screenHeight * 0.27,
                    child: PageView(
                      onPageChanged: (int index) {
                        _currentPageNotifier.value = index;
                      },
                      children: featuredwidegt(),
                      controller: controllers,
                      reverse: false,
                    ),
                  ),
                  _buildCircleIndicator()
                ],
              ),
            ),
          ),
          Expanded(

            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal, vertical: SizeConfig.blockSizeVertical),

                    height: SizeConfig.screenHeight*0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(image:
                    AssetImage('assets/bg/quizbg.png',
                       ), fit: BoxFit.cover)),
                  child: (

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cricket Quiz', textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical*3.0),
                          ),
                          Text("( Play & Get A Chance to win Amazing Prizes )" ,style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeVertical*2
                              ),),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: SizeConfig.screenWidth*0.3,
                            height: SizeConfig.blockSizeVertical*4,
                            child: ElevatedButton(
                              onPressed: () async {

                                 SharedPreferences prefs=await SharedPreferences.getInstance();

if(prefs.getString("name")==null){
  showDialog<String>(
    context: context,

    builder: (BuildContext context) => new AlertDialog(

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
                Navigator.pop(context);

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
                Navigator.pop(context);
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
  );
}
else{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Quizscreen()));
}

                                 }


                              ,
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.red),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.red),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Colors.red)))),
                              child: Text(
                                "Play Now",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Colors.white,

                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
      )
                ),

                Container(
                  width: SizeConfig.screenWidth,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Topstories()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top Stories",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(darkGrey),
                                    fontSize: 16),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(lightBlue),
                                size: SizeConfig.blockSizeVertical * 2,
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenHeight*0.29,
                        child: ListView(

                          children: postswidget(),),

                      ),

                      if (_anchoredBanner != null)
                        Container(
                          color: Colors.green,
                          width: _anchoredBanner.size.width.toDouble(),
                          height: _anchoredBanner.size.height.toDouble(),
                          child: AdWidget(ad: _anchoredBanner),
                        ),
                     // facebookadd()

                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    ),
      ),
    );
  }

 Widget facebookadd(){
     FacebookInterstitialAd.loadInterstitialAd(
      placementId: "560229535066729_567679134321769",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
         {
           print("jknvo");
           FacebookInterstitialAd.showInterstitialAd(delay: 5000);
         }
        else{
          print("jknvoddd");
          Container();
        }

      },
    );

}

  _buildCircleIndicator() {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeVertical*2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: unlivematch.length,
          borderColor: Colors.white,
          dotColor: Colors.white10,
          selectedDotColor: Colors.white,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }


  // void getToken() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     final response = await http.post(
  //         Uri.parse(
  //             'https://api.sports.roanuz.com/v5/core/RS_P_1415363533180375074/auth/'),
  //         body: {"api_key": "RS5:9486681fcf348b8c98a99b81860703bf"});
  //     print("bjssskb" + response.request.url.toString());
  //     if (response.statusCode == 200) {
  //       final responseJson = json.decode(response.body);
  //       print(responseJson);
  //       token = responseJson['data']['token'];
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString("token", token);
  //       getfeaturedmatches();
  //       getLivematches();
  //       setState(() {
  //         isError = false;
  //         isLoading = false;
  //         print('setstate');
  //       });
  //       // for(int i=0;i<pastmatches.length;i++){
  //       //   searcharray.add( pastmatches[i]['name']);
  //       //   print(searcharray.toString());
  //       // }
  //
  //     }
  //     else {
  //       print("bjkb" + response.statusCode.toString());
  //       // showToast("Mismatch Credentials");
  //       setState(() {
  //         isError = true;
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isError = true;
  //       isLoading = false;
  //     });
  //   }
  // }

  dynamic mathesfromserver = new List();
  var featuresfromserver = [];
  List<dynamic> postsfromserver = new List();
  dynamic livematches = [];
  dynamic unlivematch = [];
  dynamic pastmatch = [];
  dynamic getlogo = [];
  var loacalteamid;
  var visitorteamid;

  void getfeaturedmatches() async {
    setState(() {
      isLoading = true;
    });
   // SharedPreferences prefs = await SharedPreferences.getInstance();
var today;
today=DateTime.now();
    try {
      final response = await get(
          Uri.parse(
              'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=3Me2w6gSy5GD9BKybwa8NPWQkT2PZ5fnfA5RLdYkPBraxSnVfSAnafoDikHu&include=runs,visitorteam,localteam,batting,bowling,league,stage,balls,firstUmpire,referee&filter[status]=Finished&filter[starts_between]=${DateTime(today.year, today.month , today.day-4).toString().substring(0,10)},${DateTime(today.year, today.month , today.day+1).toString().substring(0,10)}&sort=starting_at'),
         );
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        mathesfromserver = responseJson['data'];

        setState(() {
          isError = false;
          isLoading = false;

        });
var count =0;
        for(int i=mathesfromserver.length-1;i>0;i--){
          count =count+1;

           if(count<=3){
             unlivematch.add(mathesfromserver[i]);
           }
else{}


        }
        getpastmatches();
        //mathesfromserver.addAll(livematches[0]);
print("jhbhfddd"+livematches.length.toString());
        print("jhbhf"+mathesfromserver.length.toString());

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
  void getpastmatches() async {
    setState(() {
      isLoading = true;
    });
    var today;
    today=DateTime.now();

    try {
      final response = await get(
          Uri.parse(
              'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=3Me2w6gSy5GD9BKybwa8NPWQkT2PZ5fnfA5RLdYkPBraxSnVfSAnafoDikHu&include=runs,visitorteam,localteam,batting,bowling,venue,league,stage,balls,firstUmpire,referee&filter[status]=NS&filter[starts_between]=${DateTime(today.year, today.month , today.day-1).toString().substring(0,10)},${DateTime(today.year, today.month , today.day+4).toString().substring(0,10)}&sort=starting_at'),
         );
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        pastmatch = responseJson['data'];
        for(int i=0;i<3;i++){
          unlivematch.add(pastmatch[i]);

        }
        setState(() {
          isError = false;
          isLoading = false;

        });


       // livematches.addAll(unlivematch);
        print("jhbhfddd"+livematches.length.toString());
       // print("jhbhf"+mathesfromserver.length.toString());

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
  void getLivematches() async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await get(
        Uri.parse(
            'https://cricket.sportmonks.com/api/v2.0/livescores?api_token=3Me2w6gSy5GD9BKybwa8NPWQkT2PZ5fnfA5RLdYkPBraxSnVfSAnafoDikHu&include=lineup,runs,visitorteam,localteam,batting,bowling,league,stage'),
      );
      print("bjkb" + response.request.url.toString());
      print("bjkblive" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        livematches = responseJson['data'];
        print("jdji"+livematches.length.toString());
        for(int i=0;i<livematches.length;i++){
          unlivematch.add(livematches[i]);

        }

        getfeaturedmatches();
        setState(() {
          isError = false;
          isLoading = false;

        });


        // livematches.addAll(unlivematch);
        print("jhbhfddd"+livematches.length.toString());
        // print("jhbhf"+mathesfromserver.length.toString());

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
  void gettopStories() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await get(
          Uri.parse(
              'http://18.216.40.7/api/get-top-post'),
        );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        postsfromserver = responseJson['top-post'];
       for(int i=5; i>=0;i--){

         print("-------------"+i.toString());
       }
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {

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
  void getteamlogoStories() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await post(
        Uri.parse(
            'http://18.216.40.7/api/getlogo'),
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        teamlogos= responseJson['data'];


        List list=[];
        for(int i=0; i<teamlogos.length;i++){
          list.add(User('User1', 23));
          list.forEach((user) => map[teamlogos[i]['team_key']] = teamlogos[i]['team_logo']);





        }print("kbjkavirdcdddd");
        print(map['csk']);

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {

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

  List<Widget> featuredwidegt() {
    List<Widget> featuredlist = new List();
    {
      for (int i = 0; i < unlivematch.length; i++) {
        loacalteamid = unlivematch[i]['localteam_id'];
        visitorteamid = unlivematch[i]['visitorteam_id'];

        if (unlivematch[i]['status'] != "NS" &&unlivematch[i]['status']!="Finished") {
         if(unlivematch[i]['runs'].length==1){
           if(unlivematch[i]['toss_won_team_id']==loacalteamid&&unlivematch[i]['elected']=="batting"){
             print("local Team Batting");
             featuredlist.add(GestureDetector(
               onTap: () {
                 _showInterstitialAd();
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) =>
                     LiveMatchdetail(
                       id: unlivematch[i]['id'],)));
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
                               unlivematch[i]['league']['name'] + " , " +
                                   unlivematch[i]['round'],
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5,
                                   fontWeight: FontWeight.bold),
                             ),


                           ],
                         ),
                         SizedBox(height: 2,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               DateTime.parse(unlivematch[i]["starting_at"])
                                   .toLocal().toString()
                                   .substring(0, 16),
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5),
                             ),

                             // Text(
                             //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                             // )
                           ],
                         ),
                         Text("Live",
                           style: TextStyle(
                               fontSize: SizeConfig.blockSizeVertical * 1.5,
                               fontWeight: FontWeight.bold,
                               color: Colors.red),),

                         SizedBox(height: 3,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             SizedBox(
                               width: 10,
                             ),
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                     unlivematch[i]['localteam']['image_path'],
                                   ), fit: BoxFit.fill)),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['localteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(unlivematch[i]['runs'][0]['score']
                                 .toString() + "/" +
                                 unlivematch[i]['runs'][0]['wickets']
                                     .toString() + " (" +
                                 unlivematch[i]['runs'][0]['overs']
                                     .toString() + ")"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                       unlivematch[i]['visitorteam']['image_path']))),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['visitorteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(
                                 "0/0 (0.0)"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                               width: SizeConfig.screenWidth * 0.8,
                               child: Center(
                                   child:
                                   Text(

                                     unlivematch[i]['localteam']['name']+" Opt to Bat",
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: true,
                                     style: TextStyle(
                                         fontSize: SizeConfig.blockSizeVertical *
                                             1.4,
                                         color: Colors.red,
                                         fontWeight: FontWeight.bold),
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
           else if(unlivematch[i]['toss_won_team_id']==loacalteamid&&unlivematch[i]['elected']=="bowling"){
             print("local Team choose to bowl");
             featuredlist.add(GestureDetector(
               onTap: () {
                 _showInterstitialAd();
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) =>
                     LiveMatchdetail(
                       id: unlivematch[i]['id'],)));
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
                               unlivematch[i]['league']['name'] + " , " +
                                   unlivematch[i]['round'],
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5,
                                   fontWeight: FontWeight.bold),
                             ),


                           ],
                         ),
                         SizedBox(height: 2,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               DateTime.parse(unlivematch[i]["starting_at"])
                                   .toLocal().toString()
                                   .substring(0, 16),
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5),
                             ),

                             // Text(
                             //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                             // )
                           ],
                         ),
                         Text("Live",
                           style: TextStyle(
                               fontSize: SizeConfig.blockSizeVertical * 1.5,
                               fontWeight: FontWeight.bold,
                               color: Colors.red),),

                         SizedBox(height: 3,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             SizedBox(
                               width: 10,
                             ),
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                     unlivematch[i]['localteam']['image_path'],
                                   ), fit: BoxFit.fill)),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['localteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text("0/0 (0.0)",
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                       unlivematch[i]['visitorteam']['image_path']))),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['visitorteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(unlivematch[i]['runs'][0]['score']
                                 .toString() + "/" +
                                 unlivematch[i]['runs'][0]['wickets']
                                     .toString() + " (" +
                                 unlivematch[i]['runs'][0]['overs']
                                     .toString() + ")"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                               width: SizeConfig.screenWidth * 0.8,
                               child: Center(
                                   child:
                                   Text(

                                     unlivematch[i]['localteam']['name']+" Opt to Bowl",
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: true,
                                     style: TextStyle(
                                         fontSize: SizeConfig.blockSizeVertical *
                                             1.4,
                                         color: Colors.red,
                                         fontWeight: FontWeight.bold),
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
           else if(unlivematch[i]['toss_won_team_id']==visitorteamid&&unlivematch[i]['elected']=="batting"){
             print("visitor Team Batting");
             featuredlist.add(GestureDetector(
               onTap: () {
                 _showInterstitialAd();
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) =>
                     LiveMatchdetail(
                       id: unlivematch[i]['id'],)));
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
                               unlivematch[i]['league']['name'] + " , " +
                                   unlivematch[i]['round'],
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5,
                                   fontWeight: FontWeight.bold),
                             ),


                           ],
                         ),
                         SizedBox(height: 2,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               DateTime.parse(unlivematch[i]["starting_at"])
                                   .toLocal().toString()
                                   .substring(0, 16),
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5),
                             ),

                             // Text(
                             //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                             // )
                           ],
                         ),
                         Text("Live",
                           style: TextStyle(
                               fontSize: SizeConfig.blockSizeVertical * 1.5,
                               fontWeight: FontWeight.bold,
                               color: Colors.red),),

                         SizedBox(height: 3,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             SizedBox(
                               width: 10,
                             ),
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                     unlivematch[i]['localteam']['image_path'],
                                   ), fit: BoxFit.fill)),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['localteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical *2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text("0/0 (0.0)",
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                       unlivematch[i]['visitorteam']['image_path']))),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['visitorteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(unlivematch[i]['runs'][0]['score']
                                 .toString() + "/" +
                                 unlivematch[i]['runs'][0]['wickets']
                                     .toString() + " (" +
                                 unlivematch[i]['runs'][0]['overs']
                                     .toString() + ")"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                               width: SizeConfig.screenWidth * 0.8,
                               child: Center(
                                   child:
                                   Text(

                                     unlivematch[i]['visitorteam']['name']+" Opt to Bat",
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: true,
                                     style: TextStyle(
                                         fontSize: SizeConfig.blockSizeVertical *
                                             1.4,
                                         color: Colors.red,
                                         fontWeight: FontWeight.bold),
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
           else{
             print("local Team choose to bowl");
             featuredlist.add(GestureDetector(
               onTap: () {
                 _showInterstitialAd();
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) =>
                     LiveMatchdetail(
                       id: unlivematch[i]['id'],)));
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
                               unlivematch[i]['league']['name'] + " , " +
                                   unlivematch[i]['round'],
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5,
                                   fontWeight: FontWeight.bold),
                             ),


                           ],
                         ),
                         SizedBox(height: 2,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               DateTime.parse(unlivematch[i]["starting_at"])
                                   .toLocal().toString()
                                   .substring(0, 16),
                               style: TextStyle(
                                   fontSize: SizeConfig.blockSizeVertical * 1.5),
                             ),

                             // Text(
                             //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                             // )
                           ],
                         ),
                         Text("Live",
                           style: TextStyle(
                               fontSize: SizeConfig.blockSizeVertical * 1.5,
                               fontWeight: FontWeight.bold,
                               color: Colors.red),),

                         SizedBox(height: 3,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             SizedBox(
                               width: 10,
                             ),
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                     unlivematch[i]['localteam']['image_path'],
                                   ), fit: BoxFit.fill)),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['localteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical *2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(unlivematch[i]['runs'][0]['score']
                                 .toString() + "/" +
                                 unlivematch[i]['runs'][0]['wickets']
                                     .toString() + " (" +
                                 unlivematch[i]['runs'][0]['overs']
                                     .toString() + ")"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                             Container(height: 40,
                               width: 40,

                               decoration: BoxDecoration(shape: BoxShape.circle,
                                   image: DecorationImage(image: NetworkImage(
                                       unlivematch[i]['visitorteam']['image_path']))),

                             ),
                             SizedBox(
                               width: 7,
                             ),
                             Text(
                               unlivematch[i]['visitorteam']['code'],
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold),
                             ),
                             Expanded(child: SizedBox()),
                             Text(
                                 "0/0 (0.0)"
                                 ,
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: SizeConfig.blockSizeVertical * 2,
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
                               width: SizeConfig.screenWidth * 0.8,
                               child: Center(
                                   child:
                                   Text(

                                     unlivematch[i]['visitorteam']['name']+" Opt to Bowl",
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: true,
                                     style: TextStyle(
                                         fontSize: SizeConfig.blockSizeVertical *
                                             1.4,
                                         color: Colors.red,
                                         fontWeight: FontWeight.bold),
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
           featuredlist.add(GestureDetector(
             onTap: () {
               _showInterstitialAd();
               Navigator.push(
                   context, MaterialPageRoute(builder: (context) =>
                   LiveMatchdetail(
                     id: unlivematch[i]['id'],)));
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
                             unlivematch[i]['league']['name'] + " , " +
                                 unlivematch[i]['round'],
                             style: TextStyle(
                                 fontSize: SizeConfig.blockSizeVertical * 1.5,
                                 fontWeight: FontWeight.bold),
                           ),


                         ],
                       ),
                       SizedBox(height: 2,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             DateTime.parse(unlivematch[i]["starting_at"])
                                 .toLocal().toString()
                                 .substring(0, 16),
                             style: TextStyle(
                                 fontSize: SizeConfig.blockSizeVertical * 1.5),
                           ),

                           // Text(
                           //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                           // )
                         ],
                       ),
                       Text( "Live",
                         style: TextStyle(
                             fontSize: SizeConfig.blockSizeVertical * 1.5,
                             fontWeight: FontWeight.bold,
                             color: Colors.red),),

                       SizedBox(height: 3,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           SizedBox(
                             width: 10,
                           ),
                           Container(height: 40,
                             width: 40,

                             decoration: BoxDecoration(shape: BoxShape.circle,
                                 image: DecorationImage(image: NetworkImage(
                                   unlivematch[i]['localteam']['image_path'],
                                 ), fit: BoxFit.fill)),

                           ),
                           SizedBox(
                             width: 7,
                           ),
                           Text(
                             unlivematch[i]['localteam']['code'],
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: SizeConfig.blockSizeVertical * 2,
                                 fontWeight: FontWeight.bold),
                           ),
                           Expanded(child: SizedBox()),

                           unlivematch[i]['runs'][0]['team_id'] == loacalteamid ?
                           Text(
                               unlivematch[i]['runs'].length == 0
                                   ? ""
                                   : unlivematch[i]['runs'][0]['score']
                                   .toString() + "/" +
                                   unlivematch[i]['runs'][0]['wickets']
                                       .toString() + " (" +
                                   unlivematch[i]['runs'][0]['overs']
                                       .toString() + ")"
                               ,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold)) : Text(
                               unlivematch[i]['runs'].length == 1
                                   ? ""
                                   : unlivematch[i]['runs'][1]['score']
                                   .toString() + "/" +
                                   unlivematch[i]['runs'][1]['wickets']
                                       .toString() + " (" +
                                   unlivematch[i]['runs'][1]['overs']
                                       .toString() + ")"
                               ,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold)) ,

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
                           Container(height: 40,
                             width: 40,

                             decoration: BoxDecoration(shape: BoxShape.circle,
                                 image: DecorationImage(image: NetworkImage(
                                     unlivematch[i]['visitorteam']['image_path']))),

                           ),
                           SizedBox(
                             width: 7,
                           ),
                           Text(
                             unlivematch[i]['visitorteam']['code'],
                             style: TextStyle(
                                 color: Colors.black,
                                 fontSize: SizeConfig.blockSizeVertical * 2,
                                 fontWeight: FontWeight.bold),
                           ),
                           Expanded(child: SizedBox()),
                            unlivematch[i]['runs'][1]['team_id'] ==
                               visitorteamid ?
                           Text(
                               unlivematch[i]['runs'].length == 0
                                   ? ""
                                   : unlivematch[i]['runs'][1]['score']
                                   .toString() + "/" +
                                   unlivematch[i]['runs'][1]['wickets']
                                       .toString() + " (" +
                                   unlivematch[i]['runs'][1]['overs']
                                       .toString() + ")"
                               ,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
                                   fontWeight: FontWeight.bold)) : Text(
                               unlivematch[i]['runs'].length == 0
                                   ? ""
                                   : unlivematch[i]['runs'][0]['score']
                                   .toString() + "/" +
                                   unlivematch[i]['runs'][0]['wickets']
                                       .toString() + " (" +
                                   unlivematch[i]['runs'][0]['overs']
                                       .toString() + ")"
                               ,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: SizeConfig.blockSizeVertical * 2,
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
                             width: SizeConfig.screenWidth * 0.8,
                             child: Center(
                                 child:
                                 Text(

                                   unlivematch[i]['note'],
                                   overflow: TextOverflow.ellipsis,
                                   softWrap: true,
                                   style: TextStyle(
                                       fontSize: SizeConfig.blockSizeVertical *
                                           1.4,
                                       color: Colors.red,
                                       fontWeight: FontWeight.bold),
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
        else {
          featuredlist.add(GestureDetector(
            onTap: () {
              _showInterstitialAd();
              if(unlivematch[i]['status']=='Finished'&&unlivematch[i]['format']=="Test"){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    Testmatchdetail(
                      id: unlivematch[i]['id'], status: "recent",)));
              }
              else if(unlivematch[i]['status']=='Finished'){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    Completedmatchdetail(
                      id: unlivematch[i]['id'], status: "recent",)));
              }

              else{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    Completedmatchdetail(
                      id: unlivematch[i]['id'], status: "Upcoming",)));
              }

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
                            unlivematch[i]['league']['name'] + " , " +
                                unlivematch[i]['round'],
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                fontWeight: FontWeight.bold),
                          ),


                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateTime.parse(unlivematch[i]["starting_at"])
                                .toLocal().toString()
                                .substring(0, 16),
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),

                          // Text(
                          //     int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))<12?(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,5)+"AM"):(int.parse(mathesfromserver[i]['starting_at'].toString().split("T")[1].toString().substring(0,2))-12).toString()+":00"+"PM"
                          // )
                        ],
                      ),
                      Text(unlivematch[i]['status'] == "NS"
                          ? "Upcoming"
                          : unlivematch[i]['status'] == "Finished"
                          ? "Completed"
                          : "Live",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),),

                      SizedBox(height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(height: 40,
                            width: 40,

                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(
                                  unlivematch[i]['localteam']['image_path'],
                                ), fit: BoxFit.fill)),

                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            unlivematch[i]['localteam']['code'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: SizedBox()),
                          unlivematch[i]['status'] == "Finished" ?
                          unlivematch[i]['runs'][0]['team_id'] == loacalteamid ?
                          Text(
                              unlivematch[i]['runs'].length == 0
                                  ? ""
                                  : unlivematch[i]['runs'][0]['score']
                                  .toString() + "/" +
                                  unlivematch[i]['runs'][0]['wickets']
                                      .toString() + " (" +
                                  unlivematch[i]['runs'][0]['overs']
                                      .toString() + ")"
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.bold)) : Text(
                              unlivematch[i]['runs'].length == 1
                                  ? ""
                                  : unlivematch[i]['runs'][1]['score']
                                  .toString() + "/" +
                                  unlivematch[i]['runs'][1]['wickets']
                                      .toString() + " (" +
                                  unlivematch[i]['runs'][1]['overs']
                                      .toString() + ")"
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.bold)) : Container(),

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
                          Container(height: 40,
                            width: 40,

                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(
                                    unlivematch[i]['visitorteam']['image_path']))),

                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            unlivematch[i]['visitorteam']['code'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: SizedBox()),
                          unlivematch[i]['status'] == "Finished"
                              ? unlivematch[i]['runs'][1]['team_id'] ==
                              visitorteamid ?
                          Text(
                              unlivematch[i]['runs'].length == 0
                                  ? ""
                                  : unlivematch[i]['runs'][1]['score']
                                  .toString() + "/" +
                                  unlivematch[i]['runs'][1]['wickets']
                                      .toString() + " (" +
                                  unlivematch[i]['runs'][1]['overs']
                                      .toString() + ")"
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.bold)) : Text(
                              unlivematch[i]['runs'].length == 0
                                  ? ""
                                  : unlivematch[i]['runs'][0]['score']
                                  .toString() + "/" +
                                  unlivematch[i]['runs'][0]['wickets']
                                      .toString() + " (" +
                                  unlivematch[i]['runs'][0]['overs']
                                      .toString() + ")"
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.bold))
                              : Container(),
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
                            width: SizeConfig.screenWidth * 0.8,
                            child: Center(
                                child:
                                Text(

                                  unlivematch[i]['status'] == "Finished"?unlivematch[i]['note']:unlivematch[i]['venue']==null?"":unlivematch[i]['venue']['name']+" , "+unlivematch[i]['venue']['city'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeVertical *
                                          1.4,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
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

    }
    return featuredlist;
  }
  List<Widget>postswidget(){
    List<Widget>postlists=new List();
    for(int i=postsfromserver.length-1; i>=0;i--){

      if (_isAdLoaded && i == _kAdIndex) {
        postlists.add( Container(
          child: AdWidget(ad: _ad),
          height: 72.0,
          alignment: Alignment.center,
        ));
      } else {
        final item = itemList[_getDestinationItemIndex(i)] as String;
        postlists.add( GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>topstorydetail(
                image:postsfromserver[i]['image'],
                title:postsfromserver[i]['title'],
                description:postsfromserver[i]['description']


            )));
          },
          child: Container(
            height: SizeConfig.blockSizeVertical * 28,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(

                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        postsfromserver[i]['image'],
                        fit: BoxFit.fitWidth,
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.screenWidth,
                      )),
                  Container(
                    padding: EdgeInsets.only(left:5,right:5,top:3,bottom: 3),

                    child: Text(
                      postsfromserver[i]['title'],maxLines:2, textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        postsfromserver[i]['description'], textAlign: TextAlign.justify,maxLines:2),
                  )
                ],
              ),
            ),
          ),
        ),);

      }
    }


    return postlists;
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {

      },
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
            final response = await http.post(Uri.parse("http://18.216.40.7/api/userlogin"),
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
        var graphResponse = await http.get(
            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token='
                '${facebookLoginResult.accessToken.token}'
                ));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        try {
          final response = await http.post(Uri.parse("http://18.216.40.7/api/userlogin"),
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
class User {
  String name;
  int age;

  User(this.name, this.age);

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}