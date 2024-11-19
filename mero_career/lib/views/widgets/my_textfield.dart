import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final double verticalContentPadding;
  final TextEditingController controller;

  const MyTextfield(
      {super.key,
      required this.labelText,
      required this.prefixIcon,
      required this.verticalContentPadding,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalContentPadding, horizontal: 8.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
          labelText: labelText,
          labelStyle: TextStyle(
              letterSpacing: 0.5,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey),
          prefixIcon: Icon(
            prefixIcon,
            size: 21,
            color: Colors.grey.shade600,
          )),
    );
  }
}
