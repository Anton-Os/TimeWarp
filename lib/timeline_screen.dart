
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';
import 'package:timewarpsoc/ui_beauty.dart';
import 'package:timewarpsoc/timeline_seg_view.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({ Key key }) : super(key: key);

  // Json handling and constructor need to be implemented

  @override
  _TimelineScreen createState() => _TimelineScreen();
}

class _TimelineScreen extends State<TimelineScreen> {
  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  @override
  Widget build(BuildContext context) {
    TimelineSegView segment;
    Timeline_FirebaseDB db = new Timeline_FirebaseDB(firebaseDocStr: 'iLakpSBa6Ps9hok5wMCJ');

    return FutureBuilder(
      future: db.init(),
      builder: (context, snapshot){
        //if(snapshot.connectionState)
        return
        MaterialApp(
          home:
              OrientationBuilder(
                builder: (context, orientation){
                  TimelineSegView.isPortrait = (orientation == Orientation.portrait) ? true : false;

                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: (Timeline_FirebaseDB.data.segments.length * 2) + 2, // + 2 to add extra filler
                      itemBuilder: (context, index) {

                        if(index == 0) TimelineSegView.itemIndex = 0; // Needs to reset when the builder starts over with first element
                        segment = TimelineSegView.fromDB(index: index, data: Timeline_FirebaseDB.data);

                        Row targetRow = (TimelineSegView.itemIndex % 2 == 0) ?
                        Row( // We can flip depending on the item index
                            children: <Widget>[
                              segment.targetWidgetS2, // targetWidgetS2,
                              segment.targetWidgetM,
                              segment.targetWidgetS1
                            ]
                        ) : Row(
                            children: <Widget>[
                              segment.targetWidgetS1, // targetWidgetS1,
                              segment.targetWidgetM,
                              segment.targetWidgetS2
                            ]
                        );

                        return Container( child: targetRow);
                      }
                  );
                }
              )
        );
      }
    );
  }
}