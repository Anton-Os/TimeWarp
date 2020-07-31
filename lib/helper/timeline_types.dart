
import 'package:flutter/cupertino.dart'; // Needed for Image type

enum TIME_Months { NA, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
enum TIME_Scale { NA, Years, Epochs, Precision}
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

class TimelineData {
  TIME_Scale scale = TIME_Scale.Years;
  List<TimelineSegData> segments = [];
  Iterable<MapEntry<String, dynamic>> themeColors = [];

  String titleDatesStr = "";
  String titleDescStr = "";
}