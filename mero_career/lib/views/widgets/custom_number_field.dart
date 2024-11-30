import 'package:flutter/material.dart';

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomNumberField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
