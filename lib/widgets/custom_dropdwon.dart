import 'package:flutter/material.dart';
import 'package:todo/static/static.dart';

class CustomDropdown extends StatelessWidget {
  String _getOrderTypeName(TaskOrderType taskOrderType) {
    switch (taskOrderType) {
      case TaskOrderType.done:
        return 'Concluído primeiro';
      case TaskOrderType.younger:
        return 'Mais recente primeiro';
      case TaskOrderType.older:
        return 'Mais antigo primeiro';
      default:
        return 'A fazer primeiro';
    }
  }

  CustomDropdown({
    this.listItems,
    this.initialValue,
    this.onChange,
  });
  final List<dynamic> listItems;
  final dynamic initialValue;
  final Function(dynamic) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
        isExpanded: true,
        items: listItems
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.runtimeType == TaskOrderType ? _getOrderTypeName(e) : e),
              ),
            )
            .toList(),
        onChanged: (e) {
          onChange(e);
        },
        value: initialValue,
      ),
    );
  }
}
