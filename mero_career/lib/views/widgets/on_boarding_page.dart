import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String imageUrl;

  const OnBoardingPage(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imageUrl, height: 300),
          ),
          SizedBox(
            height: 52,
          ),
          Text(
            heading,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 27, fontWeight: FontWeight.w700, letterSpacing: 0.6),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            subHeading,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
