import 'package:flutter/material.dart';

import 'package:timewarpsoc/ui_beauty.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerView extends StatefulWidget {
  ColorPickerView({Key key, this.pickerColor, this.colorTarget, this.colorScheme}) : super(key: key);

  static Color targetColor; // This should be accessible once the view terminates
  Color pickerColor;
  COLORSCHEME_Target colorTarget;
  TimelineColorScheme colorScheme;

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
        widget.pickerColor = widget.colorScheme.primary;
        break;
      case COLORSCHEME_Target.Secondary:
        titleText = "Choose A Secondary Color";
        widget.pickerColor = widget.colorScheme.secondary;
        break;
      case COLORSCHEME_Target.Filler:
        titleText = "Choose A Filler Color";
        widget.pickerColor = widget.colorScheme.filler;
        break;
      case COLORSCHEME_Target.Text:
        titleText = "Choose A Text Color";
        widget.pickerColor = widget.colorScheme.text;
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
            setState(() => ColorPickerView.targetColor = widget.pickerColor);

            /* switch(widget.colorTarget){
              case COLORSCHEME_Target.Primary:
                widget.colorScheme.setPrimary = ColorPickerView.targetColor;
                break;
              case COLORSCHEME_Target.Secondary:
                widget.colorScheme.setSecondary = ColorPickerView.targetColor;
                break;
              case COLORSCHEME_Target.Filler:
                widget.colorScheme.setFiller = ColorPickerView.targetColor;
                break;
              case COLORSCHEME_Target.Text:
                widget.colorScheme.setText = ColorPickerView.targetColor;
                break;
            } */

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
