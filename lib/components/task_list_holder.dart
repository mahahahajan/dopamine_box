import 'package:dopamine_box/components/essential_task.dart';
import 'package:dopamine_box/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TaskListHolder extends StatefulWidget {
  TaskListHolder({Key? key}) : super(key: key);

  @override
  State<TaskListHolder> createState() => _TaskListHolderState();
}

class _TaskListHolderState extends State<TaskListHolder> {
  late AudioPlayer player;

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

  List<String> getTaskList() {
    //TODO: Get task list from firebase
    return <String>[
      ">= 30 minutes excercise ",
      "Do something for your body (bath/shower, skincare)",
      "Do something for your mind (read, puzzles)",
      "Do something for your creativity (draw, write, read)",
      "Do something for your home (clean, repair, expand)",
      "Do something for your future (meal prep, sleep early)",
    ];
  }

  List<Widget> getTaskWidgets() {
    List<String> myTaskList = getTaskList();
    List<Widget> essentialTaskList = [];
    for (int i = 0; i < myTaskList.length; i++) {
      Task currTask = new Task(myTaskList[i].toString(), "", "", i, false);
      // EssentialTask currEssentialTask = currTask.taskTitle;
      essentialTaskList
          .add(EssentialTask(player: player, taskTitle: currTask.taskTitle));
    }
    return essentialTaskList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: getTaskWidgets(),
    );
  }
}

class Task {
  String taskTitle;
  String taskSubTitle;
  String taskColor;
  int taskNumber;
  bool checked;

  Task(this.taskTitle, this.taskSubTitle, this.taskColor, this.taskNumber,
      this.checked);
}
