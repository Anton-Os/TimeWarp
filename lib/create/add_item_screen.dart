import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TIMEPICKER_Target {
  Start,
  End
}

class TimePicker extends StatefulWidget {
  const TimePicker({Key key, this.type}) : super(key: key);

  final TIMEPICKER_Target type;

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFe6ba97);
  static const TextStyle textInputScript = TextStyle( fontSize: 10, color: Color(0xFF5e1b38), decoration: TextDecoration.none, fontFamily: 'Quicksand');

  @override
  _TimePicker createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: TimePicker.bkColor,
        margin: EdgeInsets.all(4.0),
        child:
        SizedBox.expand(
          child: // TODO: Make this a column with selectable dates and times
            Text('Start Time', style: TimePicker.textInputScript)
        )
      );
    /*return
      Text('Start Time', style: TimePicker.textInputScript); */
  }
}

class AddItemScreen extends StatefulWidget {

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFe6a673);
  static const Color fieldColor = Color(0xFFfcc395);
  static const Color timePickColor = Color(0xFFe0a84c);
  static const TextStyle textInputScript = TextStyle( fontSize: 12, color: Color(0xFF5c5c5c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');

  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Form(
        key: _formKey,
        child: Container(
          color: AddItemScreen.bkColor,
          child:
            Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 30.0,
                  padding: EdgeInsets.only(left: 5),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  color: AddItemScreen.fieldColor,
                  child: TextField(
                    style: AddItemScreen.textInputScript,
                    decoration: InputDecoration(
                      hintText: "Event Name",
                      hintStyle: AddItemScreen.textInputScript,
                      border: InputBorder.none
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 90.0,
                  padding: EdgeInsets.only(left: 5),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  color: AddItemScreen.fieldColor,
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    style: AddItemScreen.textInputScript,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        hintText: "Event Description",
                        hintStyle: AddItemScreen.textInputScript,
                        border: InputBorder.none
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 240.0,
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  color: AddItemScreen.fieldColor,
                  child:
                  Row(
                    children: <Widget>[
                      Expanded( child: TimePicker(type: TIMEPICKER_Target.Start)),
                      Expanded( child: TimePicker(type: TIMEPICKER_Target.End))
                    ],
                  ),
                ),
              ],
            )
        ),
      )
    );
  }
}