import 'package:flutter/material.dart';

import 'package:timewarpsoc/timeline_types.dart';

class ColorPickTextField extends StatefulWidget {
  const ColorPickTextField({Key key, this.placeholderStr}) : super(key: key);

  final String placeholderStr;

  @override
  _ColorPickTextField createState() => _ColorPickTextField();
}

class _ColorPickTextField extends State<ColorPickTextField> {
  @override
  Widget build(BuildContext context) {
    return
        Row(
          children: <Widget>[
            TextFormField( // TODO: Add a background image option here
              decoration: InputDecoration( hintText: widget.placeholderStr),
              validator: (value){
                if(value.isEmpty){ return 'Cannot leave blank'; }
                else return null;
              },
            )
            // TODO: Add a color picker box here
          ],
        );
  }
}

class CreateSettingsScreen extends StatefulWidget {
  const CreateSettingsScreen({Key key, TimelineData data}) : super(key: key);

  static const Color fullBk = Color(0xFF1a495e);

  @override
  _CreateSettingsScreen createState() => _CreateSettingsScreen();
}

class _CreateSettingsScreen extends State<CreateSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:
        Container(
            color: CreateSettingsScreen.fullBk,
            child:
            Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            )
        )
    );
  }
}

/* class _CreateSettingsScreen extends State<CreateSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: if else statement for screen orientation, app needs to change
    return MaterialApp(
        home:
          Container(
            color: CreateSettingsScreen.fullBk,
            // child: Form( //
              child:
              Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                // TODO: Resolve the MaterialApp issue, attempt to use Textfield instead of
                Row( children: <Widget>[
                  TextField(decoration: InputDecoration( hintText: "Title Background Color"))
                  ],)
                // ColorPickTextField(placeholderStr: "Title Background Color"),
                // ColorPickTextField(placeholderStr: "Title Secondary Color"),
                // ColorPickTextField(placeholderStr: "Title Text Color"),
              ],
              )
          )
    );
  }
} */