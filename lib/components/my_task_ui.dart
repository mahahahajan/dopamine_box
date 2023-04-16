import 'package:dopamine_box/components/task_list_state.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/main.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_task.dart';

class MyTaskUI extends StatefulWidget {
  final MyTask task;
  const MyTaskUI({Key? key, required this.task}) : super(key: key);

  @override
  State<MyTaskUI> createState() => _MyTaskUIState();
}

class _MyTaskUIState extends State<MyTaskUI> {
  late String taskTitle;
  late bool checked;
  late int taskId;

  late IconData checkboxIcon;
  late Color iconColor;
  Color containerBackgroundColor = Color.fromARGB(0, 0, 0, 0);
  double? checkBoxSize = 18;
  late bool taskWasCompleteAlready;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    taskTitle = widget.task.taskName;
    checked = widget.task.isComplete == 0 ? false : true;
    taskId = widget.task.taskId;
    taskWasCompleteAlready = checked ? true : false;
    checkboxIcon = checked ? Icons.check_circle : Icons.circle_outlined;
    iconColor = checked ? mGreen : white;
  }

  void toggleEssentialTask(int id) {
    if (!checked) {
      setState(() {
        dbHelper.update(id, 1);
        checked = true;
        checkboxIcon = Icons.check_circle;
        // containerBackgroundColor = mGreen;
        this.iconColor = mGreen;
        checkBoxSize = 30;
        Provider.of<AppStateManager>(context, listen: false)
            .playSound(doneSoundPath);
        Provider.of<AppStateManager>(context, listen: false)
            .checkForAllTasksComplete();
      });
      // containerBackgroundColor =
    } else {
      setState(() {
        dbHelper.update(id, 0);
        checked = false;
        checkboxIcon = Icons.circle_outlined;
        containerBackgroundColor = Color.fromARGB(0, 0, 0, 0);
        checkBoxSize = 18;

        this.iconColor = white;
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
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.fromLTRB(15, 0, 1, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          // color: checked ? mGreen : containerBackgroundColor,
          color: containerBackgroundColor,
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
              size: 30,
              color: iconColor,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: (taskWasCompleteAlready & checked)
                    ? Text(
                        taskTitle,
                        style: const TextStyle(
                          color: darkThemeBackgroundColor,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 3.8,
                          decorationColor: mGreen,
                        ),
                      )
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
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
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
