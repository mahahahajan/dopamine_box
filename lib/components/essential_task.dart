import 'package:dopamine_box/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class EssentialTask extends StatefulWidget {
  final String taskTitle;
  final AudioPlayer player;
  const EssentialTask({Key? key, required this.taskTitle, required this.player})
      : super(key: key);

  @override
  State<EssentialTask> createState() => _EssentialTaskState();
}

class _EssentialTaskState extends State<EssentialTask> {
  IconData checkboxIcon = Icons.circle_outlined;
  Color iconColor = white;
  Color containerBackgroundColor = essentialTaskBackgroundColor;
  bool checked = false;

  void playSound() async {
    await widget.player.setAsset(doneSoundPath);
    widget.player.play();
  }

  void toggleEssentialTask() {
    if (!checked) {
      //TODO: Set to true
      setState(() {
        this.checked = true;
        this.checkboxIcon = Icons.done;
        this.containerBackgroundColor = otherGreen;
        playSound();
        // this.iconColor = green;
      });

      // containerBackgroundColor =
    } else {
      //TODO: Set to false;
      setState(() {
        this.checked = false;
        this.checkboxIcon = Icons.circle_outlined;
        this.containerBackgroundColor = essentialTaskBackgroundColor;
        // this.iconColor = white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onLongPress: () {
          print("Checked item 2");
          toggleEssentialTask();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.fromLTRB(15, 0, 1, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              const Radius.circular(15),
            ),
            color: containerBackgroundColor,
          ),
          // color: Colors.black,
          child: Row(
            // color: green,
            children: [
              Icon(
                checkboxIcon,
                size: 35,
                color: iconColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                widget.taskTitle,
                style: TextStyle(
                  color: white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
