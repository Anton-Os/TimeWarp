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
    // TODO: Code for determining theme/colors should go here

    if(!colorsInit && data.themeColors.isNotEmpty) { // One time color initialization
      MapEntry colorsEntry;

      colorsEntry = data.themeColors.firstWhere((element) => element.key == "Title Colors");
      title_TCS = getColorsFromMapEntry(colorsEntry);

      colorsEntry = data.themeColors.firstWhere((element) => element.key == "Center Colors");
      center_TCS = getColorsFromMapEntry(colorsEntry);

      colorsEntry = data.themeColors.firstWhere((element) => element.key == "Item Colors");
      items_TCS = getColorsFromMapEntry(colorsEntry);

      colorsInit = true;
    }

    switch(index){
      case(0): // TODO: Extract info based on the _Name field
        targetWidgetS1 = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 300.0));
        targetWidgetM = new Expanded(flex: 10,
            child: Container(color: title_TCS.primary, height: 300.0,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Geological Time Scale", textAlign: TextAlign.center, style: titleNameTS), // TODO: This needs to be dynamic as well
                    Text(this.data.titleDatesStr, textAlign: TextAlign.center, style: titleDateTS),
                    Text("\n\n" + this.data.titleDescStr, textAlign: TextAlign.center, style: titleSubscriptTS)
                  ],)
            ));
        targetWidgetS2 = new Expanded(flex: 1, child: Container(color: title_TCS.secondary, height: 300.0));
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
                    Container(color: items_TCS.secondary, height: 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).header, textAlign: TextAlign.center, style: headerScriptTS)),
                    Container(color: items_TCS.primary, height: targetHeight, padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), // Minimum values
                        child: Text(this.data.segments.elementAt(itemIndex).desc, textAlign: TextAlign.center, style: descScriptTS)),
                  ],
                )
            );

            targetWidgetM = new Expanded(flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(color: center_TCS.primary, alignment: Alignment.bottomCenter, height: targetHeight / 3.0 + 12.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp1.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp1.extension),
                            textAlign: TextAlign.center, style: centerDateTS)),
                    Container(color: center_TCS.primary, alignment: Alignment.center, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(" To ", textAlign: TextAlign.center, style: centerDateTS)),
                    Container(color: center_TCS.primary, alignment: Alignment.topCenter, height: targetHeight / 3.0, padding: EdgeInsets.only(top: 2.0), // Minimum values
                        child: Text(
                            this.data.segments.elementAt(itemIndex).tp2.year.abs().toString() + " " + getStrFromExt(this.data.segments.elementAt(itemIndex).tp2.extension),
                            textAlign: TextAlign.center, style: centerDateTS)),
                  ],
                )
            );
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: targetHeight + 12.0));

            itemIndex++;
          } else { // This is the default pre-build, when Firebase is not up and running
            targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.primary, height: 70.0));
            targetWidgetM = new Expanded(flex: 2, child: Container(color: center_TCS.primary, height: 70.0)); // The height is dynamic
            targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: 70.0)); // The height is dynamic
            // itemIndex++;
          }
        } else {
          print("Scalable filler space");
          targetWidgetS1 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetM = new Expanded(flex: 2, child: Container(color: center_TCS.primary, height: TimelineSegView.fillerHeight)); // The height is dynamic
          targetWidgetS2 = new Expanded(flex: 5, child: Container(color: items_TCS.filler, height: TimelineSegView.fillerHeight)); // The height is dynamic
        }
        break;
    }
  }

  final int index;
  TimelineData data; // Data could be null if in creation mode

  static int itemIndex = 0; // Knows where to access the item data for timeline
  bool colorsInit = false;
  static const double fillerHeight = 130.0;
  static bool isPortrait = true;

  Widget targetWidgetS1; // left
  Widget targetWidgetM; // middle
  Widget targetWidgetS2; // right

  TimelineColorScheme center_TCS;
  // = new TimelineColorScheme(primary: new Color(0xFF6D665F), secondary: new Color(0xFF5E5A57), text: new Color(0xFF604040));
  TimelineColorScheme items_TCS; // Requires a filler color
  // = new TimelineColorScheme(primary: new Color(0xFFFFD385), secondary: new Color(0xFFDDAC5D), text: new Color(0xFF604040), filler: new Color(0xFFB19592));
  TimelineColorScheme title_TCS;
  // = new TimelineColorScheme(primary: new Color(0xFFFAEDC8), secondary: new Color(0xFFDED3B4), text: new Color(0xFF604040));

  TextStyle headerScriptTS = TextStyle( fontSize: 10, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  TextStyle descScriptTS = TextStyle( fontSize: 8, color: new Color(0xFF604040), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');
  TextStyle centerDateTS = TextStyle( fontSize: 6.5, color: new Color(0xFFE8D1D9), decoration: TextDecoration.none, fontFamily: 'Broadway');

  TextStyle titleNameTS = TextStyle( fontSize: 20, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'Amita');
  TextStyle titleDateTS = TextStyle( fontSize: 9, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'Dokdo');
  TextStyle titleSubscriptTS = TextStyle( fontSize: 7, color: new Color(0xFF420D20), decoration: TextDecoration.none, fontFamily: 'EBGaramond');
}
