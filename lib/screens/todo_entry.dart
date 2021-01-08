import 'package:flutter/material.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/database/db.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/static/static.dart';
import 'package:todo/utils/functions.dart';
import 'package:todo/widgets/bottom_buttons.dart';
import 'package:todo/widgets/calendar.dart';
import 'package:todo/widgets/custom_input_text.dart';
import 'package:todo/widgets/loading.dart';
import 'package:todo/widgets/color_task.dart';

class TodoEntry extends StatelessWidget {
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TodoBloc todoBloc = TodoBloc();
    bool editMode = false;
    final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    if (args != null) {
      editMode = args['editMode'];
      todoBloc.changeTaskBeingEdited((args['taskToEdit'] as Task));
      _taskName.text = todoBloc.getTaskBeingEdited?.taskName;
      _taskDescription.text = todoBloc.getTaskBeingEdited?.taskDescription;
    }

    void setTaskData(TaskFields taskField, dynamic taskData) {
      Map<String, dynamic> taskMap = todoBloc.getTaskBeingEdited.toMap();
      taskMap[taskField.toString().split('.').last] = taskData;
      todoBloc.changeTaskBeingEdited(Task.fromMap(taskMap));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: todoBloc.getTaskBeingEdited.taskIsDone ? Colors.grey : CommomFunctions.getColor(context, todoBloc.getTaskBeingEdited.taskColor),
        title: Text(editMode ? 'Editar tarefa' : 'Adicionar uma nova tarefa'),
        leading: BackButton(),
      ),
      bottomNavigationBar: BottomButtons(
        onSaveLabel: 'Save',
        onCancelLabel: 'Cancel',
        onSave: () {
          FocusScope.of(context).unfocus();
          save(context, todoBloc, editMode);
        },
        onCancel: () => Navigator.maybePop(context),
      ),
      body: StreamBuilder<Task>(
        stream: todoBloc.taskBeingEdited,
        builder: (context, snapshot) {
          Task currentTask = snapshot.data;
          return Stack(
            children: [
              Container(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomInputText(
                            controller: _taskName,
                            onChanged: (String value) {
                              setTaskData(TaskFields.taskName, _taskName.text);
                            },
                            hintText: 'Title',
                            icon: Icons.title,
                            maxLines: 1,
                          ),
                          CustomInputText(
                            validate: false,
                            controller: _taskDescription,
                            onChanged: (String value) {
                              setTaskData(TaskFields.taskDescription, _taskDescription.text);
                            },
                            hintText: 'Description',
                            icon: Icons.content_paste,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    Calendar(
                      initialDate: todoBloc.getTaskBeingEdited.taskInitialDate ?? DateTime.now().toIso8601String(),
                      onDateSelected: (date) {
                        setTaskData(TaskFields.taskInitialDate, date.toIso8601String());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Text('Escolha uma cor para decorar sua anotação (Padrão é azul).'),
                    ),
                    ColorTask(
                      onColorSelected: (colorIndex) {
                        setTaskData(TaskFields.taskColor, colorIndex);
                      },
                      taskColor: currentTask?.taskColor,
                    ),
                  ],
                ),
              ),
              StreamBuilder<bool>(
                stream: todoBloc.todoTaskIsOnSave,
                initialData: false,
                builder: (context, snapshot) {
                  return Loading(loadingText: editMode ? 'Salvando anotação...' : 'Inserindo anotação...', canShow: snapshot.data);
                },
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> save(BuildContext context, TodoBloc todoBloc, bool editMode) async {
    if (!_formKey.currentState.validate()) return;

    if (editMode) {
      todoBloc.changeTaskIsOnSave(true);
      await TaskDB.db.updateTask(todoBloc.getTaskBeingEdited);
      todoBloc.changeTaskIsOnSave(false);
    } else {
      todoBloc.changeTaskIsOnSave(true);
      await TaskDB.db.createTask(todoBloc.getTaskBeingEdited);
      todoBloc.changeTaskIsOnSave(false);
    }
    Navigator.maybePop(context);
  }
}
