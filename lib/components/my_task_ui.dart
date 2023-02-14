import 'package:checkmark/checkmark.dart';
import 'package:dopamine_box/constants.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MyTaskUI extends StatefulWidget {
  final String taskTitle;
  final AudioPlayer player;
  final bool checked;
  const MyTaskUI(
      {Key? key,
      required this.taskTitle,
      required this.player,
      required this.checked})
      : super(key: key);

  @override
  State<MyTaskUI> createState() => _MyTaskUIState();
}

class _MyTaskUIState extends State<MyTaskUI> {
  IconData checkboxIcon = Icons.circle_outlined;
  Color iconColor = white;
  Color containerBackgroundColor = essentialTaskBackgroundColor;
  bool checked = false;
  double? checkBoxSize = 18;

  void playSound() async {
    try {
      await widget.player.setAsset(doneSoundPath);
    } on Exception catch (_, e) {
      print(e);
      return;
    }
    widget.player.play();
  }

  void toggleEssentialTask() {
    if (!checked) {
      //TODO: Set to true
      setState(() {
        this.checked = true;
        this.checkboxIcon = Icons.done;
        this.containerBackgroundColor = otherGreen;
        this.checkBoxSize = 34;
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
        this.checkBoxSize = 18;
        // this.iconColor = white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onLongPress: () {
          toggleEssentialTask();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.fromLTRB(15, 0, 1, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
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
                    disappear: checked,
                    duration: const Duration(milliseconds: 8000),
                    curve: Curves.easeOutBack,
                    child: Text(
                      widget.taskTitle,
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
      ),
    );
  }
}
