import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dopamine_box/components/task_list_holder.dart';
import 'package:dopamine_box/main.dart';

late State<TaskListHolder> taskListHolderState;

void setupMorningAlarm() async {
  const int dopamineBoxAlarm = 0;
  final now = DateTime.now();
  final alarmTime = DateTime(now.year, now.month, now.day, 7, 0, 0);
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 30), dopamineBoxAlarm, resetAlarmHit,
      allowWhileIdle: true, exact: true, wakeup: true, startAt: alarmTime);
}

void setupDebugAlarms() async {
  const int debugAlarm = 1;
  final now = DateTime.now();
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 30), debugAlarm, resetAlarmHit,
      allowWhileIdle: true, exact: true, wakeup: true, startAt: now);
}

// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
Future<void> resetAlarmHit() async {
  await dbHelper.init(); // not sure why I have to do this again smh
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$resetAlarmHit'");

  await dbHelper.resetTasks();
  taskListHolderState.initState();
}
