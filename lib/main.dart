import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/screens/todo_entry.dart';
import 'package:todo/screens/todo_list.dart';
import 'package:todo/utils/routes.dart';

void main() {
  runApp(
    TodoApp(),
  );
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      title: 'TO-DO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        TodoRouter.TODO_LIST: (ctx) => TodoList(),
        TodoRouter.TODO_ENTRY: (ctx) => TodoEntry(),
      },
    );
  }
}
