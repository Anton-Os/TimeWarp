import 'package:flutter/material.dart';

import 'package:timewarpsoc/timeline_types.dart';

class ColorPickTextField extends StatefulWidget {
  const ColorPickTextField({Key key, this.placeholderStr}) : super(key: key);

  static const TextStyle formFieldScript = TextStyle(fontSize: 9, color: Color(0xFFc8c7f2), decoration: TextDecoration.none, fontFamily: 'EBGaramond');
  static const double formFieldHeight = 30.0;

  final String placeholderStr;

  @override
  _ColorPickTextField createState() => _ColorPickTextField();
}

class _ColorPickTextField extends State<ColorPickTextField> {
  @override
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: ColorPickTextField.formFieldHeight,
      child: // TODO: Add a Color picker either here either in another area
        TextFormField(
          style: ColorPickTextField.formFieldScript,
          maxLines: 1,
          decoration:
            InputDecoration(
                contentPadding: EdgeInsets.only(top: 3, bottom: 3),
                hintText: widget.placeholderStr,
                hintStyle: ColorPickTextField.formFieldScript
            ),
          validator: (value){
            if(value.isEmpty){ return 'Cannot leave blank'; }
            // TODO: Validate hexadecimal color range: ie 1234567890ABCDEF
            else return null;
          },
        )
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
        color: CreateSettingsScreen.fullBk,
        child:
          Form(
            key: _formKey,
            child: Column(
            children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 15)),
                ColorPickTextField(placeholderStr: "Title Background Color"),
                ColorPickTextField(placeholderStr: "Title Secondary Color"),
                ColorPickTextField(placeholderStr: "Title Text Color"),
                Padding(padding: EdgeInsets.only(top: 15)),
                ColorPickTextField(placeholderStr: "Center Background Color"),
                ColorPickTextField(placeholderStr: "Center Secondary Color"),
                ColorPickTextField(placeholderStr: "Center Text Color"),
                Padding(padding: EdgeInsets.only(top: 15)),
                ColorPickTextField(placeholderStr: "Items Background Color"),
                ColorPickTextField(placeholderStr: "Items Secondary Color"),
                ColorPickTextField(placeholderStr: "Items Filler Color"),
                ColorPickTextField(placeholderStr: "Items Text Color"),
                Padding(padding: EdgeInsets.only(top: 15)),
              ],
            ),
          )
        )
    );
  }
}