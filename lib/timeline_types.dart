
import 'package:flutter/cupertino.dart';

enum TIME_Months { NA, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
enum TIME_Scale { Years, Epochs, Hourly}

class TimePoint {
  int year;
  TIME_Months month = TIME_Months.NA;
  int day = 1; // From 1 to 31, anything out of range including zero omits day

  int hour = 0;
  int minute = 0;
  // TODO: Make a clock structure for storing hours
}

class TimelineSegData {
  TimePoint tp1;
  TimePoint tp2;

  String header;
  String desc;

  Image img;
  // Location loc maybe
}

class TimelineData {
  TIME_Scale scale;
  List<TimelineSegData> segments;
  Iterable<MapEntry<String, int>> themeColors;
}