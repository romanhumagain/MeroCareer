import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Color color = Colors.blue;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final bool? isLoading;

  MyButton({
    super.key,
    required this.color,
    required this.width,
    required this.height,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 5,
        child: GestureDetector(
          onTap: () {
            isLoading! ? () {} : onTap();
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: !isLoading!
                    ? Text(
                        text,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 19.5,
                            letterSpacing: 1.2),
                      )
                    : SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
