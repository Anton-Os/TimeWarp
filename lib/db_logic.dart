import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:timewarpsoc/timeline_types.dart';

class SearchRecords_FirebaseDB {
  SearchRecords_FirebaseDB(){}

  Future<void> init() async {
    // TODO: Refine database entries, storing name is not enough!
    Firestore.instance.collection('timelines').document('SearchRecord').get()
    .then((DocumentSnapshot snapshot){

        //Map<String, String> searchRecMap = snapshot.data.entries;
        searchRecMap = snapshot.data.entries;
        searchRecMap.forEach((element) {
          String keyStr = element.key;
          String valStr = element.value;
          print("$keyStr maps to $valStr in Search Records!"); // TEST CASE
        });
    });
  }

  Iterable<MapEntry<String, dynamic>> searchRecMap = [];
}

class Timeline_FirebaseDB{
  Timeline_FirebaseDB({ this.firebaseDocStr }) {}

  final String firebaseDocStr;
  TimelineData data = new TimelineData();

  Future<void> init() async {
    // TODO: Support apple version as well eventually
    if(data.segments.isNotEmpty) return; // Avoiding extra re-runs

    Firestore.instance.collection('timelines').document(firebaseDocStr).get()
    .then((DocumentSnapshot snapshot) {

      Iterable<MapEntry<String, dynamic>> timelineMap = snapshot.data.entries;
      // MapEntry<String, dynamic> currentMap = timelineMap.first; // Data from first element
      for(MapEntry entry in timelineMap){
        print("Found $entry field in timelineMap");

        if(entry.key[0] == '_') { // For things not displayed as timeline items
          Map<String, dynamic> item_entries = new Map<String, dynamic>.from(entry.value);
          switch(entry.key){
            case("_Meta"):
              item_entries.forEach((key, value) {
                switch(key){
                  case("dates"):
                    data.titleDatesStr = value;
                    break;
                  case("description"):
                    data.titleDescStr = value;
                    break;

                  default:
                    print("Unknown $key field encountered!");
                    break;
                }
              });
              break;
            case("_Theme"):
              data.themeColors = item_entries.entries;
              break;

            deault:
              print("Unknown $entry special field encountered");
              break;
          }
        }
        else {

          String desc = "";
          TimePoint tp1;
          TimePoint tp2;

          Map<String, dynamic> item_entries = new Map<String, dynamic>.from(entry.value);

          int itemIndex = 0; // To avoid RangeError use indexing instead
          while(itemIndex < item_entries.length){
            MapEntry item_entry = item_entries.entries.elementAt(itemIndex);
            switch (item_entry.key) {
              case("start"):
                tp1 = new TimePoint(
                    year: getYearFromStr(item_entry.value.toString()),
                    extension: getExtFromStr(item_entry.value.toString())
                );
                break;
              case("end"):
                tp2 = new TimePoint(
                    year: getYearFromStr(item_entry.value.toString()),
                    extension: getExtFromStr(item_entry.value.toString())
                );
                break;
              case("desc"):
                desc = item_entry.value.toString(); // TODO: Fix with new
                break;
              default:
                print("Not yet supported!!!");
                break;
            }
            itemIndex++;
          }

          TimelineSegData segment = new TimelineSegData(
              header: entry.key, desc: desc, tp1: tp1, tp2: tp2
          );

          // if(data.segments.indexWhere((element) => !(element.header.compareTo('222') == 0))
          data.segments.add(segment);
        }
      }

    });
  }

  Future<void> overwrite(TimelineData newData) async {
    // Implement upload data
  }
}
