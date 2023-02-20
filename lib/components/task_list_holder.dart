import 'package:dopamine_box/components/my_task_ui.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/main.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'my_task.dart';

class TaskListHolder extends StatefulWidget {
  TaskListHolder({Key? key}) : super(key: key);

  @override
  State<TaskListHolder> createState() => _TaskListHolderState();
}

class _TaskListHolderState extends State<TaskListHolder> {
  late AudioPlayer player;
  // late DataSnapshot snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  // Future<List<MyTask>> getCurrentTaskList() async {
  //   List<MyTask> tempTaskList = <MyTask>[];
  //   print("Query all rows:");
  //   var currDatabase = await dbHelper.queryAllRows();
  //   for (final row in currDatabase) {
  //     print(row.toString());
  //     MyTask currTask = MyTask(
  //         taskName: row['taskName'],
  //         isComplete: row['isComplete'],
  //         streakCounter: row['streakCounter'],
  //         row: row);
  //     tempTaskList.add(currTask);
  //   }
  //   return tempTaskList;
  // }

  Future<List<MyTask>> convertCurrTasksIntoWidgets() async {
    var currDatabase = await dbHelper.queryAllRows();
    List<MyTask> myTasks = <MyTask>[];
    for (final row in currDatabase) {
      print(row.toString());
      MyTask currTask = MyTask(
          taskName: row['taskName'],
          isComplete: row['isComplete'],
          streakCounter: row['streakCounter'],
          taskId: row['id']);
      myTasks.add(currTask);
    }
    return myTasks;
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    var fullHeight = deviceData.size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return FutureBuilder(
      future: convertCurrTasksIntoWidgets(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<MyTask> myTasks = snapshot.data as List<MyTask>;
          // return Text('Found: ${myTasks}');
          return ListView.builder(
              shrinkWrap: true,
              itemCount: myTasks.length,
              itemBuilder: (context, index) {
                var taskCompleted =
                    myTasks[index].isComplete == 0 ? false : true;
                return SizedBox(
                  height: (fullHeight - 50) / myTasks.length,
                  // height: (MediaQuery.of(context).size.height) / myTasks.length,
                  child: MyTaskUI(
                    task: myTasks[index],
                    player: player,
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
