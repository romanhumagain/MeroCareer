import 'package:flutter/material.dart';

class ReviewResume extends StatelessWidget {
  const ReviewResume({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: size.width / 2.4,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Colors.blue.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Review Resume",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.5),
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.download_for_offline,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
