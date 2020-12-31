import 'package:flutter/material.dart';
import 'package:todo/screens/todo_screen.dart';

void main() {
  runApp(
    TodoApp(),
  );
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO-DO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Todo(),
    );
  }
}
