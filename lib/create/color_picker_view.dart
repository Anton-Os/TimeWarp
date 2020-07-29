import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';



class ColorPickerView extends StatefulWidget {
  ColorPickerView({Key key, this.pickerColor}) : super(key: key);

  Color pickerColor;
  Color targetColor;

  Color get getTargetColor { return targetColor; }

  @override
  _ColorPickerView createState() => _ColorPickerView();
}

class _ColorPickerView extends State<ColorPickerView>{
  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose a Color"), // TODO: Add what the color is targeting
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: changeColor,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Got it'),
          onPressed: () {
            setState(() => widget.targetColor = widget.pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}