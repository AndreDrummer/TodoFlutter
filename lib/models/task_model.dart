class Task {
  Task({
    this.taskID,
    this.taskName,
    this.taskIsDone = false,
    this.taskFinalDate,
    this.taskDescription,
    this.taskInitialDate,
    this.taskColor = 'blue',
  });

  Task.fromMap(Map<String, dynamic> map)
      : taskID = map['taskID'],
        taskName = map['taskName'],
        taskIsDone = map['taskIsDone'] == 1,
        taskColor = map['taskColor'],
        taskFinalDate = map['taskFinalDate'],
        taskDescription = map['taskDescription'],
        taskInitialDate = map['taskInitialDate'];

  int taskID;
  String taskName;
  bool taskIsDone;
  String taskColor;
  String taskFinalDate;
  String taskDescription;
  String taskInitialDate;

  Map<String, dynamic> toMap() {
    return {
      'taskID': taskID,
      'taskName': taskName,
      'taskColor': taskColor,
      'taskIsDone': taskIsDone ? 1 : 0,
      'taskFinalDate': taskFinalDate,
      'taskDescription': taskDescription,
      'taskInitialDate': taskInitialDate,
    };
  }
}
