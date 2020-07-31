import 'package:flutter/material.dart';

import 'package:timewarpsoc/helper/db_logic.dart';
import 'package:timewarpsoc/helper/ui_beauty.dart';

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

class ColorPickerButton extends StatefulWidget {
  ColorPickerButton({Key key, this.DB, this.isEnlarged, this.colorTarget, this.colorScheme}) : super(key: key);

  final Timeline_FirebaseDB DB; // TODO: Upload color data to the Database theme!!!
  Color bkColor; // Possibly move to the State Class
  final bool isEnlarged;
  final COLORSCHEME_Target colorTarget;
  final TimelineColorScheme colorScheme;

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

    return SizedBox(
        height: (widget.isEnlarged)? 20 : 16,
        width: (widget.isEnlarged)? 20 : 16,
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

            // This needs to fit into the ColorPickerView call
            print("Dialog Exited!"); // See when this output occurs
            widget.bkColor = ColorPickerView.targetColor;
            setState(() {}); // Reloading button color
          },
        )
    );
  }
}
