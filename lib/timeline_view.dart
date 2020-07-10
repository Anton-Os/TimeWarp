import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';
import 'package:timewarpsoc/ui_beauty.dart';

class TimelineSegView {
  TimelineSegView({Key key, this.index, this.data}){
    // TODO: Code for determining theme/colors should go here

    switch(index){
      case(0): // TODO: Extract info based on the _Name field
        targetWidgetL = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 70.0));
        targetWidgetM = new Expanded(flex: 10, child: Container(color: title_TCS.primary, height: 70.0));
        targetWidgetR = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 70.0));
        break;

      default:
        if(index % 2 == 0){
          print("Item space");
          itemIndex++;
        } else {
          print("Scalable filler space");
          targetWidgetL = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
          targetWidgetM = new Expanded(flex: 2, child: Container(color: center_TCS.primary, height: 70.0)); // The height is dynamic
          targetWidgetR = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
        }
        break;
    }
  }

  final int index;
  final TimelineData data;

  int itemIndex = 0; // Knows where to access the item data for timeline

  Widget targetWidgetL; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetR; // right

  TimelineColorScheme center_TCS = 
    new TimelineColorScheme(primary: new Color(0xFFFF8C5E), secondary: new Color(0xFFDE7E59), text: new Color(0xFF523C3F));
  TimelineColorScheme items_TCS = // Requires a filler color
    new TimelineColorScheme(primary: new Color(0xFFB39FF5), secondary: new Color(0xFF8376AD), text: new Color(0xFF808891), filler: new Color(0xFFEEC5F0));
  TimelineColorScheme title_TCS =
    new TimelineColorScheme(primary: new Color(0xFFFAEDC8), secondary: new Color(0xFFDED3B4), text: new Color(0xFF73584E));
}

class TimelineVisual extends StatefulWidget {
  const TimelineVisual({ Key key }) : super(key: key);

  // Json handling and constructor need to be implemented

  @override
  _TimelineVisual createState() => _TimelineVisual();
}

class _TimelineVisual extends State<TimelineVisual> {
  Widget targetWidgetL; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetR; // right

  @override
  Widget build(BuildContext context) {
    TimelineFirebaseDB db = new TimelineFirebaseDB(firebaseDocStr: 'iLakpSBa6Ps9hok5wMCJ'); // TODO: Make this field mapped to a legible value

    return MaterialApp(
        home:
        ListView.builder(
            // itemCount: TimelineFirebaseDB.data.segments.length,
            itemCount: 2,
            itemBuilder: (context, index) {
              TimelineSegView segment = TimelineSegView(index: index, data: TimelineFirebaseDB.data);

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