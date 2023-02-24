import 'package:dopamine_box/components/my_task_ui.dart';
import 'package:dopamine_box/main.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'my_task.dart';

class TaskListHolder extends StatefulWidget {
  const TaskListHolder({Key? key}) : super(key: key);

  @override
  State<TaskListHolder> createState() => _TaskListHolderState();
}

class _TaskListHolderState extends State<TaskListHolder> {
  late AudioPlayer player;
  // late DataSnapshot snapshot;
  late bool areAllTasksDone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    areAllTasksDone = false;
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playFinalMusic() {
    print("This will play final music");
  }

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
    if (areAllTasksDone) {
      return Text("Done for today");
    }
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
