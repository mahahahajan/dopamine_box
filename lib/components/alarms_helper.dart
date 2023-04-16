// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dopamine_box/components/task_list_state.dart';
import 'package:dopamine_box/main.dart';

void setupMorningAlarm() async {
  const int dopamineBoxAlarm = 0;
  final now = DateTime.now();
  final alarmTime = DateTime(now.year, now.month, now.day, 7, 0, 0);
  await AndroidAlarmManager.periodic(
      const Duration(hours: 24), dopamineBoxAlarm, resetAlarmHit,
      allowWhileIdle: true, exact: true, wakeup: true, startAt: alarmTime);
}

void setupDebugAlarms() async {
  const int debugAlarm = 1;
  final now = DateTime.now();
  // we cant actually do 5 seconds (too short) -- we do know that alarms are hitting and we don't need the UI to update as long as the db does
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 5), debugAlarm, resetTaskList,
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
}

@pragma('vm:entry-point')
void resetTaskList() async {
  await dbHelper.init();
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("I hit this");
  print("[$now] Hello, world! isolate=${isolateId} function='$resetTaskList'");

  bool tasksComplete = await dbHelper.areAllTasksComplete();
  if (tasksComplete) {
    print('All tasks are done, updating streaks');
    dbHelper.updateStreaks();
  }

  await dbHelper.resetTasks();
  AppStateManager().updateHomeScreen();
}
