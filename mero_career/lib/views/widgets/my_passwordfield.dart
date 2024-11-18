import 'package:flutter/material.dart';

class MyPasswordfield extends StatelessWidget {
  const MyPasswordfield({super.key});

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
          labelText: 'Password',
          labelStyle: TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.w500),
          prefixIcon: Icon(Icons.lock, size: 25,),
      suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 20,)
      ),
    );
  }
}
