import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopView extends StatefulWidget { // Stateful keeps track of an updated clock count
  const TopView({Key key, this.MQ}) : super(key: key);

  final MediaQueryData MQ;

  static const Color bkColor = Color(0xFF16ab9c);
  static const TextStyle logoScript = TextStyle( fontSize: 9, color: Color(0xFF1a495e), decoration: TextDecoration.none, fontFamily: 'IMFellDoublePicaSC');
  static const TextStyle bigTimeScript = TextStyle( fontSize: 13, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  static const TextStyle smallTimeScript = TextStyle( fontSize: 7, color: Color(0xFF14ff9c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');

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
      height: (widget.MQ.orientation == Orientation.portrait)? 50 : 45,
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