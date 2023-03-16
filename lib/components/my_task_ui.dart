import 'package:cron/cron.dart';
import 'package:dopamine_box/components/task_list_holder.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/main.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'my_task.dart';

class MyTaskUI extends StatefulWidget {
  final MyTask task;
  final AudioPlayer player;
  const MyTaskUI({Key? key, required this.task, required this.player})
      : super(key: key);

  @override
  State<MyTaskUI> createState() => _MyTaskUIState();
}

class _MyTaskUIState extends State<MyTaskUI> {
  late String taskTitle;
  late AudioPlayer player;
  late bool checked;
  late int taskId;

  late IconData checkboxIcon;
  Color iconColor = white;
  Color containerBackgroundColor = essentialTaskBackgroundColor;
  double? checkBoxSize = 18;
  late bool taskWasCompleteAlready;

  @override
  void initState() {
    super.initState();
    initializeData();
    cron.schedule(Schedule.parse('*/1 * * * *'), () {
      dbHelper.resetTasks();
      print("Test  cron");
      setState(() {
        resetData();
      });
    });
  }

  void initializeData() {
    taskTitle = widget.task.taskName;
    player = widget.player;
    checked = widget.task.isComplete == 0 ? false : true;
    taskId = widget.task.taskId;
    taskWasCompleteAlready = checked ? true : false;
    checkboxIcon = checked ? Icons.done : Icons.circle_outlined;
  }

  void resetData() {
    taskTitle = widget.task.taskName;
    player = widget.player;
    checked = false;
    taskId = widget.task.taskId;
    dbHelper.update(taskId, 0);
    taskWasCompleteAlready = false;
    checkboxIcon = Icons.circle_outlined;
    containerBackgroundColor = essentialTaskBackgroundColor;
  }

  void checkForComplete() async {
    bool allTasksComplete = await dbHelper.areAllTasksComplete();
    if (allTasksComplete) {
      print("Check for this");
      playSound(levelComplete);
    }
  }

  void playSound(String sound) async {
    try {
      await player.setAsset(sound);
    } on Exception catch (_, e) {
      print(e);
      return;
    }
    player.play();
  }

  void toggleEssentialTask(int id) {
    if (!checked) {
      setState(() {
        checked = true;
        checkboxIcon = Icons.done;
        containerBackgroundColor = otherGreen;
        checkBoxSize = 34;
        playSound(doneSoundPath);
        dbHelper.update(id, 1);
        // this.iconColor = green;
        //TODO: Check for completion and play a sound
        checkForComplete();
      });

      // containerBackgroundColor =
    } else {
      setState(() {
        checked = false;
        checkboxIcon = Icons.circle_outlined;
        containerBackgroundColor = essentialTaskBackgroundColor;
        checkBoxSize = 18;
        dbHelper.update(id, 0);
        // this.iconColor = white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        toggleEssentialTask(taskId);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: const EdgeInsets.fromLTRB(15, 0, 1, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: checked ? otherGreen : containerBackgroundColor,
        ),
        // color: Colors.black,
        child: Row(
          // color: green,
          children: [
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 1000),
            //   height: checkBoxSize,
            //   width: checkBoxSize,
            //   child: CheckMark(
            //     active: checked,
            //     curve: Curves.linear,
            //     strokeWidth: 3,
            //     duration: const Duration(milliseconds: 1000),
            //     activeColor: white,
            //   ),
            // ),
            Icon(
              checkboxIcon,
              size: 35,
              color: iconColor,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: (taskWasCompleteAlready & checked)
                    ? const Text("")
                    : FadeOutParticle(
                        key: UniqueKey(),
                        disappear: checked,
                        duration: const Duration(milliseconds: 8000),
                        curve: Curves.easeOutBack,
                        child: Text(
                          taskTitle,
                          style: const TextStyle(
                            color: white,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
