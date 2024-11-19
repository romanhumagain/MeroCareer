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
    return TextField(
      controller: widget.controller,
      obscureText: _showPassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.verticalContentPadding, horizontal: 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.grey),
          prefixIcon: Icon(
            CupertinoIcons.padlock_solid,
            size: 25,
            color: Colors.grey.shade600,
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
            ),
          )),
    );
  }
}
