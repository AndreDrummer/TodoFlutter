import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:todo/static/static.dart';
import '../database/db.dart';
import 'bloc.dart';
import '../models/task_model.dart';

class TodoBloc extends Bloc with ChangeNotifier {
  TodoBloc() {
    loadTodoTasks();
    _taskBeingEditedController.sink.add(_taskBeingEditedInitial);
    _currentOrderTypeController.sink.add(_currentOrderTypeInitial);
  }

  final _todoTasksController = StreamController<List<Task>>();
  final _taskBeingEditedController = StreamController<Task>();
  final _todoTaskIsOnSaveController = StreamController<bool>();
  final _currentOrderTypeController = StreamController<TaskOrderType>();

  Task _taskBeingEditedInitial = Task(
    taskInitialDate: DateTime.now().toIso8601String(),
  );

  TaskOrderType _currentOrderTypeInitial = TaskOrderType.todo;

  Stream<List<Task>> get todoTasks => _todoTasksController.stream;
  Stream<Task> get taskBeingEdited => _taskBeingEditedController.stream;
  Stream<TaskOrderType> get currentOrderTypeController => _currentOrderTypeController.stream;
  Stream<bool> get todoTaskIsOnSave => _todoTaskIsOnSaveController.stream;

  Task get getTaskBeingEdited => _taskBeingEditedInitial;
  TaskOrderType get getCurrentOrderType => _currentOrderTypeInitial;

  void Function(List<Task>) get changeTodoTasks => _todoTasksController.sink.add;
  void Function(bool) get changeTaskIsOnSave => _todoTaskIsOnSaveController.sink.add;

  void changeTaskBeingEdited(Task task) {
    _taskBeingEditedInitial = task;
    _taskBeingEditedController.sink.add(_taskBeingEditedInitial);
  }

  void changeCurrentOrderType(TaskOrderType orderType) {
    _currentOrderTypeInitial = orderType;
    _currentOrderTypeController.sink.add(_currentOrderTypeInitial);
  }

  Future<void> loadTodoTasks() async {
    _todoTasksController.sink.add(await TaskDB.db.allTasks());
  }

  @override
  void dispose() {
    _todoTasksController.close();
    _taskBeingEditedController.close();
    _todoTaskIsOnSaveController.close();
    _currentOrderTypeController.close();
    super.dispose();
  }
}
