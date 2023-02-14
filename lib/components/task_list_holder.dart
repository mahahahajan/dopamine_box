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
  late List<MyTask> taskList;

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

  final GlobalKey<AnimatedListState> key = GlobalKey();

  Future<List<MyTask>> getCurrentTaskList() async {
    List<MyTask> tempTaskList = <MyTask>[];
    print("Query all rows:");
    var currDatabase = await dbHelper.queryAllRows();
    for (final row in currDatabase) {
      print(row.toString());
      MyTask currTask = MyTask(
          taskName: row['taskName'],
          isComplete: row['isComplete'],
          streakCounter: row['streakCounter']);
      tempTaskList.add(currTask);
    }
    return tempTaskList;
  }

  // Future<DataSnapshot> getTaskList() async {
  //   //TODO: Get task list from firebase
  //   final ref = FirebaseDatabase.instance.ref().child('taskList');
  //   final snapshot = ref.get();
  //   return snapshot;
  // }

  // List<Widget> getTaskWidgets() {
  //   Future<List<String>> myTaskList = Future.value(getTaskList());
  //   List<Widget> essentialTaskList = [];
  //   // for (int i = 0; i < myTaskList.length; i++) {
  //   //   Task currTask = new Task(myTaskList[i].toString(), "", "", i, false);
  //   //   // EssentialTask currEssentialTask = currTask.taskTitle;
  //   //   essentialTaskList
  //   //       .add(EssentialTask(player: player, taskTitle: currTask.taskTitle));
  //   // }
  //   return essentialTaskList;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     color: blue,
  //     child: FirebaseAnimatedList(
  //       query: FirebaseDatabase.instance.ref('taskList'),
  //       itemBuilder: (context, snapshot, animation, index) {
  //         return EssentialTask(
  //           player: player,
  //           taskTitle: (snapshot.child("taskName").value.toString()),
  //         );
  //       },
  //       shrinkWrap: true,
  //     ),
  //   );
  // }
  List tasks = [];

  List<Widget> getTaskWidgets() {
    List<Widget> currTaskWidgets = [];
    for (final currTask in taskList) {
      bool taskCompleted = currTask.isComplete == 1 ? true : false;
      currTaskWidgets.add(MyTaskUI(
          taskTitle: currTask.taskName,
          player: player,
          checked: taskCompleted));
    }
    return currTaskWidgets;

    // for (int i = 0; i < defaultTasks.length; i++) {
    //   Task currTask = new Task(defaultTasks[i], "", "", i, false);
    //   // EssentialTask currEssentialTask = currTask.taskTitle;
    //   essentialTaskList.add(MyTaskUI(
    //     player: player,
    //     taskTitle: currTask.taskTitle,
    //     checked: false,
    //   ));
    // }
    // return essentialTaskList;
  }

  Future<List<MyTask>> convertCurrTasksIntoWidgets() async {
    var currDatabase = await dbHelper.queryAllRows();
    List<MyTask> myTasks = <MyTask>[];
    for (final row in currDatabase) {
      print(row.toString());
      MyTask currTask = MyTask(
          taskName: row['taskName'],
          isComplete: row['isComplete'],
          streakCounter: row['streakCounter']);
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
                      taskTitle: myTasks[index].taskName,
                      player: player,
                      checked: taskCompleted),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}






  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     // crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: getTaskWidgets(),
  //   );
  // }

// @override
// Widget build(BuildContext context) {
//   List<String> myTaskList = getTaskList();
//   List<Widget> essentialTaskList = [];
//   for (int i = 0; i < myTaskList.length; i++) {
//     Task currTask = new Task(myTaskList[i].toString(), "", "", i, false);
//     // EssentialTask currEssentialTask = currTask.taskTitle;
//     essentialTaskList
//         .add(EssentialTask(player: player, taskTitle: currTask.taskTitle));
//   }
//   return Expanded(
//     child: AnimatedList(
//       key: key,
//       initialItemCount: 0,
//       itemBuilder: ((context, index, animation) {
//         return SizeTransition(
//             sizeFactor: animation,
//             child:
//                 EssentialTask(player: player, taskTitle: myTaskList[index]));
//       }),
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   var taskListSnapshot = getTaskList();
//   List<Widget> essentialTaskList = [];
//   // taskListSnapshot.whenComplete(() => print())
//   print(taskListSnapshot);
//   return FutureBuilder(
//       future: taskListSnapshot,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         } else {
//           return Text(snapshot.data.toString());
//         }
//       });

//   return Text("temporary");
// for (int i = 0; i < ; i++) {}
// return Expanded(
//   child: AnimatedList(
//     key: key,
//     initialItemCount: 0,
//     itemBuilder: ((context, index, animation) {
//       return SizeTransition(
//           sizeFactor: animation,
//           child: EssentialTask(player: player, taskTitle: tasks[index]));
//     }),
//   ),
// );
//   }