import 'package:flutter/material.dart';

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomNumberField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          label: Text(
            '$labelText*',
            style: TextStyle(fontSize: 15),
          )),
      keyboardType: TextInputType.number,
    );
  }
}
