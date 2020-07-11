
import 'package:flutter/cupertino.dart';

enum TIME_Months { NA, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
enum TIME_Scale { NA, Years, Epochs, Hourly}
enum TIME_Extension { NA, ACE, BCE, MYA }

class TimePoint {
  TimePoint({this.year, this.extension, TIME_Months month, int day, int hour, int minute}){}

  TIME_Extension extension = TIME_Extension.ACE; // This will modify the suffixes and format displayed

  final int year; // Must be set
  TIME_Months month = TIME_Months.NA;
  int day = 1; // From 1 to 31, anything out of range including zero omits day

  int hour = 0;
  int minute = 0;
}
// TODO: Getter fun
class TimelineSegData {
  TimelineSegData({ this.header, this.desc, this.tp1, this.tp2, Image image }){
    if(image != null) this.img = image;
  }

  final String header; // This will be immutable
  final String desc;

  final TimePoint tp1;
  final TimePoint tp2;

  Image img; // Probably needs some default
  // Location loc maybe
}

int getYearFromStr(String str){
  String yearStr = '';

  assert(int.tryParse(str[0]) != null); // First character should numeric, good check
  for(var i = 0; i < str.length; i++) {
    while (int.tryParse(str[i]) != null) {
      yearStr += str[i];
      i++; // Keep going until a non-numeric is hit
    }
  }

  return int.parse(yearStr);
}

TIME_Extension getExtFromStr(String str){
  String extensionStr = '';
  TIME_Extension extension = TIME_Extension.NA;

  for(var i = 0; i < str.length - 2; i++) {
    extensionStr = str.substring(i, i + 3);
    switch(extensionStr.toUpperCase()){
      case("MYA"):
        extension = TIME_Extension.MYA;
        break;
      case("BCE"):
        extension = TIME_Extension.BCE;
        break;
      case("ACE"):
        extension = TIME_Extension.ACE;
        break;
    }
    if(extension != TIME_Extension.NA) break;
  }

  return extension;
}

String getStrFromExt(TIME_Extension extension){
  switch(extension){
    case(TIME_Extension.MYA):
      return "MYA";
    case(TIME_Extension.BCE):
      return "BCE";
    case(TIME_Extension.ACE):
      return "ACE";
    default:
      return "";
  }
}

class TimelineData {
  TIME_Scale scale = TIME_Scale.Years;
  List<TimelineSegData> segments = [];
  Iterable<MapEntry<String, int>> themeColors = [];
}