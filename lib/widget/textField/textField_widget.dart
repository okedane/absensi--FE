import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  final String hintText;
  const textField({required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
