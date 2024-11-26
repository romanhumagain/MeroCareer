import 'package:flutter/material.dart';

class PreferenceBadge extends StatelessWidget {
  final String title;

  const PreferenceBadge({super.key, required this.size, required this.title});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade900),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 17,
          ),
        ],
      ),
    );
  }
}
