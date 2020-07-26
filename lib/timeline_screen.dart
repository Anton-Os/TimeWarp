
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';
import 'package:timewarpsoc/ui_beauty.dart';
import 'package:timewarpsoc/timeline_seg_view.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({ Key key, this.documentId }) : super(key: key);

  final String documentId;

  @override
  _TimelineScreen createState() => _TimelineScreen();
}

class _TimelineScreen extends State<TimelineScreen> {
  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  TimelineSegView segment;
  Timeline_FirebaseDB DB;
  Future _asyncTaskInit;

  @override
  void initState(){
    DB = new Timeline_FirebaseDB(firebaseDocStr: widget.documentId); // DB Creation happens once
    _asyncTaskInit = DB.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: _asyncTaskInit,
          builder: (context, snapshot){
            return
            MaterialApp(
              home:
                  OrientationBuilder(
                    builder: (context, orientation){
                      TimelineSegView.isPortrait = (orientation == Orientation.portrait) ? true : false;
                          // Setting color themes prior to list builder invocation, smart
                          // TODO: Allow dynamic changes with the BottomAppBar
                          MapEntry colorsEntry;
                          colorsEntry = DB.data.themeColors.firstWhere((element) => element.key == "Title Colors");

                          TimelineSegView.title_Colors = getColorsFromMapEntry(colorsEntry);
                          TimelineSegView.titleNameScript = TextStyle( fontSize: 20, color: TimelineSegView.title_Colors.getText, decoration: TextDecoration.none, fontFamily: 'Amita');
                          TimelineSegView.titleDateScript = TextStyle( fontSize: 9, color: TimelineSegView.title_Colors.getText, decoration: TextDecoration.none, fontFamily: 'Dokdo');
                          TimelineSegView.titleSubscriptScript = TextStyle( fontSize: 7, color: TimelineSegView.title_Colors.getText, decoration: TextDecoration.none, fontFamily: 'EBGaramond');

                          colorsEntry = DB.data.themeColors.firstWhere((element) => element.key == "Center Colors");

                          TimelineSegView.center_Colors = getColorsFromMapEntry(colorsEntry);
                          TimelineSegView.centerDateScript = TextStyle( fontSize: 6.5, color: TimelineSegView.center_Colors.getText, decoration: TextDecoration.none, fontFamily: 'Broadway');

                          colorsEntry = DB.data.themeColors.firstWhere((element) => element.key == "Item Colors");

                          TimelineSegView.items_Colors = getColorsFromMapEntry(colorsEntry);
                          TimelineSegView.itemHeaderScript = TextStyle( fontSize: 10, color: TimelineSegView.items_Colors.getText, decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
                          TimelineSegView.itemDescScript = TextStyle( fontSize: 8, color: TimelineSegView.items_Colors.getText, decoration: TextDecoration.none, fontFamily: 'JosefinSlab');

                          return
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: (DB.data.segments.length * 2) + 2, // + 2 to add extra filler
                                itemBuilder: (context, index) {

                                  if(index == 0) TimelineSegView.itemIndex = 0; // Needs to reset when the builder starts over with first element
                                  segment = new TimelineSegView.fromDB(index: index, data: DB.data);

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