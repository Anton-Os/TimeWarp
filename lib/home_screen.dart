import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timewarpsoc/timeline_screen.dart';
import 'package:timewarpsoc/create_settings_screen.dart';
import 'package:timewarpsoc/timeline_seg_view.dart';

/* Top View holds the logo and a current time view */

class TopView extends StatefulWidget { // Stateful keeps track of an updated clock count
  const TopView({Key key}) : super(key: key);

  static const TextStyle logoScript = TextStyle( fontSize: 9, color: Color(0xFF1a495e), decoration: TextDecoration.none, fontFamily: 'IMFellDoublePicaSC');
  static const TextStyle bigTimeScript = TextStyle( fontSize: 13, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  static const TextStyle smallTimeScript = TextStyle( fontSize: 7, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  static const Color bkColor = Color(0xFF16ab9c);

  static bool isPortrait = true;

  @override
  _TopView createState() => _TopView();
}

class _TopView extends State<TopView>{
  String timeStr = "00:00:00";
  String dateStr = "0 / 0 / 0";
  DateTime currentDT;

  @override
  void initState(){
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime()); // I believe calls periodically
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      color: TopView.bkColor,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: (TimelineSegView.isPortrait)? 50 : 45,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child:
            Container( // Adds a little up top
              padding: EdgeInsets.only(top: 6.0),
              child:
              Text("Time\n Warp\n Society\n", style: TopView.logoScript, textAlign: TextAlign.center)
            )),
          Expanded(flex: 3, child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(timeStr, style: TopView.bigTimeScript, textAlign: TextAlign.center),
              Text(dateStr, style: TopView.smallTimeScript, textAlign: TextAlign.center)
              // Text("\n\n where do we go today?", style: TopView.smallTimeScript, textAlign: TextAlign.center)
          ],))
        ],
      ),
    );
  }

  void _getTime(){
    currentDT = DateTime.now();
    timeStr = currentDT.hour.toString() + ':' + currentDT.minute.toString() + ':' + currentDT.second.toString();
    dateStr = currentDT.month.toString() + ' / ' + currentDT.day.toString() + ' / ' + currentDT.year.toString();
  }
}

class BrowseTableView extends StatefulWidget { //
  const BrowseTableView({Key key}) : super(key: key);

  static const TextStyle buttonScript = TextStyle( fontSize: 9, color: Color(0xFFb2c8eb), decoration: TextDecoration.none, fontFamily: 'EBGaramond');
  static const TextStyle lowBtnScript = TextStyle( fontSize: 9, color: Color(0xFF193947), decoration: TextDecoration.none, fontFamily: 'EBGaramond');
  static const Color bkColor = Color(0xFF193947);
  static const Color createBtnColor = Color(0xFF14ff9c);
  static const Color showBtnColor = Color(0xFF14cc9c);
  static const Color timelineBtnColor = Color(0xFF4368a3);

  static bool isPortrait = true;

  @override
  _BrowseTableView createState() => _BrowseTableView();
}

class _BrowseTableView extends State<BrowseTableView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: BrowseTableView.bkColor,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 305,
          // TODO: Make child a FutureBuilder wrapper
          child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: 12,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                // color: BrowseTableView.timelineBtnColor,
                height: 20,
                child: Row( // TODO: Load elements from another view class!
                children: <Widget>[
                    Expanded(
                      flex: 12,
                      child:
                        SizedBox.expand(
                            child:
                            FlatButton(
                              color: BrowseTableView.timelineBtnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(3.0), bottomLeft: Radius.circular(3.0))
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TimelineScreen()));
                              },
                              // TODO: Text has to be dynamically set!
                              child: Text("Geological Time Scale", style: BrowseTableView.buttonScript,),
                            )
                        ),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                      SizedBox.expand(
                          child:
                          RaisedButton(
                            color: BrowseTableView.timelineBtnColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(3.0), bottomRight: Radius.circular(3.0))
                            ),
                            onPressed: (){
                              // Make sure it gets starred
                            },
                            // TODO: Change to a delete icon
                            child: Text("X", textAlign: TextAlign.right, style: BrowseTableView.buttonScript,),
                          )
                      ),
                    )
                  ]
                )
              );
          }),
        ),
        Padding(padding: EdgeInsets.only(top: 3)),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 20,
          child:
            Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child:
                SizedBox.expand(
                    child:
                    FlatButton(
                      color: BrowseTableView.createBtnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(3.0), bottomLeft: Radius.circular(3.0))
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateSettingsScreen()));
                      },
                      child: Text("Create", style: BrowseTableView.lowBtnScript),
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child:
                SizedBox.expand(
                    child:
                    FlatButton(
                      color: BrowseTableView.showBtnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(3.0), bottomRight: Radius.circular(3.0))
                      ),
                      onPressed: (){
                      },
                      child: Text("Show All", style: BrowseTableView.lowBtnScript),
                    )
                ),
              )
            ]),
        )
      ]
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static const Color fullBk = Color(0xFF1a495e);
  static const Color topBk = Color(0xFF16ab9c);
  static const Color midBk = Color(0xFF80c4bd);
  static const Color botBk = Color(0xFF1f78a1);

  static MediaQueryData mq;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    HomeScreen.mq = MediaQuery.of(context);

    // TODO: if else statement for screen orientation, app needs to change
    return MaterialApp(
      home:
      OrientationBuilder(
        builder: (context, orientation){
          TopView.isPortrait = (orientation == Orientation.portrait) ? true : false;
          BrowseTableView.isPortrait = (orientation == Orientation.portrait) ? true : false;

          return (orientation == Orientation.portrait) ?
            // Portrait mode display style
            Container(
              color: HomeScreen.fullBk,
              child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TopView(),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    BrowseTableView()
                  ],
              )
            )
          : // Landscape mode display Style
          Container(
              color: HomeScreen.fullBk,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  TopView(),
                  Padding(padding: EdgeInsets.only(top: 10)),
                ],
              )
          );
        }
      )
    );
  }
}