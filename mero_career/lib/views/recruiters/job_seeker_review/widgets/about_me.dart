import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "About Me",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 20.5, letterSpacing: 0.4),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 26,
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          SizedBox(
            width: size.width,
            child: Text(
                "I am a Software Engineering Student, currently pursuing my studies at the University of Bedfordshire. I have a strong passion for programming, specifically in Java and Python. I am highly interested in backend development. To enhance my skills, I am presently engaged in projects that utilize the Python Django framework. This hands-on experience has allowed me to delve deeper into backend development and gain a comprehensive understanding of building robust and scalable applications."),
          )
        ],
      ),
    );
  }
}
