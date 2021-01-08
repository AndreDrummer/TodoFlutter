import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  CustomInputText({
    this.icon,
    this.maxLines,
    this.hintText,
    this.onChanged,
    this.controller,
    this.validate = true,
  });

  final int maxLines;
  final bool validate;
  final IconData icon;
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        maxLines: maxLines,
        validator: (String value) {
          if (!validate) return null;
          if (value == null || value.isEmpty) return 'Preencha este campo';
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(icon),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
