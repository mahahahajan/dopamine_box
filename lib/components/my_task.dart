import '../constants.dart';

class MyTask {
  String taskName;
  int isComplete;
  int streakCounter;

  MyTask({
    required this.taskName,
    required this.isComplete,
    required this.streakCounter,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'isComplete': isComplete,
      'streakCounter': streakCounter,
    };
  }
}
