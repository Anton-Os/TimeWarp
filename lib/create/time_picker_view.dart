import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:timewarpsoc/timeline_types.dart';

class TimePickerField extends StatefulWidget {
  TimePickerField({Key key, this.scale, this.placeholder, this.lowerLimit, this.upperLimit}) : super(key: key) {
    assert(upperLimit > lowerLimit);
  }

  int currentVal = 0;
  int longPressRepeat = 0;
  List<int> smartLongPressInc = { 5, 10, 20, 50, 100 };

  final TIME_Scale scale;
  final String placeholder;
  final int lowerLimit;
  final int upperLimit;

  static const Color fieldColor = Color(0xFFfcc395);
  static const TextStyle descScript = TextStyle( fontSize: 8, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');
  static const TextStyle numScript = TextStyle( fontSize: 7, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  @override
  _TimePickerField createState() => _TimePickerField();
}

class _TimePickerField extends State<TimePickerField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
      color: TimePickerField.fieldColor,]
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
                  longPressRepeat = 0;
                  setState((){ }); // TODO: Make sure this does not reset
                },
                onLongPress: (){
                  int smartIncIndex = (longPressRepeat > 4)? 4 : longPressRepeat; // Clamping the index value
                  longPressRepeat -= widget.smartLongPressInc[smartIncIndex];
                  longPressRepeat++;
                  setState((){ });  // TODO: Make sure this does not reset
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
                      longPressRepeat = 0;
                      setState((){ }); // TODO: Make sure this does not reset
                    },
                    onLongPress: (){
                      int smartIncIndex = (longPressRepeat > 4)? 4 : longPressRepeat; // Clamping the index value
                      longPressRepeat += widget.smartLongPressInc[smartIncIndex];
                      longPressRepeat++;
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
  const TimePickerView({Key key, this.scale}) : super(key: key);

  final TIME_Scale scale;

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFe6ba97);
  static const Color topColor = Color(0xFFffefe3);
  static const TextStyle topScript = TextStyle( fontSize: 8, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  @override
  _TimePickerView createState() => _TimePickerView();
}

class _TimePickerView extends State<TimePickerView> {
  @override
  Widget build(BuildContext context) {
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
                  TimePickerField(placeholder: "Year", lowerLimit: 0, upperLimit: 4000),
                  TimePickerField(placeholder: "Month", lowerLimit: 1, upperLimit: 12),
                  TimePickerField(placeholder: "Day", lowerLimit: 1, upperLimit: 31),
                  TimePickerField(placeholder: "Hour", lowerLimit: 1, upperLimit: 24),
                  TimePickerField(placeholder: "Minute", lowerLimit: 1, upperLimit: 60),
                ],
              )
              // Text('Start Time', style: TimePickerView.textInputScript)
          )
      );
  }
}
