import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initFirebase() async {
  // TODO: Support apple version as well eventually
  /* final FirebaseApp firebaseApp = await FirebaseApp.configure(
      name: 'TimeTravelSociety',
      options: FirebaseOptions(
        googleAppID: '1:344997468787:android:96a8cbb7888dff6ae9a806',
        apiKey: 'AIzaSyDKlgV4DCQOFhA6hjurkAgX7f0KeIEwAxA',
        databaseURL: 'https://timewarpsoc.firebaseio.com'
      )
  ); */

  Firestore.instance
      .collection('timelines').document('iLakpSBa6Ps9hok5wMCJ')
      .get().then((DocumentSnapshot snapshot){

        Iterable<MapEntry<String, dynamic>> timelineMap = snapshot.data.entries;

        MapEntry<String, dynamic> currentMap = timelineMap.first; // Data from first element
        // List<String> testVal = currentMap.value;

  });
}
