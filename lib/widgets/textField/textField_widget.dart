import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String hinText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextfieldWidget({
    required this.hinText,
    required this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hinText,
      ),
    );
  }
}
