import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:timewarpsoc/timeline_types.dart';
import 'package:timewarpsoc/ui_beauty.dart';

TimelineColorScheme getColorsFromMapEntry(MapEntry mapEntry){
  Color p; Color s; Color f; Color t;

  Map<String, int> colorMap = new Map<String, int>.from(mapEntry.value);
  colorMap.forEach((key, value) {
    switch(key){
      case("Primary"):
        p = new Color(value);
        break;
      case("Secondary"):
        s = new Color(value);
        break;
      case("Filler"):
        f = new Color(value);
        break;
      case("Text"):
        t = new Color(value);
        break;
      default:
        print("Unrecognized color field detected!");
        break;
    }
  });

  return TimelineColorScheme(primary: p, secondary: s, filler: f, text: t);
}

double getHeightFromText(bool isPortrait, int charCount){ // Think I got it!!!
  assert(charCount < 400);

  final int charLineInc = 28; // May need to modify this
  final double spacingLine = (isPortrait) ? 8.0: 5.0;
  final double paddingLine = 10.0;
  final double computedSpace = (charCount.toDouble() / charLineInc.toDouble()) * spacingLine.toDouble() + paddingLine.toDouble();
  return computedSpace.floor().toDouble();
}

class TimelineSegView {
  TimelineSegView({key, this.index}){
    // Creation mode constuctor!
  }

