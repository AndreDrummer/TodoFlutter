import "dart:io";
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task_model.dart';

class TaskDB {
  TaskDB._();
  static final TaskDB db = TaskDB._();
  final String tableName = 'tasks';

  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, '$tableName.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (        
        taskID integer primary key autoincrement,
        taskName text not null,
        taskDescription text,
        taskIsDone integer not null,
        taskColor text not null,
        taskFinalDate text,
        taskInitialDate text not null
        )
      ''');
      },
    );

    return db;
  }

  Future<Task> createTask(Task task) async {
    Database db = await database;
    Map<String, dynamic> taskMap = task.toMap();
    task.taskIsDone ? taskMap['taskIsDone'] = 1 : taskMap['taskIsDone'] = 0;
    task.taskID = await db.insert(tableName, taskMap);
    return task;
  }

  Future<Task> readTask(int taskID) async {
    Database db = await database;
    List<Map<String, dynamic>> task = await db.query(
      tableName,
      where: 'taskID = ?',
      whereArgs: [taskID.toString()],
    );
    return Task.fromMap(task.first);
  }

  Future<int> updateTask(Task task) async {
    Database db = await database;
    Map<String, dynamic> taskMap = task.toMap();
    task.taskIsDone ? taskMap['taskIsDone'] = 1 : taskMap['taskIsDone'] = 0;
    return await db.update(
      tableName,
      taskMap,
      where: 'taskID = ?',
      whereArgs: [task.taskID],
    );
  }

  Future<int> deleteTask(int taskID) async {
    Database db = await database;
    return await db.delete(
      tableName,
      where: 'taskID = ?',
      whereArgs: [taskID.toString()],
    );
  }

  Future<List<Task>> allTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> docs = await db.query(tableName);
    List<Task> taskList = docs.map((e) => Task.fromMap(e)).toList() ?? [];
    return taskList;
  }
}
