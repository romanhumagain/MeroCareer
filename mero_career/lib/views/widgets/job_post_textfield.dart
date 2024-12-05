import 'package:flutter/material.dart';

class JobPostTextfield extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final double verticalContentPadding;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;

  const JobPostTextfield({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.verticalContentPadding,
    required this.controller,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: verticalContentPadding, horizontal: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.grey.shade700
                : Colors.grey, // Change color based on dark mode
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
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 13,
              letterSpacing: 0.5,
              color: Colors.grey,
            ),
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              letterSpacing: 0.5,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
        prefixIcon: Icon(
          prefixIcon,
          size: 21,
          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600,
        ),
      ),
    );
  }
}