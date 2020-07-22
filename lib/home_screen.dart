import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timewarpsoc/db_logic.dart';

import 'package:timewarpsoc/timeline_screen.dart';
import 'package:timewarpsoc/create_screen.dart';
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

  static const TextStyle buttonScript = TextStyle( fontSize: 9, color: Color(0xFFb2c8eb), decoration: TextDecoration.none, fontFamily: 'Amita');
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

    SearchRecords_FirebaseDB db = new SearchRecords_FirebaseDB();

    Widget listDataDisplay = ListView.builder(
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
        });
    Widget gridDataDisplay = GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 8.0),
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
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
        });

    // TODO: Make child a FutureBuilder wrapper
    return Column(
      children: <Widget>[
        Container(
          color: BrowseTableView.bkColor,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: (BrowseTableView.isPortrait) ? 305.0 : 160.0,
          child: (BrowseTableView.isPortrait) ? listDataDisplay : gridDataDisplay
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
                        // TODO: Create a new firebase entry with auto generated ID
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen(docStr: 'E7GSISGNZkqJrgO93Djr',)));
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
    // TODO: if else statement for screen orientation, app needs to change
    return MaterialApp(
      home:
      OrientationBuilder(
        builder: (context, orientation){
          HomeScreen.mq = MediaQuery.of(context);

          TopView.isPortrait = (orientation == Orientation.portrait) ? true : false;
          BrowseTableView.isPortrait = (orientation == Orientation.portrait) ? true : false;

          return
          Container( // Not orientation dependent anymore!
              color: HomeScreen.fullBk,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  TopView(),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  BrowseTableView()
                ],
              )
          );
        }
      )
    );
  }
}