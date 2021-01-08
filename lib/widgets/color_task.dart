import 'package:flutter/material.dart';
import 'package:todo/static/static.dart';
import 'package:todo/utils/functions.dart';

class ColorTask extends StatelessWidget {
  ColorTask({
    this.squareColor,
    this.onColorSelected,
    this.taskColor,
    this.squareBorderColor = Colors.white,
  });

  final Color squareColor;
  final Color squareBorderColor;
  final String taskColor;
  final Function(dynamic) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: StaticData.colors
            .map(
              (colorIndex) => GestureDetector(
                onTap: () => onColorSelected(colorIndex),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: ShapeDecoration(
                    shape: Border.all(
                          width: 18,
                          color: CommomFunctions.getColor(context, colorIndex),
                        ) +
                        Border.all(
                          width: 6,
                          color: CommomFunctions.getSquareBorderColor(context, colorIndex, taskColor ?? colorIndex),
                        ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
