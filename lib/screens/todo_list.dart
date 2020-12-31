import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (_) async {
                return false;
              },
              onDismissed: (_) {},
              direction: DismissDirection.horizontal,
              background: Container(color: Colors.amber),
              secondaryBackground: Container(color: Colors.red),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (_) {},
                    value: false,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 6,
                      color: Colors.yellow,
                      child: ListTile(
                        title: Text('Limpar a casa'),
                        subtitle: Text('Limpar até ficar tudo bem limpinho'),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
