import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeadingSection extends StatelessWidget {
  const ProfileHeadingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final headingTextStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(
                        'assets/images/pp.jpg',
                      ),
                    ),
                  ),
                  Text(
                    "Roman Humagain",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 18, letterSpacing: 0.4),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mobile App Developer",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 15, letterSpacing: 0.4),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.mode_edit_outline,
              size: 22,
              color: Colors.blue,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "2",
                  style: headingTextStyle?.copyWith(
                      fontSize: 15.5, color: Colors.blue),
                ),
                Text(
                  "Job Applied",
                  style: headingTextStyle,
                )
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              width: 2,
              height: 30,
              color: Theme.of(context).colorScheme.surface,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: [
                Text(
                  "0",
                  style: headingTextStyle?.copyWith(
                      fontSize: 15.5, color: Colors.blue),
                ),
                Text(
                  "Application Under Review",
                  style: headingTextStyle,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.eye_solid,
              size: 19,
              color: Colors.blue,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Preview Profile",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }
}
