import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class OpenBlog extends StatefulWidget {
  dynamic title;
  dynamic image;
  dynamic description;
   OpenBlog({this.description,this.title,this.image}) ;

  @override
  _OpenBlogState createState() => _OpenBlogState();
}

class _OpenBlogState extends State<OpenBlog> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
           // Navigator.pop(context);
          },
          child: Image.asset('assets/icons/back.png',
            scale: SizeConfig.blockSizeVertical * 0.5,),
        ),
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
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       width: SizeConfig.screenWidth * 0.4,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(15),
                         child: Image.network(widget.image,fit: BoxFit.cover,),
                       ),
                     ),
                     Container(
                       width: SizeConfig.screenWidth * 0.42,
                       margin: EdgeInsets.only(
                         left: SizeConfig.screenWidth * 0.04,
                         top: SizeConfig.blockSizeVertical
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             margin:EdgeInsets.only(
                               bottom: SizeConfig.blockSizeVertical * 1.5
                             ),
                             child: Text("${widget.title}",
                             style: TextStyle(
                               color: Color(darkGrey),
                               fontWeight: FontWeight.w600,
                               fontSize: SizeConfig.blockSizeVertical * 2
                             ),),
                           ),
                           Text("${widget.description}",
                             maxLines: 12,
                             style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.w500,
                                 fontSize: SizeConfig.blockSizeVertical * 1.25
                             ),
                         ),
                         ],
                       ),
                     ),
                   ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     top: SizeConfig.blockSizeVertical * 1.5
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width:SizeConfig.screenWidth * 0.4,
                  //         margin: EdgeInsets.only(
                  //           right: SizeConfig.screenWidth * 0.04,
                  //         ),
                  //         child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig.blockSizeVertical * 1.25
                  //           ),
                  //           textAlign: TextAlign.justify,),
                  //       ),
                  //       Container(
                  //         width:SizeConfig.screenWidth * 0.4,
                  //         margin: EdgeInsets.only(
                  //           right: SizeConfig.screenWidth * 0.04,
                  //         ),
                  //         child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig.blockSizeVertical * 1.25
                  //           ),
                  //           textAlign: TextAlign.justify,),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       top: SizeConfig.blockSizeVertical
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width:SizeConfig.screenWidth * 0.4,
                  //         margin: EdgeInsets.only(
                  //           right: SizeConfig.screenWidth * 0.04,
                  //         ),
                  //         child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig.blockSizeVertical * 1.25
                  //           ),
                  //           textAlign: TextAlign.justify,),
                  //       ),
                  //       Container(
                  //         width:SizeConfig.screenWidth * 0.4,
                  //         margin: EdgeInsets.only(
                  //           right: SizeConfig.screenWidth * 0.04,
                  //         ),
                  //         child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig.blockSizeVertical * 1.25
                  //           ),
                  //           textAlign: TextAlign.justify,),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
