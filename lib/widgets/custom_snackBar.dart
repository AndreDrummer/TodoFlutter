import 'package:flutter/material.dart';

class CustonSnackBar {
  CustonSnackBar({
    this.key,
    this.text = '',
  });

  final GlobalKey<ScaffoldState> key;
  final String text;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(BuildContext context) {
    return key.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
