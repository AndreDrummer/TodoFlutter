enum TaskFields {
  taskID,
  taskName,
  taskIsDone,
  taskColor,
  taskFinalDate,
  taskDescription,
  taskInitialDate,
}

enum TaskOrderType {
  todo,
  done,
  younger,
  older,
}

class StaticData {
  static const List colors = [
    'blue',
    'yellow',
    'green',
    'purple',
    'red',
    'pink',
    'orange',
  ];
}
