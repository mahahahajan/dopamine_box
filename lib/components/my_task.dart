
class MyTask {
  String taskName;
  int isComplete;
  int streakCounter;
  int taskId;

  MyTask({
    required this.taskName,
    required this.isComplete,
    required this.streakCounter,
    required this.taskId,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'isComplete': isComplete,
      'streakCounter': streakCounter,
      'id': taskId,
    };
  }
}
