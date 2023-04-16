import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dopamine_box/components/task_list_holder.dart';
import 'package:dopamine_box/components/task_list_state.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/main.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTasksCompleteScreen extends StatefulWidget {
  const AllTasksCompleteScreen({Key? key}) : super(key: key);

  @override
  State<AllTasksCompleteScreen> createState() => _AllTasksCompleteScreen();
}

class _AllTasksCompleteScreen extends State<AllTasksCompleteScreen> {
  late ConfettiController _confettiController;
  late double? randomWidth;
  late int currentStreak;
  Size minSize = Size(5, 4.5);
  Size maxSize = Size(5.0, 6.0);

  @override
  void initState() {
    super.initState();
    randomWidth = Random().nextDouble() * 100;
    currentStreak = getCurrentStreak() as int;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    Provider.of<AppStateManager>(context, listen: false)
        .playSound(levelComplete);
  }

  int getCurrentStreak() {
    var tempStreak = dbHelper.getCurrentTotalStreak().then((value) {
      return value;
    });
    return 0;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    var deviceData = MediaQuery.of(context);
    var fullHeight = deviceData.size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    var fullWidth = deviceData.size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFF),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                // padding: const EdgeInsets.fromLTRB(10, 5, 1, 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: mTaskCompleteScreen,
                ),
                // color: mTaskCompleteScreen,
                height: fullHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(width: randomWidth),
                        ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality
                              .explosive, // don't specify a direction, blast randomly
                          shouldLoop:
                              false, // start again as soon as the animation is finished
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ],
                          minimumSize: minSize,
                          maximumSize: maxSize,
                          maxBlastForce: 3,
                          minBlastForce: 1,
                          particleDrag: .01,
                          gravity:
                              .1, // manually specify the colors to be used // define a custom shape/path.
                        ),
                      ],
                    ),
                    // Container(
                    //   height: 120,
                    // ),
                    Text(
                      "Good job today!",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: white,
                        fontSize: 35,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    // Container(
                    //   height: 100,
                    // ),
                    // Text(
                    //   "You've completed all X tasks for",
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: white,
                    //     fontSize: 20,
                    //     fontFamily: 'Urbanist',
                    //   ),
                    // ),
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality
                          .explosive, // don't specify a direction, blast randomly
                      shouldLoop:
                          false, // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ],
                      minimumSize: minSize,
                      maximumSize: maxSize,
                      maxBlastForce: 4,
                      minBlastForce: 1,
                      particleDrag: .01,
                      gravity:
                          .1, // manually specify the colors to be used // define a custom shape/path.
                    ),
                    // Text(
                    //   currentStreak.toString(),
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: otherGreen,
                    //     fontSize: 150,
                    //     fontFamily: 'Urbanist',
                    //   ),
                    // ),
                    // Text(
                    //   "days in a row",
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: white,
                    //     fontSize: 20,
                    //     fontFamily: 'Urbanist',
                    //   ),
                    // ),
                    // Container(
                    //   height: 100,
                    // ),
                    Row(
                      children: [
                        Container(
                          width: fullWidth - randomWidth!,
                        ),
                        ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality
                              .explosive, // don't specify a direction, blast randomly
                          shouldLoop:
                              false, // start again as soon as the animation is finished
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ],
                          minimumSize: minSize,
                          maximumSize: maxSize,
                          maxBlastForce: 5,
                          minBlastForce: 1,
                          particleDrag: .01,
                          gravity:
                              .1, // manually specify the colors to be used // define a custom shape/path.
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: bottomBarWidget(),
      ),
    );
  }
}

class BottomBarWidvet extends StatelessWidget {
  const BottomBarWidvet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      // margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
      // dotIndicatorColor: Colors.black,
      marginR: const EdgeInsets.fromLTRB(2, 5, 2, 5),
      paddingR: const EdgeInsets.fromLTRB(1, 15, 1, 15),
      dotIndicatorColor: Colors.transparent,
      boxShadow: const [
        BoxShadow(
            color: Colors.transparent,
            spreadRadius: 10,
            blurRadius: 0,
            offset: Offset(0, 0))
      ],
      items: [
        /// Home
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
          // selectedColor: Colors.purple,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          // selectedColor: Colors.pink,
        ),

        /// Search
        DotNavigationBarItem(
          icon: const Icon(Icons.search),
          // selectedColor: Colors.orange,
        ),
      ],
    );
  }
}
