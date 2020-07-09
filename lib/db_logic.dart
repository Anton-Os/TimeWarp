import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:timewarpsoc/timeline_types.dart';

class TimelineFirebaseDB {
  TimelineFirebaseDB(){
    initFirebase();
  }

  static TimelineData data;

  Future<void> initFirebase() async {
    // TODO: Support apple version as well eventually

    Firestore.instance.collection('timelines').document('iLakpSBa6Ps9hok5wMCJ').get()
      .then((DocumentSnapshot snapshot) {

      Iterable<MapEntry<String, dynamic>> timelineMap = snapshot.data.entries;
      // MapEntry<String, dynamic> currentMap = timelineMap.first; // Data from first element
      for(MapEntry entry in timelineMap){
        print("Found $entry field in timelineMap");

        if(entry.key[0] == '_') // For things not displayed as timeline items
          print("Special field encountered!"); // Handle the data here
        else {
          // TODO: Try to work around by using item_entries
          Map<String, dynamic> item_entries = new Map<String, dynamic>.from(entry.value);
          Iterable<dynamic> item_entriesDData = item_entries.values;

          for(String item_entry in item_entriesDData){ // Oddly not stored as a map
            /* switch(item_entry.key) {
              case("start"):
                print("Start!");
                break;
              case("end"):
                print("End!");
                break;
              case("desc"):
                print("Desc!");
                break;
              default:
                print("Not yet supported!!!");
                break;
            } */
          }
        }
      }

    });
  }
}
