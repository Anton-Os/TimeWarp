import 'package:flutter/material.dart';

import 'package:timewarpsoc/ui_beauty.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerView extends StatefulWidget {
  ColorPickerView({Key key, this.pickerColor, this.colorTarget, this.colorScheme}) : super(key: key);

  Color pickerColor;
  Color targetColor;
  COLORSCHEME_Target colorTarget;
  TimelineColorScheme colorScheme;
  // String titleText; // TODO: Use switch case and replace the title text in AlertDialog!

  Color get getTargetColor { return targetColor; }

  @override
  _ColorPickerView createState() => _ColorPickerView();
}

class _ColorPickerView extends State<ColorPickerView>{
  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
  }

  // TODO: Fix color picker, make entry look nicer
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Choose a Color"),
      content: SingleChildScrollView(
        child:
          MaterialPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: changeColor
          ) // TODO: Make this disabled in landscape mode
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Select'),
          onPressed: () {
            setState(() => widget.targetColor = widget.pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}