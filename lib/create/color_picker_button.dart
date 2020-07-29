import 'package:flutter/material.dart';

import 'package:timewarpsoc/ui_beauty.dart';
import 'package:timewarpsoc/create/color_picker_view.dart';

class ColorPickerButton extends StatefulWidget {
  ColorPickerButton({Key key, this.colorTarget, this.colorScheme}) : super(key: key);

  Color bkColor;
  COLORSCHEME_Target colorTarget;
  TimelineColorScheme colorScheme;

  @override
  _ColorPickerButton createState() => _ColorPickerButton();
}

class _ColorPickerButton extends State<ColorPickerButton> {
  // TODO: Fix color picker, make entry look nicer

  @override
  Widget build(BuildContext context) {
    switch(widget.colorTarget){
      case COLORSCHEME_Target.Primary:
        widget.bkColor = widget.colorScheme.getPrimary;
        break;
      case COLORSCHEME_Target.Secondary:
        widget.bkColor = widget.colorScheme.getSecondary;
        break;
      case COLORSCHEME_Target.Filler:
        widget.bkColor = widget.colorScheme.getFiller;
        break;
      case COLORSCHEME_Target.Text:
        widget.bkColor = widget.colorScheme.getText;
        break;
    }

    // ColorPickerView colorPickerView = ColorPickerView(pickerColor: widget.bkColor);

    return SizedBox(
        height: 20,
        width: 20,
        child:
        RaisedButton(
          color: widget.bkColor,
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext dialogContext) {
                return new ColorPickerView(
                    pickerColor: widget.bkColor,
                    colorTarget: widget.colorTarget,
                    colorScheme: widget.colorScheme,
                );
              },
            );
          },
        )
    );
  }
}