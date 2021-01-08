import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

class CommomFunctions {
  static Color getColor(BuildContext context, String colorIndex) {
    switch (colorIndex) {
      case 'blue':
        return Colors.blueAccent;
      case 'yellow':
        return Colors.yellowAccent;
      case 'green':
        return Colors.greenAccent;
      case 'purple':
        return Colors.purpleAccent;
      case 'red':
        return Colors.redAccent;
      case 'grey':
        return Colors.grey;
      case 'pink':
        return Colors.pinkAccent;
      case 'orange':
        return Colors.orangeAccent;
      default:
        return Theme.of(context).canvasColor;
    }
  }

  static Color getSquareBorderColor(BuildContext context, String colorIndex, String taskColor) {
    return colorIndex == taskColor ? CommomFunctions.getColor(context, colorIndex) : Theme.of(context).canvasColor;
  }

  static int taskDoneFirst(Task taskA, Task taskB) {
    if (!taskA.taskIsDone && taskB.taskIsDone) return 1;
    if (taskA.taskIsDone && !taskB.taskIsDone) return -1;
    return taskA.taskID - taskB.taskID;
  }

  static int taskTodoFirst(Task taskA, Task taskB) {
    if (taskA.taskIsDone && !taskB.taskIsDone) return 1;
    if (!taskA.taskIsDone && taskB.taskIsDone) return -1;
    return taskA.taskID - taskB.taskID;
  }

  static int taskYoungerFirst(Task taskA, Task taskB) {
    return DateTime.parse(taskB.taskInitialDate).microsecondsSinceEpoch - DateTime.parse(taskA.taskInitialDate).microsecondsSinceEpoch;
  }

  static int taskOlderFirst(Task taskA, Task taskB) {
    return DateTime.parse(taskA.taskInitialDate).microsecondsSinceEpoch - DateTime.parse(taskB.taskInitialDate).microsecondsSinceEpoch;
  }
}
