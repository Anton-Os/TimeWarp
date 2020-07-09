// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter/;
import 'package:flutter/cupertino.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';

/* class TimelineSegment {

  final Color targetSideColor;
  final Color targetMiddleColor;
  final double targetHeight;

  final Widget targetWidgetL; // left
  final Widget targetWidgetM; // middle
  final Widget targetWidgetR; // right
} */

Expanded genEventDesc(String str, double height){
  const Color textBkColor = Color(0xFF22FFDD);

  const TextStyle txtStyle = TextStyle(
      fontSize: 8,
      color: Colors.black54,
      decoration: TextDecoration.none,
      fontFamily: 'Quicksand'
  );

  return Expanded(
      flex: 2,
      child: Container(
      color: textBkColor,
      height: height,
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: txtStyle
      ),
    )
  );
}

Expanded genYearDesc(String str, double height){
  const Color textBkColor = Color(0xFFAA33DD);

  const TextStyle txtStyle = TextStyle(
      fontSize: 8,
      color: Colors.white,
      decoration: TextDecoration.none,

      fontFamily: 'JosefinSlab'
  );

  return Expanded(
      flex: 1,
      child: Container(
        color: textBkColor,
        height: height,
        child: Text(
            str,
            textAlign: TextAlign.center,
            style: txtStyle
        ),
      )
  );
}

Expanded genFiller(double height){
  const Color textBkColor = Color(0xFF22FFDD);

  return Expanded(
      flex: 2,
      child: Container(
        color: textBkColor,
        height: height
      )
  );
}





class TimelineDesc {
  TimelineDesc({Key key, String str}) {
    // TODO: Height needs to be correctly adjusted
    assert(str != null);
    assert(str.length < 180);

    outputStr = str;

    if(outputStr.length > 50) height += heightInc;
    if(outputStr.length > 100) height += heightInc;
    if(outputStr.length > 150) height += heightInc;
  }

  static Image img;

  static const double heightInc = 18;
  double height = heightInc;
  String outputStr;

  // Url url; // Figure out how URL Works
  // Location loc;
}

class TimelineSegment {
  TimelineSegment({Key key, int index}){
    switch (index){
      case 0: { // Header
        targetWidgetL = Expanded(flex: 1, child: Container(color: topperColor_sides, height: 70.0));
        targetWidgetM = Expanded(flex: 10, child: Container(color: topperColor_middle, height: 70.0));
        targetWidgetR = Expanded(flex: 1, child: Container(color: topperColor_sides, height: 70.0));
      }
      break;

      default: {
        if(index % 2 == 1) { // Filler
          targetWidgetL = Expanded(flex: 2, child: Container(color: sideColor, height: 80.0));
          targetWidgetM = Expanded(flex: 1, child: Container(color: timelineColor, height: 80.0));
          targetWidgetR = Expanded(flex: 2, child: Container(color: sideColor, height: 80.0));
        }
        else {
          TimelineDesc desc; // Must be initialized from fiebase and probably put in a switch(case) block
          if(index % 4 == 0) { // Right side display
            desc = TimelineDesc(str: "I go shopping every day twice a week for c c c c c cc kc kc kck ckc!");
            targetWidgetM = genYearDesc("788 ADE", desc.height);
            targetWidgetL = genFiller(desc.height);
            targetWidgetR = genEventDesc(desc.outputStr, desc.height);
          } else { // Left side display
            desc = TimelineDesc(str: "WWWWWWWWWWWWWWWWWWWW We are lit");
            targetWidgetM = genYearDesc("1455 BCE", desc.height);
            targetWidgetR = genFiller(desc.height);
            targetWidgetL = genEventDesc(desc.outputStr, desc.height);
          }
        }
      }
      break;
    }
  }

  // Timeline color palette
  static const Color topperColor_sides = Colors.orange;
  static const Color topperColor_middle = Colors.deepOrangeAccent;
  static const Color timelineColor = Color(0xFFAA33DD);
  static const Color textBkColor = Color(0xFF22FFDD);
  static const Color sideColor = Color(0xFF22FFAA); //Color(0xFF11DDEE);

  static const TextStyle middleStyle = TextStyle(
      fontSize: 8,
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'Amita'
  );


  static const TextStyle descStyle = TextStyle(
      fontSize: 8,
      color: Colors.black54,
      decoration: TextDecoration.none,
      fontFamily: 'IMFellDoublePicaSC'
  );

  static const TextStyle captionStyle = TextStyle(
      fontSize: 13,
      color: Colors.white,
      decoration: TextDecoration.underline,
      backgroundColor: Colors.blue,
      fontFamily: 'IMFellDoublePicaSC'
  );

  Widget targetWidgetL; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetR; // right
}

class TimelineVisual extends StatefulWidget {
  const TimelineVisual({ Key key }) : super(key: key);

  // Json handling and constructor need to be implemented

  @override
  _TimelineVisual createState() => _TimelineVisual();
}

class _TimelineVisual extends State<TimelineVisual> {
  static const Color topperColor_sides = Colors.orange;
  static const Color topperColor_middle = Colors.deepOrangeAccent;
  static const Color timelineColor = Color(0xFFAA33DD);
  static const Color textBkColor = Color(0xFF22FFCC);
  static const Color sideColor = Color(0xFF22FFAA); // Color(0xFF11DDEE);

  // Color targetSideColor;
  // Color targetMiddleColor;
  // double targetHeight;

  Widget targetWidgetL; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetR; // right

  @override
  Widget build(BuildContext context) {
    TimelineFirebaseDB db = TimelineFirebaseDB(); // TODO: Access a target database we have stored

    return MaterialApp(
      home:
      ListView.builder(
        itemCount: 40,
        itemBuilder: (context, index) {
          TimelineSegment segment = TimelineSegment(index: index);

          return
            Container(
                // color: Color(0xFF2244AA),
                child: Row(
                    children: <Widget>[
                      segment.targetWidgetL, // targetWidgetL,
                      segment.targetWidgetM,
                      segment.targetWidgetR
                    ]
                )
              );
        })
    );
  }
}