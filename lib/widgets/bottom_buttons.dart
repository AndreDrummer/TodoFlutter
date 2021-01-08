import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  BottomButtons({
    this.onSave,
    this.onCancel,
    this.onSaveLabel,
    this.onCancelLabel,
  });

  final Function onSave;
  final Function onCancel;
  final String onSaveLabel;
  final String onCancelLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: onCancel,
          child: Text(onCancelLabel),
        ),
        FlatButton(
          onPressed: onSave,
          child: Text(onSaveLabel),
        ),
      ],
    );
  }
}
