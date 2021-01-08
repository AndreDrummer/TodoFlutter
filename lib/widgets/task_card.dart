import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    @required this.isTaskDone,
    @required this.taskColor,
    @required this.taskName,
    @required this.taskDescription,
    @required this.taskInitialDate,
    @required this.updateStatusTask,
    @required this.statusTask,
  });

  final bool isTaskDone;
  final Color taskColor;
  final String taskName;
  final String taskDescription;
  final String taskInitialDate;
  final Function updateStatusTask;
  final bool statusTask;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: statusTask, onChanged: (_) => updateStatusTask()),
        Expanded(
          child: Card(
            shadowColor: taskColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            color: taskColor,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(taskName, bold: true),
                  text(
                    DateFormat('dd/MM/y').format(
                      DateTime.parse(taskInitialDate),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: text(taskDescription),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text text(String text, {bool bold = false}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: bold ? FontWeight.bold : FontWeight.w400,
      ),
    );
  }
}
