import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  final PageController pageController;

  const OnBoardingDotNavigation({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 45,
        left: 40,
        child: SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect:
              ExpandingDotsEffect(activeDotColor: Colors.blue, dotHeight: 6),
        ));
  }
}
