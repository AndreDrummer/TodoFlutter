import 'package:todo/models/task_model.dart';

class TodoModel {
  TodoModel({
    this.tasks,
    this.indexStack,
  });

  int indexStack;
  List<Task> tasks;
}
