import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timewarpsoc/helper/timeline_conversion.dart';

import 'package:timewarpsoc/helper/timeline_types.dart';

class TimePickerField extends StatefulWidget {
  TimePickerField({Key key, this.scale, this.currentVal, this.placeholder, this.lowerLimit, this.upperLimit}) : super(key: key) {
    assert(upperLimit > lowerLimit);
  }

  int currentVal = 0;
  int longPressRepeat = 0;
  List<int> smartLongPressInc = [ 5, 5, 10, 10, 20, 20, 50, 100 ];

  bool isActive = true; // Becomes false if the scale is mismatched
  final TIME_Scale scale;
  final String placeholder;
  final int lowerLimit;
  final int upperLimit;

  static const Color fieldColor = Color(0xFFefefef);
  static const TextStyle descScript = TextStyle( fontSize: 8, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');
  static const TextStyle numScript = TextStyle( fontSize: 7, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  int get getVal { return currentVal; }

  @override
  _TimePickerField createState() => _TimePickerField();
}

class _TimePickerField extends State<TimePickerField> {
  @override
  Widget build(BuildContext context) {
    int newVal = widget.currentVal;

    switch(widget.scale){
      case TIME_Scale.Epochs:
        switch(widget.placeholder){
          case("Month"): case("Day"): case("Hour"): case("Minute"):
            widget.isActive = false;
            break;
        }
        break;
      case TIME_Scale.Years:
        switch(widget.placeholder){
          case("Hour"): case("Minute"):
          widget.isActive = false;
          break;
        }
        break;
      default: // With precision scale all of the time parameters have some value
        break;
    }

    String valStr = widget.currentVal.toString();

    if(widget.placeholder == "Year")
      valStr += (widget.currentVal > 0) ? " ACE" : " BCE";
    if(widget.placeholder == "Month")
      valStr = getStrFromMonth(getMonthFromNum(widget.currentVal));

    return Container(
      height: 24.0,
      margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
      color: TimePickerField.fieldColor,
      child: (widget.isActive) ? Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Text(widget.placeholder, style: TimePickerField.descScript, textAlign: TextAlign.center)
          ),
          Expanded( // Decrement Button, TODO: Add Image as child
            flex: 1,
            child: SizedBox.expand(
              child: RaisedButton(
                onPressed: (){
                  widget.currentVal--;
                  widget.longPressRepeat = 0;
                  if(widget.currentVal < widget.lowerLimit) widget.currentVal++;
                  setState((){ });
                },
                onLongPress: (){
                  int smartIncIndex = (widget.longPressRepeat > widget.smartLongPressInc.length - 1)? widget.smartLongPressInc.length - 1 : widget.longPressRepeat; // Clamping the index value
                  widget.longPressRepeat -= widget.smartLongPressInc[smartIncIndex];
                  widget.longPressRepeat++;
                  if(widget.currentVal < widget.lowerLimit) widget.currentVal = widget.lowerLimit;
                  setState((){ });
                },
              )
            )
          ),
          Expanded(
              flex: 3,
              child: Text(valStr, style: TimePickerField.numScript, textAlign: TextAlign.center)
          ),
          Expanded( // Decrement Button, TODO: Add Image as child
              flex: 1,
              child: SizedBox.expand(
                  child: RaisedButton(
                    onPressed: (){
                      widget.currentVal++;
                      widget.longPressRepeat = 0;
                      if(widget.currentVal > widget.upperLimit) widget.currentVal--;
                      setState((){ }); // TODO: Make sure this does not reset
                    },
                    onLongPress: (){
                      int smartIncIndex = (widget.longPressRepeat > widget.smartLongPressInc.length - 1)? widget.smartLongPressInc.length - 1 : widget.longPressRepeat; // Clamping the index value
                      widget.longPressRepeat += widget.smartLongPressInc[smartIncIndex];
                      widget.longPressRepeat++;
                      if(widget.currentVal > widget.upperLimit) widget.currentVal = widget.upperLimit;
                      setState((){ });  // TODO: Make sure this does not reset
                    },
                  )
              )
          ),
        ],
      ) : Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Text(widget.placeholder, style: TimePickerField.descScript, textAlign: TextAlign.center)
          ),
        ],
      )
    );
  }
}


enum TIMEPICKER_Target {
  Start,
  End
}

class TimePickerView extends StatefulWidget {
  TimePickerView({Key key, this.isFirst, this.scale}) : super(key: key);

  final TIME_Scale scale;
  final bool isFirst; // Indicates if it is the first TimePoint

  TimePickerField yearField;
  TimePickerField monthField;
  TimePickerField dayField;
  TimePickerField hourField;
  TimePickerField minuteField;

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFaaaaaa);
  static const Color topColor = Color(0xFF5c5c5c);
  static const TextStyle topScript = TextStyle( fontSize: 8, color: Color(0xFFfcba03), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  TimePoint getTp(){
    print("Get timepoint hit!");

    return new TimePoint(
        year: yearField.getVal,
        extension: TIME_Extension.ACE, // TODO: Retrive this data by performing switch(scale)
        month: TIME_Months.Dec, // TODO: Retrive this data by performing switch(monthField.getVal)
        day: dayField.getVal,
        minute: minuteField.getVal
    );
  }

  @override
  _TimePickerView createState() => _TimePickerView();
}

class _TimePickerView extends State<TimePickerView> {
  @override
  Widget build(BuildContext context) {
    widget.yearField = TimePickerField(
        scale: widget.scale,
        currentVal: (widget.scale != TIME_Scale.Epochs)? 2000 : 100,
        placeholder: "Year",
        lowerLimit: (widget.scale == TIME_Scale.Years)? -4000 : 0, // Negative values are BCE
        upperLimit: (widget.scale != TIME_Scale.Epochs)? 2020 : 1380
    );
    widget.monthField = TimePickerField(scale: widget.scale, currentVal: 1, placeholder: "Month", lowerLimit: 1, upperLimit: 12);
    widget.dayField = TimePickerField(scale: widget.scale, currentVal: 0, placeholder: "Day", lowerLimit: 1, upperLimit: 31);
    widget.hourField = TimePickerField(scale: widget.scale, currentVal: (widget.scale != TIME_Scale.Precision)? 0 : 12, placeholder: "Hour", lowerLimit: 1, upperLimit: 24);
    widget.minuteField = TimePickerField(scale: widget.scale, currentVal: 0, placeholder: "Minute", lowerLimit: 1, upperLimit: 60);

    String timePointAppend = (widget.isFirst)? 'A' : 'B';

    return
      Container(
          color: TimePickerView.bkColor,
          margin: EdgeInsets.all(4.0),
          child:
          SizedBox.expand(
              child: // TODO: Make this a column with selectable dates and times
              Column(
                children: <Widget>[
                  Container(
                    height: 13.0,
                    padding: EdgeInsets.only(top: 1.5),
                    color: TimePickerView.topColor,
                    child:
                      SizedBox(
                        width: double.infinity,
                        child:
                          Text("Time Point " + timePointAppend, style: TimePickerView.topScript, textAlign: TextAlign.center)
                      )
                  ),
                  widget.yearField,
                  widget.monthField,
                  widget.dayField,
                  widget.hourField,
                  widget.minuteField
                ],
              )
              // Text('Start Time', style: TimePickerView.textInputScript)
          )
      );
  }
}
