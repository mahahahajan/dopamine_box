import 'package:checkmark/checkmark.dart';
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
  late bool shouldShowDissapearAnimation;

  @override
  void initState() {
    super.initState();
    taskTitle = widget.task.taskName;
    player = widget.player;
    checked = widget.task.isComplete == 0 ? false : true;
    taskId = widget.task.taskId;
    shouldShowDissapearAnimation = checked ? false : true;
    //if this task is already checked, set this to false
    checkboxIcon = checked ? Icons.done : Icons.circle_outlined;
  }

  void playSound() async {
    try {
      await player.setAsset(doneSoundPath);
    } on Exception catch (_, e) {
      print(e);
      return;
    }
    player.play();
  }

  //TODO: save color
  void toggleEssentialTask(int id) {
    if (!checked) {
      //TODO: Set to true
      setState(() {
        this.shouldShowDissapearAnimation = true;
        this.checked = true;
        this.checkboxIcon = Icons.done;
        this.containerBackgroundColor = otherGreen;
        this.checkBoxSize = 34;
        playSound();
        dbHelper.update(id, 1);
        // this.iconColor = green;
      });

      // containerBackgroundColor =
    } else {
      //TODO: Set to false;
      setState(() {
        this.shouldShowDissapearAnimation = false;
        this.checked = false;
        this.checkboxIcon = Icons.circle_outlined;
        this.containerBackgroundColor = essentialTaskBackgroundColor;
        this.checkBoxSize = 18;
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
                  child: FadeOutParticle(
                      disappear: shouldShowDissapearAnimation,
                      duration: const Duration(milliseconds: 8000),
                      curve: Curves.easeOutBack,
                      child: Text(
                        taskTitle,
                        style: const TextStyle(
                          color: white,
                          fontSize: 18,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
