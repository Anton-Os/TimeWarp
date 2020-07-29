import 'package:flutter/material.dart';

import 'package:timewarpsoc/ui_beauty.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerView extends StatefulWidget {
  ColorPickerView({Key key, this.pickerColor, this.colorTarget, this.colorScheme}) : super(key: key);

  Color pickerColor;
  Color targetColor;
  COLORSCHEME_Target colorTarget;
  TimelineColorScheme colorScheme;

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

    String titleText;
    switch(widget.colorTarget){
      case COLORSCHEME_Target.Primary:
        titleText = "Choose A Primary Color";
        break;
      case COLORSCHEME_Target.Secondary:
        titleText = "Choose A Secondary Color";
        break;
      case COLORSCHEME_Target.Filler:
        titleText = "Choose A Filler Color";
        break;
      case COLORSCHEME_Target.Text:
        titleText = "Choose A Text Color";
        break;
    }

    return AlertDialog(
      title: Text(titleText),
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