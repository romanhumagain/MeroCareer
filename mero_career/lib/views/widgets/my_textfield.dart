import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
          labelText: "E-mail",
          labelStyle: TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.w500),
          prefixIcon: Icon(Icons.email_rounded, size: 22,)),
    );
  }
}
