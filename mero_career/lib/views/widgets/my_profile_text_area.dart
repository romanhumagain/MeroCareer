import 'package:flutter/material.dart';

class MyProfileTextArea extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? hintText;

  const MyProfileTextArea({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      maxLines: 5, // Makes it a text area
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        // Adjust padding for multi-line
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
          ),
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 13,
              letterSpacing: 0.5,
              color: Colors.grey,
            ),
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              letterSpacing: 0.5,
              color: Colors.grey,
            ),
      ),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
          ),
    );
  }
}
