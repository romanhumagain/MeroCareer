import 'package:flutter/material.dart';

class MyCustomTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const MyCustomTextfield({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white
                : Colors.blue, // Set focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
          ),
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              letterSpacing: 0.5,
              color: isDarkMode ? Colors.grey.shade200 : Colors.black,
            ),
      ),
    );
  }
}
