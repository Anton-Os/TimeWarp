enum TIME_Months { NA, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
enum TIME_Scale { Years, Epochs, Hourly}

class TimePoint {
  int year;
  TIME_Months month;
  int day; // From 1 to 31, anything out of range including zero omits day
  // TODO: Make a clock structure for storing hours
}

class TimelineData {
  TIME_Scale scale;
  TimePoint startPoint;
  TimePoint endPoint;
}