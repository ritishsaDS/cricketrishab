import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:CricScore_App/UI/Topstorydetail.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Topstories extends StatefulWidget{
  @override
  _TopstoriesState createState() => _TopstoriesState();
}

class _TopstoriesState extends State<Topstories> {
  bool isError = false;
  bool isLoading = false;
  @override
  void initState() {
    getnews();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.blue,
       centerTitle: true,
       title:  Text(
         "Top Stories",
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
     body: SingleChildScrollView(
       physics: BouncingScrollPhysics(),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Container(
               width: SizeConfig.screenWidth,
               height: SizeConfig.screenHeight,
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
         ],
       ),
     ),
   );
  }
  dynamic newsfromserver = new List();
  void getnews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'http://18.216.40.7/api/get-top-post'));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        newsfromserver = responseJson['top-post'];

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
    for (int i = 0; i < newsfromserver.length; i++) {
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
                      newsfromserver[i]['title'],maxLines:2,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      newsfromserver[i]['description'],textAlign: TextAlign.start,maxLines: 2,),
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