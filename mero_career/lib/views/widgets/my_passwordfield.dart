import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPasswordfield extends StatefulWidget {
  final String labelText;
  final double verticalContentPadding;
  final TextEditingController controller;

  const MyPasswordfield(
      {super.key,
      required this.labelText,
      required this.verticalContentPadding,
      required this.controller});

  @override
  State<MyPasswordfield> createState() => _MyPasswordfieldState();
}

class _MyPasswordfieldState extends State<MyPasswordfield> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: widget.controller,
      obscureText: _showPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.verticalContentPadding, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.blue,
          ),
        ),
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 14.5,
              letterSpacing: 0.5,
              color: isDarkMode ? Colors.grey.shade200 : Colors.black,
            ),
        prefixIcon: Icon(
          CupertinoIcons.padlock_solid,
          size: 25,
          color: isDarkMode ? Colors.grey.shade200 : Colors.grey.shade700,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.remove_red_eye : Icons.visibility_off,
            size: 20,
            color: isDarkMode
                ? Colors.grey.shade200
                : Colors.grey.shade700, // Suffix icon color based on theme
          ),
        ),
      ),
    );
  }
}
