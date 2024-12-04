import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          label: Text(
            '$labelText*',
            style: TextStyle(
                fontSize: 15,
                color:
                    isDarkMode ? Colors.grey.shade600 : Colors.grey.shade600),
            // softWrap: true,
            // overflow: TextOverflow.visible,
          )),
    );
  }
}
