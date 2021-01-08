import 'package:flutter/material.dart';

class CardTaskBackground extends StatelessWidget {
  CardTaskBackground({
    this.isDelete = true,
    this.unDone = true,
  });

  final bool isDelete;
  final bool unDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _color(),
      ),
      alignment: isDelete ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.only(right: isDelete ? 10 : 0, left: isDelete ? 0 : 10),
      child: Icon(_icon(), color: Colors.white, size: 30),
    );
  }

  IconData _icon() {
    if(isDelete) return Icons.delete;
    if(unDone) return Icons.refresh;
    return Icons.done;
  }

  Color _color() {
    if(isDelete) return Colors.red;
    if(unDone) return Colors.amber;
    return Colors.green;
  }
}
