
import 'package:flutter/cupertino.dart';

enum TIME_Months { NA, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
enum TIME_Scale { Years, Epochs, Hourly}

class TimePoint {
  TimePoint({this.year, TIME_Months month, int day, int hour, int minute}){}

  final int year; // Must be set
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

TimePoint genTpFromStr(String str){
  assert(str != null);
  
  String yearStr;
  String yearExtensionStr;

  String monthStr;
  String dayStr;
  String minuteStr;
  String secondStr;

  assert(int.tryParse(str[0]) != null); // First character should numeric
  for(var i = 0; i < str.length; i++){
    while(int.tryParse(str[i]) != null){
      yearStr += str[i];
      i++; // Keep going until a non-numeric is hit
    }
    while(str[i] == ' ') continue; // Skip all the white space

    /* int extensionStartIndex = i;
    while(i < extensionStartIndex + 3) { // Extension is 3 characters long
      yearExtensionStr += str[i];
      i++;
    } */
  }
  return TimePoint(year: int.parse(yearStr)); // Default, year is all that is a must
}

class TimelineData {
  TIME_Scale scale;
  List<TimelineSegData> segments;
  Iterable<MapEntry<String, int>> themeColors;
}