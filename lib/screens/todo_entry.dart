import 'package:flutter/material.dart';
import 'package:todo/static/static.dart';
import 'package:todo/widgets/color_task.dart';

class TodoEntry extends StatelessWidget {
  TodoEntry({
    this.editMode = false,
  });

  final bool editMode;

  Color getColor(String colorIndex, BuildContext context) {
    switch (colorIndex) {
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      case 'grey':
        return Colors.grey;
      case 'white':
        return Colors.white;
      case 'orange':
        return Colors.orange;
      default:
        return Theme.of(context).canvasColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Editar tarefa' : 'Adicionar uma nova tarefa'),
        leading: BackButton(),
      ),
      body: Container(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.title),
                title: TextFormField(
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.content_paste),
                title: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Subtitle'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Text('Escolha uma cor para decorar sua anotação.'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: StaticData.colors
                      .map(
                        (colorIndex) => ColorTask(
                          onColorSelected: () {},
                          squareBorderColor: Colors.black,
                          squareColor: getColor(colorIndex, context),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
