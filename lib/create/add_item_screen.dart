import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:timewarpsoc/create/time_picker_view.dart';
import 'package:timewarpsoc/create_screen.dart';
import 'package:timewarpsoc/helper/db_logic.dart';
import 'package:timewarpsoc/helper/timeline_types.dart';

class AddItemScreen extends StatefulWidget {
  AddItemScreen({Key key, this.DB }) : super(key: key);

  final Timeline_FirebaseDB DB;
  TimelineSegData segment;
  static TimePickerView timePickerView1;
  static TimePickerView timePickerView2;

  String nameHint = "Event Name";
  String descHint = "Event Description";
  TextEditingController nameFieldCtrl = TextEditingController();
  TextEditingController descFieldCtrl = TextEditingController();

  // TODO: Make the colors based on the existing color themes
  static const Color bkColor = Color(0xFFe6a673);
  static const Color fieldColor = Color(0xFFfcc395);
  static const Color timePickColor = Color(0xFFe0a84c);
  static const Color bottomBtnColor = Color(0xFFffefe3);
  static const TextStyle textInputScript = TextStyle( fontSize: 12, color: Color(0xFF5c5c5c), decoration: TextDecoration.none, fontFamily: 'JosefinSlab');


  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddItemScreen.timePickerView1 = TimePickerView(scale: TIME_Scale.Years);
    AddItemScreen.timePickerView2 = TimePickerView(scale: TIME_Scale.Years);

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
                    controller: widget.nameFieldCtrl,
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
                    controller: widget.descFieldCtrl,
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
                  height: 200.0,
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  color: AddItemScreen.fieldColor,
                  child:
                  Row( // TODO: Add a button to change the scale type
                    children: <Widget>[
                      Expanded( child: AddItemScreen.timePickerView1),
                      Expanded( child: AddItemScreen.timePickerView2)
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    height: 20,
                    child:
                    SizedBox.expand(
                        child:
                        FlatButton(
                          color: AddItemScreen.bottomBtnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(3.0))
                          ),
                          onPressed: () {
                            print("Return Timepoints!");

                            if(widget.nameFieldCtrl.text.isNotEmpty && widget.descFieldCtrl.text.isNotEmpty) {
                              widget.segment = new TimelineSegData(
                                  header: widget.nameFieldCtrl.text,
                                  desc: widget.descFieldCtrl.text,
                                  tp1: AddItemScreen.timePickerView1.getTp(),
                                  tp2: AddItemScreen.timePickerView2.getTp()
                              );

                              // Testing stuff!! Mark for deletion
                              int testYear1 = widget.segment.tp1.year;
                              int testYear2 = widget.segment.tp2.year;
                              print("Years are $testYear1 and $testYear2");
                              // END OF TESTING

                              widget.DB.addDataSeg(widget.segment);

                              Navigator.pop(context); // Pop performed
                            } else {
                              setState(() { // TODO: Fix this initialization
                                widget.nameHint = "Event Name cannot be left empty!";
                                widget.descHint = "Event Description cannot be left empty";
                              });
                            }
                          },
                          child: Text("Save Entry",
                              style: AddItemScreen.textInputScript
                          ),
                        )
                    )
                ),
              ],
            )
        ),
      )
    );
  }
}