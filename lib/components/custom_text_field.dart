import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.keyboardType,
    this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final ValueChanged? onChanged;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(labelText),
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
