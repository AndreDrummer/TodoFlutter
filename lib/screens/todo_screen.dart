import 'package:flutter/material.dart';
import 'package:todo/bloc/bloc_provider.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/screens/todo_entry.dart';
import 'package:todo/screens/todo_list.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoBloc todoBloc = TodoBloc();

    Future<bool> voltar() {
      todoBloc.changeTodoIndexStack(0);
      return Future.value(false);
    }

    return WillPopScope(
      onWillPop: voltar,
      child: Scaffold(
        body: BlocProvider<TodoBloc>(
          bloc: todoBloc,
          child: StreamBuilder(
            stream: todoBloc.todoIndexStack,
            initialData: 0,
            builder: (context, snapshot) {
              return IndexedStack(
                index: snapshot.data ?? 0,
                children: [
                  TodoList(),
                  StreamBuilder<bool>(
                    stream: todoBloc.todoTaskIsBeingEdited,
                    initialData: false,
                    builder: (context, snapshot) {
                      return TodoEntry(
                        editMode: snapshot.data,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: StreamBuilder<int>(
          stream: todoBloc.todoIndexStack,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == 0)
              return FloatingActionButton(
                onPressed: () {
                  todoBloc.changeTodoIndexStack(1);
                },
                child: Icon(Icons.add),
              );
            return Container();
          },
        ),
      ),
    );
  }
}
