import 'package:flutter/material.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/database/db.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/static/static.dart';
import 'package:todo/utils/functions.dart';
import 'package:todo/utils/routes.dart';
import 'package:todo/widgets/bottom_buttons.dart';
import 'package:todo/widgets/card_task_background.dart';
import 'package:todo/widgets/custom_dropdwon.dart';
import 'package:todo/widgets/custom_snackBar.dart';
import 'package:todo/widgets/empty_page.dart';
import 'package:todo/widgets/task_card.dart';

class TodoList extends StatelessWidget {
  final TodoBloc todoBloc = TodoBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> onTaskDelete(int taskID, Function onDeleteCallback) async {
    await TaskDB.db.deleteTask(taskID);
    onDeleteCallback();
  }

  Future<void> updateStatusTask(Task task, {bool unDone = false}) async {
    Map<String, dynamic> tempTask = task.toMap();
    tempTask['taskFinalDate'] = DateTime.now().toIso8601String();
    tempTask['taskIsDone'] = unDone ? 0 : 1;
    await TaskDB.db.updateTask(Task.fromMap(tempTask));
    todoBloc.loadTodoTasks();
  }

  Future<bool> confirmDelete(BuildContext context, Task task) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text('Deseja realmente excluir a tarefa ${task.taskName} ?'),
          actions: [
            BottomButtons(
              onCancel: () => Navigator.of(context).maybePop(false),
              onCancelLabel: 'NÃO',
              onSave: () => Navigator.of(context).maybePop(true),
              onSaveLabel: 'SIM',
            ),
          ],
        );
      },
    );
  }

  Future<void> navigateTo(BuildContext context, String routerName, {dynamic arguments}) async {
    await Navigator.pushNamed(context, routerName, arguments: arguments).then((value) => todoBloc.loadTodoTasks());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Lista de Tarefas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: RefreshIndicator(
            onRefresh: () async => todoBloc.loadTodoTasks(),
            child: StreamBuilder<TaskOrderType>(
                stream: todoBloc.currentOrderTypeController,
                builder: (BuildContext context, AsyncSnapshot<TaskOrderType> currentOrderTypeSnapshot) {
                  return StreamBuilder<List<Task>>(
                    stream: todoBloc.todoTasks,
                    initialData: [],
                    builder: (context, snapshot) {
                      List<Task> taskList = snapshot.data;

                      if (taskList.isEmpty) {
                        return EmptyPage();
                      }

                      switch (todoBloc.getCurrentOrderType) {
                        case TaskOrderType.done:
                          taskList.sort(CommomFunctions.taskDoneFirst);
                          break;
                        case TaskOrderType.younger:
                          taskList.sort(CommomFunctions.taskYoungerFirst);
                          break;
                        case TaskOrderType.older:
                          taskList.sort(CommomFunctions.taskOlderFirst);
                          break;
                        default:
                          taskList.sort(CommomFunctions.taskTodoFirst);
                      }

                      return Column(
                        children: [
                          CustomDropdown(
                            initialValue: currentOrderTypeSnapshot.data,
                            listItems: [
                              TaskOrderType.todo,
                              TaskOrderType.done,
                              TaskOrderType.younger,
                              TaskOrderType.older,
                            ],
                            onChange: (orderType) => todoBloc.changeCurrentOrderType(orderType),
                          ),
                          Expanded(
                            child: ListView.builder(
                              key: UniqueKey(),
                              itemCount: taskList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                      context,
                                      TodoRouter.TODO_ENTRY,
                                      arguments: {'editMode': true, 'taskToEdit': taskList[index]},
                                    );
                                  },
                                  child: Dismissible(
                                    key: ValueKey(taskList[index].taskID),
                                    confirmDismiss: (_) async {
                                      return await confirmDelete(context, taskList[index]).then((value) {
                                        if (value) CustonSnackBar(key: _scaffoldKey, text: 'Tarefa excluída com sucesso!').snackBar(context);
                                        return value;
                                      });
                                    },
                                    onDismissed: (DismissDirection direction) async {
                                      await onTaskDelete(taskList[index].taskID, () {
                                        taskList.removeAt(index);
                                        todoBloc.loadTodoTasks();
                                      });
                                    },
                                    direction: DismissDirection.endToStart,
                                    background: CardTaskBackground(isDelete: false, unDone: taskList[index].taskIsDone),
                                    secondaryBackground: CardTaskBackground(),
                                    child: TaskCard(
                                      updateStatusTask: () => updateStatusTask(taskList[index], unDone: taskList[index].taskIsDone),
                                      statusTask: taskList[index].taskIsDone,
                                      taskName: taskList[index].taskName,
                                      taskDescription: taskList[index].taskDescription ?? '',
                                      taskInitialDate: taskList[index].taskInitialDate,
                                      taskColor: taskList[index].taskIsDone ? Colors.grey : CommomFunctions.getColor(context, taskList[index].taskColor),
                                      isTaskDone: taskList[index].taskIsDone,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(context, TodoRouter.TODO_ENTRY);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
