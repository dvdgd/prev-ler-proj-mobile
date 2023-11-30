import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyConverter {
  static Future<String> fileToBase64(String filePath) async {
    File file = File(filePath);
    Uint8List fileBytes = await file.readAsBytes();
    String fileBase64 = base64.encode(fileBytes);

    return fileBase64;
  }

  static Future<String> binaryToBase64(Uint8List bytes) async {
    final base64String = base64Encode(bytes);
    return Future.value(base64String);
  }

  static Uint8List base64Binary(String base64File) {
    Uint8List fileBytes = base64.decode(base64File);
    return fileBytes;
  }

  static DateTime toDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.minute,
    );
  }

  static TimeOfDay toTimeOfDay(DateTime datetime) {
    return TimeOfDay.fromDateTime(datetime);
  }

  static String toDateTimeString(DateTime datetime) {
    return DateFormat('dd/MM/yy HH:mm:ss').format(datetime);
  }
}
