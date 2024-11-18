import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Color color = Colors.blue;
  final Size size;
  final String text;
  MyButton(
      {super.key, required this.color, required this.size, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:2.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 10,
        child: Container(
          width: size.width,
          height: 47,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20, letterSpacing: 1.2),)),
        ),
      ),
    );
  }
}
