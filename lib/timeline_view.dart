import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/db_logic.dart';
import 'package:timewarpsoc/ui_beauty.dart';

class TimelineSegView {
  TimelineSegView({Key key, this.index, this.data}){
    // TODO: Code for determining theme/colors should go here

    switch(index){
      case(0): // TODO: Extract info based on the _Name field
        targetWidgetS1 = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 70.0));
        targetWidgetM = new Expanded(flex: 10, child: Container(color: title_TCS.primary, height: 70.0));
        targetWidgetS2 = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 70.0));
        break;

      default:
        if(index % 2 == 0){
          if(this.data.segments.length != 0) {
            GlobalKey _sizeableWidgetKey = GlobalKey(); // Attach key to the target widget
            targetWidgetS1 = new Expanded(flex: 5,
                  key: _sizeableWidgetKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(color: items_TCS.secondary,
                                child: Text(this.data.segments.elementAt(itemIndex).header, textAlign: TextAlign.center, style: headerScriptTS)),
                      Container(color: items_TCS.primary, padding: EdgeInsets.only(top: 4.0),
                          child: Text(this.data.segments.elementAt(itemIndex).desc, textAlign: TextAlign.center, style: descScriptTS)),
                    ],
                  )
                );
            // final RenderBox _sizeableWidgetRB = _sizeableWidgetKey.currentContext.findRenderObject();
            // final double _sizeableWidgetHeight = _sizeableWidgetRB.size.height;
            targetWidgetM = new Expanded(flex: 2,
                child: Container(color: center_TCS.primary, height: 30.0,
                  child: Text(
                      this.data.segments.elementAt(itemIndex).tp1.year.toString() + "\n to \n" + this.data.segments.elementAt(itemIndex).tp2.year.toString(),
                      style: centerDateTS, textAlign: TextAlign.center,
                  )
            )); // The height is dynamic
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0));
            itemIndex++;
          } else { // The height is dynamic
            targetWidgetS1 = new Expanded(flex: 2, child: Container(color: items_TCS.primary, height: 70.0));
            targetWidgetM = new Expanded(flex: 2, child: Container(color: center_TCS.primary, height: 70.0)); // The height is dynamic
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
          }
        } else {
          print("Scalable filler space");
          targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
          targetWidgetM = new Expanded(flex: 2, child: Container(color: center_TCS.primary, height: 70.0)); // The height is dynamic
          targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
        }
        break;
    }
  }

  final int index;
  final TimelineData data;

  int itemIndex = 0; // Knows where to access the item data for timeline

  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  TimelineColorScheme center_TCS = 
    new TimelineColorScheme(primary: new Color(0xFF6D665F), secondary: new Color(0xFF5E5A57), text: new Color(0xFF604040));
  TimelineColorScheme items_TCS = // Requires a filler color
    new TimelineColorScheme(primary: new Color(0xFFFFD385), secondary: new Color(0xFFDDAC5D), text: new Color(0xFF604040), filler: new Color(0xFFB19592));
  TimelineColorScheme title_TCS =
    new TimelineColorScheme(primary: new Color(0xFFFAEDC8), secondary: new Color(0xFFDED3B4), text: new Color(0xFF604040));

  TextStyle headerScriptTS = TextStyle( fontSize: 10, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  TextStyle descScriptTS = TextStyle( fontSize: 8, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  TextStyle centerDateTS = TextStyle( fontSize: 9, color: new Color(0xFF601111), decoration: TextDecoration.none, fontFamily: 'Broadway');
}

class TimelineVisual extends StatefulWidget {
  const TimelineVisual({ Key key }) : super(key: key);

  // Json handling and constructor need to be implemented

  @override
  _TimelineVisual createState() => _TimelineVisual();
}

class _TimelineVisual extends State<TimelineVisual> {
  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<TimelineFirebaseDB> db = new ValueNotifier(TimelineFirebaseDB(firebaseDocStr: 'iLakpSBa6Ps9hok5wMCJ')); // TODO: Make this field mapped to a legible value
    // TimelineFirebaseDB db = new TimelineFirebaseDB(firebaseDocStr: 'iLakpSBa6Ps9hok5wMCJ');

    TimelineSegView segment;

    return MaterialApp(
      home:
        ChangeNotifierProvider(
          builder: (_) => TimelineFirebaseDB(firebaseDocStr: 'iLakpSBa6Ps9hok5wMCJ'),
          child:
            ListView.builder(
              // itemCount: TimelineFirebaseDB.data.segments.length,
              itemCount: 3,
              itemBuilder: (context, index) {

                segment = TimelineSegView(index: index, data: TimelineFirebaseDB.data);

                Row targetRow = (segment.itemIndex % 2 == 0) ?
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
            )
        )
    );
  }
}