import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType textInputType;
  final bool hide;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.textInputType,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: hide,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
