import 'package:flutter/material.dart';

class ColorTask extends StatelessWidget {
  ColorTask({
    this.squareColor,
    this.onColorSelected,
    this.squareBorderColor = Colors.white,
  });

  final Color squareColor;
  final Color squareBorderColor;
  final Function() onColorSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onColorSelected(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: ShapeDecoration(
          shape: Border.all(
                width: 18,
                color: squareColor,
              ) +
              Border.all(
                width: 6,
                color: squareBorderColor,
              ),
        ),
      ),
    );
  }
}