  TimelineSegView.fromDB({Key key, this.index, this.data}){ // TODO: Include a boolean to indicate portrait or landscape and resize text values

    switch(index){
      case(0): // TODO: Extract info based on the _Name field
        targetWidgetS1 = new Expanded(flex: 1, child: Container(color: title_Colors.secondary, height: 300.0));
        targetWidgetM = new Expanded(flex: 10,
            child: Container(color: title_Colors.primary, height: 300.0,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(TimelineSegView.titleStr, textAlign: TextAlign.center, style: titleNameScript), // TODO: This needs to be dynamic as well
                    Text(this.data.titleDatesStr, textAlign: TextAlign.center, style: titleDateScript),
                    Text("\n\n" + this.data.titleDescStr, textAlign: TextAlign.center, style: titleSubscriptScript)
                  ],)
            ));
        targetWidgetS2 = new Expanded(flex: 1, child: Container(color: title_Colors.secondary, height: 300.0));
        break;
      default:
        if(index % 2 == 0){
          if(this.data.segments.length != 0) {
            double targetHeight = getHeightFromText(TimelineSegView.isPortrait, this.data.segments.elementAt(itemIndex).desc.length); // We will do some crude scaling

            targetWidgetS1 = new Expanded(flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(color: items_Colors.secondary, height: 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).header, textAlign: TextAlign.center, style: itemHeaderScript)),
                    Container(color: items_Colors.primary, height: targetHeight, padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).desc, textAlign: TextAlign.center, style: itemDescScript)),
                  ],
                )
            );

            targetWidgetM = new Expanded(flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(color: center_Colors.primary, alignment: Alignment.bottomCenter, height: targetHeight / 3.0 + 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp1.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp1.extension),
                            textAlign: TextAlign.center, style: centerDateScript)),
                    Container(color: center_Colors.primary, alignment: Alignment.center, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(" To ", textAlign: TextAlign.center, style: centerDateScript)),
                    Container(color: center_Colors.primary, alignment: Alignment.topCenter, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp2.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp2.extension),
                            textAlign: TextAlign.center, style: centerDateScript)),
                  ],
                )
            );
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: targetHeight + 12.0));

            itemIndex++;
          } else { // This is the default pre-build, when Firebase is not up and running
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.primary, height: 70.0));
            targetWidgetM = new Expanded(flex: 2, child: Container(color: center_Colors.primary, height: 70.0)); // The height is dynamic
            targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: 70.0));
          }
        } else {
          print("Scalable filler space");
          targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetM = new Expanded(flex: 2, child: Container(color: center_Colors.primary, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
        }
        break;
    }
  }

  // TODO: Edit mode needs to listen changes in the TimelineData theme colors
  // TODO: TextField needs to replace
  TimelineSegView.editMode({Key key, this.index, this.data}){ // TODO: Include a boolean to indicate portrait or landscape and resize text values

    switch(index){
      case(0): // TODO: Extract info based on the _Name field
        targetWidgetS1 = new Expanded(flex: 1, child: Container(color: title_Colors.secondary, height: 300.0));
        targetWidgetM = new Expanded(flex: 10,
            child: Container(color: title_Colors.primary, height: 300.0,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Geological Time Scale", textAlign: TextAlign.center, style: titleNameScript), // TODO: This needs to be dynamic as well
                    Text(this.data.titleDatesStr, textAlign: TextAlign.center, style: titleDateScript),
                    Text("\n\n" + this.data.titleDescStr, textAlign: TextAlign.center, style: titleSubscriptScript)
                  ],)
            ));
        targetWidgetS2 = new Expanded(flex: 1, child: Container(color: title_Colors.secondary, height: 300.0));
        break;
      default:
        if(index % 2 == 0){
          if(this.data.segments.length != 0) {
            double targetHeight = getHeightFromText(TimelineSegView.isPortrait, this.data.segments.elementAt(itemIndex).desc.length); // We will do some crude scaling

            targetWidgetS1 = new Expanded(flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(color: items_Colors.secondary, height: 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).header, textAlign: TextAlign.center, style: itemHeaderScript)),
                    Container(color: items_Colors.primary, height: targetHeight, padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).desc, textAlign: TextAlign.center, style: itemDescScript)),
                  ],
                )
            );

            targetWidgetM = new Expanded(flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(color: center_Colors.primary, alignment: Alignment.bottomCenter, height: targetHeight / 3.0 + 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp1.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp1.extension),
                            textAlign: TextAlign.center, style: centerDateScript)),
                    Container(color: center_Colors.primary, alignment: Alignment.center, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(" To ", textAlign: TextAlign.center, style: centerDateScript)),
                    Container(color: center_Colors.primary, alignment: Alignment.topCenter, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp2.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp2.extension),
                            textAlign: TextAlign.center, style: centerDateScript)),
                  ],
                )
            );
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: targetHeight + 12.0));

            itemIndex++;
          } else { // This is the default pre-build, when Firebase is not up and running
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.primary, height: 70.0));
            targetWidgetM = new Expanded(flex: 2, child: Container(color: center_Colors.primary, height: 70.0)); // The height is dynamic
            targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: 70.0));
          }
        } else {
          print("Scalable filler space");
          targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetM = new Expanded(flex: 2, child: Container(color: center_Colors.primary, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_Colors.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
        }
        break;
    }
  }

  final int index;
  TimelineData data; // Data could be null if in creation mode

  static String titleStr;
  static int itemIndex = 0; // Knows where to access the item data for timeline
  static const double fillerHeight = 130.0;
  static bool isPortrait = true;

  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  static TimelineColorScheme center_Colors = new TimelineColorScheme(primary: new Color(0xFFe8e8e8), secondary: new Color(0xFFe8e8e8), text: new Color(0xFFe8e8e8));
  static TimelineColorScheme items_Colors = new TimelineColorScheme(primary: new Color(0xFFe8e8e8), secondary: new Color(0xFFe8e8e8), text: new Color(0xFFe8e8e8), filler: Color(0xFFe8e8e8));
  static TimelineColorScheme title_Colors = new TimelineColorScheme(primary: new Color(0xFFe8e8e8), secondary: new Color(0xFFe8e8e8), text: new Color(0xFFe8e8e8));

  static TextStyle titleNameScript = TextStyle( fontSize: 20, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'Amita');
  static TextStyle titleDateScript = TextStyle( fontSize: 9, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'Dokdo');
  static TextStyle titleSubscriptScript = TextStyle( fontSize: 7, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'EBGaramond');
  static TextStyle centerDateScript = TextStyle( fontSize: 6.5, color: new Color(0xFFE8D1D9), decoration: TextDecoration.none, fontFamily: 'Broadway');
  static TextStyle itemHeaderScript = TextStyle( fontSize: 10, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  static TextStyle itemDescScript = TextStyle( fontSize: 8, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
}
