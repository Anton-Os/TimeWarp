import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:timewarpsoc/helper/timeline_types.dart';

class TimePickerField extends StatefulWidget {
  TimePickerField({Key key, this.scale, this.placeholder, this.lowerLimit, this.upperLimit}) : super(key: key) {
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

  static const Color fieldColor = Color(0xFFfcc395);
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

    /* if(widget.placeholder == "Year") // SPECIAL CASE!
       else if(widget.placeholder == "Month") // SPECIAL CASE
     */

    return Container(
      height: 24.0,
      margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
      color: TimePickerField.fieldColor,
      child: Row(
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
              child: Text(widget.currentVal.toString(), style: TimePickerField.numScript, textAlign: TextAlign.center)
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
      )
    );
  }
}


enum TIMEPICKER_Target {
  Start,
  End
}

class TimePickerView extends StatefulWidget {
  TimePickerView({Key key, this.scale}) : super(key: key);

  final TIME_Scale scale;

  TimePickerField yearField;
  TimePickerField monthField;
  TimePickerField dayField;
  TimePickerField hourField;
  TimePickerField minuteField;

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFe6ba97);
  static const Color topColor = Color(0xFFffefe3);
  static const TextStyle topScript = TextStyle( fontSize: 8, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');

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
    widget.yearField = TimePickerField(placeholder: "Year", lowerLimit: 0, upperLimit: 4000);
    widget.monthField = TimePickerField(placeholder: "Month", lowerLimit: 1, upperLimit: 12);
    widget.dayField = TimePickerField(placeholder: "Day", lowerLimit: 1, upperLimit: 31);
    widget.hourField = TimePickerField(placeholder: "Hour", lowerLimit: 1, upperLimit: 24);
    widget.minuteField = TimePickerField(placeholder: "Minute", lowerLimit: 1, upperLimit: 60);

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
                          Text("Time Point", style: TimePickerView.topScript, textAlign: TextAlign.center)
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
