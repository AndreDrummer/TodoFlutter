import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('''
                Clique no botão +

      abaixo para adicionar uma nota.
      '''),
    );
  }
}
