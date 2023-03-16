//DEV: Color Palette / All colors in app

import 'package:dopamine_box/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> reset = checkForDailyReset();

const Color darkThemeBackgroundColor = Color(0xFF0A0903);
const Color darkThemeTextColor = Color(0xFFE5E5E5);
const Color essentialTaskBackgroundColor = Color(0xFF1B1B1A);
const Color black = Color(0xFF1B1B1A);
const Color white = Color(0xFFE5E5E5);
const Color red = Color(0xFFFF1654);
const Color orange = Color(0xFFD74E09);
const Color yellow = Color(0xFFFF7F11);
const Color green = Color(0xFF09814A);
const Color greenAlternate1 = Color(0xFF06d6a0);
const Color otherGreen = Color.fromARGB(255, 4, 134, 74);
const Color blue = Color(0xFF247BA0);
const Color purple = Color(0xFFBC69AA);

const String doneSoundPath = 'assets/sounds/done.mp3';
const String levelComplete = 'assets/sounds/levelComplete.mp3';

const List<String> placeholderTasks = <String>[
  // "Brush in the morning (and take your vitamins)",
  // "Excercise for at least 30 minutes",
  // "Shower",
  // "Work on a side project",
  // "Work on a hobby",
  // "Skincare and brush at the end of the night",
];

const List<String> defaultTasks = <String>[
  ">= 30 minutes excercise ",
  "Do something for your body (bath/shower, skincare)",
  "Do something for your mind (read, puzzles)",
  "Do something for your creativity (draw, write, read)",
  "Do something for your home (clean, repair, expand)",
  "Do something for your future (meal prep, sleep early)",
];

Future<void> resetAllTasks() async {
  await dbHelper.resetTasks();
}

Future<bool> checkForDailyReset() async {
  final prefs = await SharedPreferences.getInstance();
  var timestamp = DateTime.now();

  if (prefs.getString('currTime') == null) {
    print("theres no curr string");
    await prefs.setString(
        'currTime', timestamp.millisecondsSinceEpoch.toString());
    return true;
  } else {
    var oldTimestamp = DateTime.fromMillisecondsSinceEpoch(
        int.parse(prefs.getString('currTime')!));

    await prefs.setString(
        'currTime', timestamp.millisecondsSinceEpoch.toString());

    //todo: compare oldTimestamp with timestamp to see if we need to reset
    //todo: var isOldTimestampBefore7
    //1. get day for both timestamps
    var diff = timestamp.difference(oldTimestamp);
    print("diff is $diff");
    if (timestamp.hour > 7) {
      print("it's after 7 am");
      if (oldTimestamp.day != timestamp.day) {
        print(
            "the oldtimestamp day wasn't today and it's after 7 am (which means the previous time was yday and we need to reset");
        return reset = Future.value(true);
      } else if (oldTimestamp.day == timestamp.day) {
        //old timestamp day is the same day as today
        if (oldTimestamp.hour < 7 && oldTimestamp.hour > 0) {
          //old timestamp was in the wee hours of the morning
          return reset = Future.value(true);
        }
      }
    }
  }

  // await prefs.setString('currTime', timestamp);
  return reset = Future.value(false);
}
