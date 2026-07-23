import 'dart:convert';

import 'package:cricscore_app/UI/Notlivematch.dart';
import 'package:cricscore_app/UI/Livematches.dart';
import 'package:cricscore_app/UI/Oneday.dart';
import 'package:cricscore_app/UI/recenttabscorecard.dart';
import 'package:cricscore_app/Utils/Colors.dart';
import 'package:cricscore_app/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Upcomingmatches.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}
class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _nestedTabController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "T20",
            ),
            Tab(
              text: "ODI",
            ),
            Tab(
              text: "TEST",
            ),

          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Oneday(),
              Livematch(),
              Oneday()

            ],
          ),
        )
      ],
    );
  }
}