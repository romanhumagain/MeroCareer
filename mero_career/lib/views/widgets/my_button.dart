import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Color color = Colors.blue;
  final double width;
  final double height;
  final String text;

  final Function onTap;

  MyButton(
      {super.key,
      required this.color,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 10,
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  letterSpacing: 1.2),
            )),
          ),
        ),
      ),
    );
  }
}
