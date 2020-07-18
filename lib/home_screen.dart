import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:timewarpsoc/ui_beauty.dart';

/* Top View holds the logo and a current time view */

class TopView extends StatefulWidget { // Stateful keeps track of an updated clock count
  const TopView({Key key}) : super(key: key);

  static const TextStyle logoScript = TextStyle( fontSize: 9, color: Color(0xFF1a495e), decoration: TextDecoration.none, fontFamily: 'IMFellDoublePicaSC');
  static const TextStyle bigTimeScript = TextStyle( fontSize: 13, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  static const TextStyle smallTimeScript = TextStyle( fontSize: 7, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');

  static const Color bkColor = Color(0xFF16ab9c);

  @override
  _TopView createState() => _TopView();
}

class _TopView extends State<TopView>{
  @override
  Widget build(BuildContext context) {
    return Container (
      color: TopView.bkColor,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 50,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Expanded(flex: 1, child:
              Text("\nTime\n Warp\n Society\n", style: TopView.logoScript, textAlign: TextAlign.center,)),
          Expanded(flex: 3, child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text("12:23:34", style: TopView.bigTimeScript, textAlign: TextAlign.center),
            Text("8-3-20", style: TopView.smallTimeScript, textAlign: TextAlign.center),
            // Text("\n\n where do we go today?", style: TopView.smallTimeScript, textAlign: TextAlign.center),
          ],))
        ],
      ),
    );
  }
}

class BrowseTableView extends StatefulWidget { //
  const BrowseTableView({Key key}) : super(key: key);

  static const TextStyle buttonScript = TextStyle( fontSize: 9, color: Color(0xFFb2c8eb), decoration: TextDecoration.none, fontFamily: 'EBGaramond');

  static const Color bkColor = Color(0xFF193947);
  static const Color opTabColor = Color(0xFF78acff);
  static const Color timelineBtnColor = Color(0xFF4368a3);

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
          height: 280,
          // TODO: Make child a FutureBuilder wrapper
          child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: 11,
            itemBuilder: (context, index) {
              return Container(
                // TODO: Add buttons on the righ-hand side, child might need to be Row() with Expanded() elements
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                // color: BrowseTableView.timelineBtnColor,
                height: 20,
                child: SizedBox.expand(
                    child:
                    FlatButton(
                      color: BrowseTableView.timelineBtnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)
                      ),
                      onPressed: (){
                        // Do a navigator view push here
                      },
                      // TODO: Text has to be dynamically set
                      child: Text("Geological Time Scale", style: BrowseTableView.buttonScript,),
                    )
                )
              );
          }),
        ),
        Container(
          color: BrowseTableView.opTabColor,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 20,
        )
      ],
    );
  }
}

class BottomView extends StatelessWidget {

  static const TextStyle buttonScript = TextStyle( fontSize: 9, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  static const Color buttonColor = Color(0xFF16ab9c);

  @override
  Widget build(BuildContext context) {
    return Container (
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 30,
        /* decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(1.0))
        ), */
        child:
            SizedBox.expand(
              child:
              FlatButton(
                color: BottomView.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)
                ),
                onPressed: (){
                  // Do a navigator view push here
                },
                child: Text("See Time Capsules", textAlign: TextAlign.center, style: BottomView.buttonScript,),
              )
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
    // TODO: if else statement for screen orientation, app needs to change
    return MaterialApp(
      home:
      Container(
        color: HomeScreen.fullBk,
        child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10)),
              TopView(),
              Padding(padding: EdgeInsets.only(top: 10)),
              BrowseTableView(),
              Padding(padding: EdgeInsets.only(top: 10)),
              BottomView()
            ],
        )
      )
    );
  }
}