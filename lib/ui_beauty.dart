import 'package:flutter/material.dart';

/* enum COLORSCHEME_Target {
  Title_Primary,
  Title_Secondary,
  Title_Text,

  Item_Primary,
  Item_Secondary,
  Item_Filler,
  Item_Text,

  Center_Primary,
  Center_Secondary,
  Center_Text
} */

enum COLORSCHEME_Target {
  Primary,
  Secondary,
  Filler,
  Text
}


class TimelineColorScheme {
  TimelineColorScheme({ this.primary, this.secondary, this.filler, this.text}){}
  Color primary = new Color(0xFFdddddd);
  Color secondary = new Color(0xFFdddddd);
  Color filler = new Color(0xFFdddddd);
  Color text = new Color(0xFFdddddd);

  set setPrimary (Color targetColor){ primary = targetColor; }
  set setSecondary (Color targetColor){ secondary = targetColor; }
  set setFiller (Color targetColor){ filler = targetColor; }
  set setText (Color targetColor){ text = targetColor; }

  Color get getPrimary { return primary; }
  Color get getSecondary { return secondary; }
  Color get getFiller { return filler; }
  Color get getText { return text; }
}

// Add experimental widgets here