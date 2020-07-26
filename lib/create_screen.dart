
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';
import 'package:timewarpsoc/ui_beauty.dart';
import 'package:timewarpsoc/timeline_seg_view.dart';

import 'package:timewarpsoc/create/add_item_screen.dart';
import 'package:timewarpsoc/create/color_picker_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({ Key key, this.docStr }) : super(key: key);

  final String docStr;

  static const Color navElemColor = Color(0xFFe6a673);

  @override
  _CreateScreen createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {
  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  Future _asyncTaskInit;
  TimelineSegView segment;
  Timeline_FirebaseDB DB;

  @override
  void initState(){
    DB = new Timeline_FirebaseDB(firebaseDocStr: widget.docStr); // DB Creation happens once
    _asyncTaskInit = DB.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return
      FutureBuilder(
      future: _asyncTaskInit,
      builder: (context, snapshot){ // TODO: Add checks to snapshot
        return
          MaterialApp(
              home:
              Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    color: CreateScreen.navElemColor,
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        // THESE ARE TITLE COLORS AND PADDING
                        // --------------------------------------------------------------
                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.title_Colors.getPrimary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.title_Colors.getSecondary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.title_Colors.getText,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(6, 16, 6, 16),), // Extra Padding to divide sections

                        // THESE ARE ITEM COLORS AND PADDING
                        // --------------------------------------------------------------
                        SizedBox( // TODO: Replace this with a button class
                            height: 16,
                            width: 16,
                            child:
                            RaisedButton(
                              color: TimelineSegView.items_Colors.getPrimary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 16,
                            width: 16,
                            child:
                            RaisedButton(
                              color: TimelineSegView.items_Colors.getSecondary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 16,
                            width: 16,
                            child:
                            RaisedButton(
                              color: TimelineSegView.items_Colors.getText,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 16,
                            width: 16,
                            child:
                            RaisedButton(
                              color: TimelineSegView.title_Colors.getFiller,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(6, 16, 6, 16),), // Extra Padding to divide sections

                        // THESE ARE CENTER COLORS AND PADDING
                        // --------------------------------------------------------------
                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.center_Colors.getPrimary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.center_Colors.getSecondary,
                              onPressed:() {},
                            )
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(3, 16, 3, 16),),

                        SizedBox( // TODO: Replace this with a button class
                            height: 20,
                            width: 20,
                            child:
                            RaisedButton(
                              color: TimelineSegView.center_Colors.getText,
                              onPressed:() {},
                            )
                        )

                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                      backgroundColor: CreateScreen.navElemColor,
                      mini: true,
                      onPressed: (){}
                  ),
                  body:
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

              })
              )
          );
     });
  }
}