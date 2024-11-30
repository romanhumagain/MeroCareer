import 'package:flutter/material.dart';

class HomeScreenHeading extends StatelessWidget {
  const HomeScreenHeading({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 7.5,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // This Column will take up the available space, pushing the icon to the far right
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning, ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
                Text(
                  "Team F1soft International Pvt.Ltd",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Find the perfect candidates that suites your company !",
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            // Notification Icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: 25,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
