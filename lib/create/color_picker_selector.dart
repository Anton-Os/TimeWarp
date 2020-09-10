import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:timewarpsoc/helper/db_logic.dart';
import 'package:timewarpsoc/helper/ui_beauty.dart';

class ColorPickerView extends StatefulWidget {
  ColorPickerView({Key key, this.pickerColor, this.colorTarget, this.colorScheme}) : super(key: key){
    assert(pickerColor != null);

    switch(colorTarget){
      case COLORSCHEME_Target.Primary:
        titleText = "Choose A Primary Color";
        pickerColor = colorScheme.primary;
        break;
      case COLORSCHEME_Target.Secondary:
        titleText = "Choose A Secondary Color";
        pickerColor = colorScheme.secondary;
        break;
      case COLORSCHEME_Target.Filler:
        titleText = "Choose A Filler Color";
        pickerColor = colorScheme.filler;
        break;
      case COLORSCHEME_Target.Text:
        titleText = "Choose A Text Color";
        pickerColor = colorScheme.text;
        break;
    }

    // Goes after value assignments
    redSlideVal = pickerColor.red.toDouble();
    greenSlideVal = pickerColor.green.toDouble();
    blueSlideVal = pickerColor.blue.toDouble();
  }

  String titleText;
  bool isInit = false;
  Color pickerColor;
  static Color targetColor;
  COLORSCHEME_Target colorTarget;
  TimelineColorScheme colorScheme;

  double redSlideVal;
  double greenSlideVal;
  double blueSlideVal;

  // static Color targetColor; // This should be accessible once the view terminates
  static TextStyle headerScript = TextStyle( fontSize: 9, color: Color(0xFF333333), decoration: TextDecoration.none, fontFamily: 'PermanentMarker');

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
      title: Text(widget.titleText, textAlign: TextAlign.center, style: ColorPickerView.headerScript),
      content: SingleChildScrollView(
          child:
          Container(
            width: 100,
            height: 100,
            color: widget.pickerColor,
          )
      ),
      actions: <Widget>[
        Container(
          height: 30,
          child:
          Slider(
            value: widget.redSlideVal,
            min: 0.0,
            max: 255.0,
            activeColor: Color(0xFFFF0000), // TODO: Fix the slider, copy/paste for others!
            // onChanged: (value) => (setState(() { widget.pickerColor = Color.fromRGBO(widget.redSlideVal.toInt(), widget.pickerColor.green, widget.pickerColor.blue, 1.0); })),
            onChanged: (value) => (setState((){
              widget.redSlideVal = value;
              widget.pickerColor = Color.fromRGBO(widget.redSlideVal.toInt(), widget.pickerColor.green, widget.pickerColor.blue, 1.0);}
            ))
          )
        ),
        Container(
          height: 30,
          child:
          Slider(
              value: widget.greenSlideVal,
              min: 0.0,
              max: 255.0,
              activeColor: Color(0xFF00FF00),
              onChanged: (value) => (setState((){
                widget.greenSlideVal = value;
                widget.pickerColor = Color.fromRGBO(widget.pickerColor.red, widget.greenSlideVal.toInt(), widget.pickerColor.blue, 1.0);}
              ))
          )
        ),
        Container(
          height: 30,
          child:
          Slider(
              value: widget.blueSlideVal,
              min: 0.0,
              max: 255.0,
              activeColor: Color(0xFF0000FF),
              onChanged: (value) => (setState((){
                widget.blueSlideVal = value;
                widget.pickerColor = Color.fromRGBO(widget.pickerColor.red, widget.pickerColor.green, widget.blueSlideVal.toInt(), 1.0);}
              ))
          )
        ),
        FlatButton(
          child: const Text('Select', textAlign: TextAlign.center,),

          // TODO: Refine this code
          onPressed: () {
            switch(widget.colorTarget){
              case COLORSCHEME_Target.Primary:
                widget.colorScheme.setPrimary = widget.pickerColor;
                break;
              case COLORSCHEME_Target.Secondary:
                widget.colorScheme.setSecondary = widget.pickerColor;
                break;
              case COLORSCHEME_Target.Filler:
                widget.colorScheme.setFiller = widget.pickerColor;
                break;
              case COLORSCHEME_Target.Text:
                widget.colorScheme.setText = widget.pickerColor;
                break;
            }

            ColorPickerView.targetColor = widget.pickerColor;
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
