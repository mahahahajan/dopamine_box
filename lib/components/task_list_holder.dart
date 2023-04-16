import 'package:dopamine_box/components/my_task_ui.dart';
import 'package:dopamine_box/components/task_list_state.dart';
import 'package:dopamine_box/main.dart';
import 'package:dopamine_box/screens/all_tasks_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_task.dart';

class TaskListHolder extends StatefulWidget {
  const TaskListHolder({Key? key}) : super(key: key);

  @override
  State<TaskListHolder> createState() => _TaskListHolderState();
}

class _TaskListHolderState extends State<TaskListHolder> {
  // late DataSnapshot snapshot;
  late bool areAllTasksDone;

  @override
  void initState() {
    super.initState();
    areAllTasksDone = false;
  }

  @override
  void dispose() {
    super.dispose();
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

    return Consumer<AppStateManager>(builder: (context, taskListState, child) {
      if (context.read<AppStateManager>().completedAllTasks) {
        return const AllTasksCompleteScreen();
      } else {
        return FutureBuilder(
          future: convertCurrTasksIntoWidgets(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<MyTask> myTasks = snapshot.data as List<MyTask>;
              // return Text('Found: ${myTasks}');
              return Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: myTasks.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: (fullHeight - 100) / myTasks.length,
                        // height: (MediaQuery.of(context).size.height) / myTasks.length,
                        child: MyTaskUI(
                          task: myTasks[index],
                        ),
                      );
                    }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }
    });
  }
}
