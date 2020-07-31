import 'package:timewarpsoc/helper/timeline_types.dart';

// The problem is that Years have no way to differentiate between ACE and BCE
TIME_Extension getExtFromScale(TIME_Scale scale){
  switch(scale){
    case TIME_Scale.Years:
      return TIME_Extension.ACE;
      break;
    case TIME_Scale.Precision:
      return TIME_Extension.ACE;
      break;
    case TIME_Scale.Epochs:
      return TIME_Extension.MYA;
      break;
    default:
      return TIME_Extension.NA;
      break;
  }
}

// Get the string version of the date extension enumeration
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

int getNumFromMonth(TIME_Months month){
  switch(month){
    case TIME_Months.Jan: return 1;
    case TIME_Months.Feb: return 2;
    case TIME_Months.Mar: return 3;
    case TIME_Months.Apr: return 4;
    case TIME_Months.May: return 5;
    case TIME_Months.Jun: return 6;
    case TIME_Months.Jul: return 7;
    case TIME_Months.Aug: return 8;
    case TIME_Months.Sep: return 9;
    case TIME_Months.Oct: return 10;
    case TIME_Months.Nov: return 11;
    case TIME_Months.Dec: return 12;
  }
}

TIME_Months getMonthFromNum(int num){
  switch(num){
    case 1: return TIME_Months.Jan;
    case 2: return TIME_Months.Feb;
    case 3: return TIME_Months.Mar;
    case 4: return TIME_Months.Apr;
    case 5: return TIME_Months.May;
    case 6: return TIME_Months.Jun;
    case 7: return TIME_Months.Jul;
    case 8: return TIME_Months.Aug;
    case 9: return TIME_Months.Sep;
    case 10: return TIME_Months.Oct;
    case 11: return TIME_Months.Nov;
    case 12: return TIME_Months.Dec;
  }
}

// Retrieve the extension, ACE, BCE, or MYA from a string
TIME_Extension getExtFromInput(String str){
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
      default:
        extension = TIME_Extension.ACE; // For the 'Present' case, FIX THIS!
        break;
    }
    if(extension != TIME_Extension.NA) break;
  }

  return extension;
}

// Retrieve the year from the input string
int getYearFromInput(String str){
  String yearStr = '';

  assert(int.tryParse(str[0]) != null || str[0] == 'P'); // Checks for validity of the string

  if(str[0] == 'P'){ // PRESENT CASE, Return current year
    yearStr = str.substring(0, 7);
    if(yearStr == "Present") return 2020; // TODO: Make this get the current year
  }
  for(var i = 0; i < str.length; i++) {
    while (int.tryParse(str[i]) != null) {
      yearStr += str[i];
      i++; // Keep going until a non-numeric is hit
    }
  }

  TIME_Extension ext = getExtFromInput(str);
  assert(ext != TIME_Extension.NA); // Checks for extension validity

  int targetYear = (ext == TIME_Extension.ACE) ? int.parse(yearStr) : -1 * int.parse(yearStr);

  return int.parse(yearStr);
}

// Retrieve the month from input string
TIME_Months getMonthFromInput(String str){
  int index = str.indexOf('/'); // finding forward slash in the string\
  if(index < 0) return TIME_Months.NA;

  String monthStr = str.substring(index - 2, index);
  if(int.tryParse(monthStr) != null) return getMonthFromNum(int.parse(monthStr));
  else if(int.tryParse(monthStr[1]) != null) return getMonthFromNum(int.parse(monthStr[1])); // One character long, excludes Oct, Nov, Dec
  else return TIME_Months.NA;
}

// Retrieve the day from input string
int getDayFromInput(String str){
  int index = str.indexOf('/'); // finding forward slash in the string\
  if(index < 0) return 0;


  // TODO: Check that the day string does not go past 31, clamp to range!
  String dayStr = str.substring(index + 2, index);
  if(int.tryParse(dayStr) != null) return int.parse(dayStr);
  else if(int.tryParse(dayStr[1]) != null) return int.parse(dayStr[1]); // One character long
  else return 0;
}

// Retrieve the hour from input string
int getHourFromInput(String str){
  int index = str.indexOf(':'); // finding forward slash in the string\
  if(index < 0) return 0;

  // TODO: Check that the hour string does not go past 24, clamp to range!
  String hourStr = str.substring(index - 2, index);
  if(int.tryParse(hourStr) != null) return int.parse(hourStr);
  else if(int.tryParse(hourStr[1]) != null) return int.parse(hourStr[1]); // One character long
  else return 0;
}

// Retrieve the minute from input string
int getMinuteFromInput(String str){
  int index = str.indexOf(':'); // finding forward slash in the string\
  if(index < 0) return 0;

  // TODO: Check that the minute string does not go past 24, clamp to range!
  String minuteStr = str.substring(index - 2, index);
  if(int.tryParse(minuteStr) != null) return int.parse(minuteStr);
  else if(int.tryParse(minuteStr[1]) != null) return int.parse(minuteStr[1]); // One character long
  else return 0;
}