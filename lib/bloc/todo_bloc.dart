import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:todo/bloc/bloc.dart';
import 'package:todo/database/db.dart';
import 'package:todo/models/task_model.dart';

class TodoBloc extends Bloc with ChangeNotifier {
  TodoBloc() {
    loadTodoTasks();
  }

  final _todoTasks = StreamController<List<Task>>();
  final _todoIndexStack = StreamController<int>.broadcast();
  final _todoTaskIsBeingEdited = StreamController<bool>.broadcast();

  Stream<List<Task>> get todo => _todoTasks.stream;
  Stream<int> get todoIndexStack => _todoIndexStack.stream;
  Stream<bool> get todoTaskIsBeingEdited => _todoTaskIsBeingEdited.stream;

  void Function(List<Task>) get changeTodoTasks => _todoTasks.sink.add;
  void Function(int) get changeTodoIndexStack => _todoIndexStack.sink.add;
  void Function(bool) get changeTaskIsBeingEdited => _todoTaskIsBeingEdited.sink.add;

  Future<void> loadTodoTasks() async {
    _todoTasks.sink.add(await TaskDB.db.allTasks());
  }

  @override
  void dispose() {
    _todoTasks.close();
    _todoIndexStack.close();
    _todoTaskIsBeingEdited.close();
    super.dispose();
  }
}
