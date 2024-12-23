import 'package:flutter/material.dart';

class MyProfileTextfield extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final double verticalContentPadding;
  final TextEditingController controller;
  final String? hintText;

  const MyProfileTextfield(
      {super.key,
      required this.labelText,
      required this.prefixIcon,
      required this.verticalContentPadding,
      required this.controller,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: verticalContentPadding, horizontal: 25.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white
                : Colors.blue, // Set focused border color
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
        prefixIcon: Icon(
          prefixIcon,
          size: 21,
          color: isDarkMode ? Colors.grey.shade200 : Colors.grey.shade700,
        ),
      ),
    );
  }
}
