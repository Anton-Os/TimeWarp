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

    Firestore.instance
        .collection('timelines').document('iLakpSBa6Ps9hok5wMCJ')
        .get().then((DocumentSnapshot snapshot) {
      Iterable<MapEntry<String, dynamic>> timelineMap = snapshot.data.entries;

      MapEntry<String, dynamic> currentMap = timelineMap.first; // Data from first element
      // List<String> testVal = currentMap.value;

    });
  }
}
