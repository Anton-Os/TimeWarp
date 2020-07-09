import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:timewarpsoc/timeline_types.dart';

class TimelineFirebaseDB {
  TimelineFirebaseDB(){
    initFirebase();
  }

  static TimelineData data = new TimelineData();

  Future<void> initFirebase() async {
    // TODO: Support apple version as well eventually

    Firestore.instance.collection('timelines').document('iLakpSBa6Ps9hok5wMCJ').get()
      .then((DocumentSnapshot snapshot) {

      Iterable<MapEntry<String, dynamic>> timelineMap = snapshot.data.entries;
      // MapEntry<String, dynamic> currentMap = timelineMap.first; // Data from first element
      for(MapEntry entry in timelineMap){
        print("Found $entry field in timelineMap");

        if(entry.key[0] == '_') { // For things not displayed as timeline items
          print("Special field encountered!"); // Handle the special
        }
        else {

          String desc = "";
          TimePoint tp1;
          TimePoint tp2;

          Map<String, dynamic> item_entries = new Map<String, dynamic>.from(entry.value);
          item_entries.entries.forEach((item_entry) {
            switch(item_entry.key) {
              case("start"):
                tp1 = new TimePoint(year: getYearFromStr(item_entry.value.toString()));
                break;
              case("end"):
                tp2 = new TimePoint(year: getYearFromStr(item_entry.value.toString()));
                break;
              case("desc"):
                desc = item_entry.value.toString(); // TODO: Fix with new
                break;
              default:
                print("Not yet supported!!!");
                break;
            }
          });

          TimelineSegData segment = new TimelineSegData(
              header: entry.key, desc: desc, tp1: tp1, tp2: tp2
          );
          data.segments.add(segment);
        }
      }

    });
  }
}
