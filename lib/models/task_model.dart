class Task {
  Task({
    this.taskID,
    this.taskName,
    this.taskColor,
    this.taskIsDone,
    this.taskFinalDate,
    this.taskDescription,
    this.taskInitialDate,
  });

  Task.fromMap(Map<String, dynamic> map) {
    taskID = map['taskID'];
    taskName = map['taskName'];
    taskColor = map['taskColor'];
    taskIsDone = map['taskIsDone'];
    taskFinalDate = map['taskFinalDate'];
    taskDescription = map['taskDescription'];
    taskInitialDate = map['taskInitialDate'];
  }

  String taskID;
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
      'taskIsDone': taskIsDone,
      'taskFinalDate': taskFinalDate,
      'taskDescription': taskDescription,
      'taskInitialDate': taskInitialDate,
    };
  }
}
