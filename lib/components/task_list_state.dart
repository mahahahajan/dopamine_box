import 'dart:isolate';

import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/main.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AppStateManager extends ChangeNotifier {
  bool completedAllTasks = false;
  final AudioPlayer _player = AudioPlayer();

  void playSound(String sound) async {
    try {
      await _player.setAsset(sound);
      await _player.play();
    } on Exception catch (_, e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
  }

  void updateHomeScreen() {
    completedAllTasks = false;
    notifyListeners();
  }

  void checkForAllTasksComplete() async {
    completedAllTasks = await dbHelper.areAllTasksComplete();
    if (completedAllTasks) {
      // playSound(levelComplete);
      notifyListeners();
    }
  }
}
