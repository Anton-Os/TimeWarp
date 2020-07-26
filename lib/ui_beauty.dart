import 'package:flutter/material.dart';

class TimelineColorScheme {
  TimelineColorScheme({ this.primary, this.secondary, this.filler, this.text}){}
  Color primary = new Color(0xFFdddddd);
  Color secondary = new Color(0xFFdddddd);
  Color filler = new Color(0xFFdddddd);
  Color text = new Color(0xFFdddddd);

  Color get getPrimary { return primary; }
  Color get getSecondary { return secondary; }
  Color get getFiller { return filler; }
  Color get getText { return text; }
}

// Add experimental widgets here