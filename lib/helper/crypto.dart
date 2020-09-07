import 'package:uuid/uuid.dart';
import 'dart:convert'; // for the utf8.encode method

String genHash(){
  var uuid = Uuid();
  return uuid.v1(); // Generates and returns a time-based string
}