import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:timewarpsoc/top_view.dart';
import 'package:timewarpsoc/browse_table_view.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenView createState() => _HomeScreenView();
}

class _HomeScreenView extends State<HomeScreenView>{
  MediaQueryData MQ;

  @override
  Widget build(BuildContext context) {
    MQ = MediaQuery.of(context);

    return Container(
        color: HomeScreen.fullBk,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            TopView(MQ: MQ),
            Padding(padding: EdgeInsets.only(top: 10)),
            BrowseTableView(MQ: MQ)
          ],
        )
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static const Color fullBk = Color(0xFF1a495e);
  static const Color topBk = Color(0xFF16ab9c);
  static const Color midBk = Color(0xFF80c4bd);
  static const Color botBk = Color(0xFF1f78a1);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // HomeScreen.MQ = MediaQuery.of(context);

    return MaterialApp(
      home:
        HomeScreenView()
    );
  }
}