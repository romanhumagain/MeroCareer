import 'package:flutter/material.dart';
import 'package:mero_career/views/shared/login/login_page.dart';

import '../../widgets/on_boarding_dot_navigation.dart';
import '../../widgets/on_boarding_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              OnBoardingPage(
                heading: "Find Jobs That Fit You",
                subHeading:
                    "Easily search and filter job listings to match your skills, preferences, and desired work environment. Your dream job is just a few taps away.",
                imageUrl: 'assets/images/job_details/jobs_illustration.png',
              ),

              OnBoardingPage(
                heading: "Personalize Your Journey",
                subHeading:
                    "Customize your profile and manage applications with ease to make your job search journey truly yours, every step of the way.",
                imageUrl: 'assets/images/on_boarding8.jpg',
              ),

              OnBoardingPage(
                heading: "Apply Instantly",
                subHeading:
                    "Create a profile, upload your resume, and apply to jobs with just one click, saving you time and effort in your job search.",
                imageUrl: 'assets/images/on_boarding9.jpg',
              ),

              // OnBoardingPage(),
            ],
          ),
          Positioned(
              right: 35,
              top: 55,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
                ),
              )),
          OnBoardingDotNavigation(
            pageController: _pageController,
          ),
          Positioned(
              bottom: 30,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                        duration: Duration(microseconds: 500),
                        curve: Curves.ease);
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: Icon(Icons.keyboard_arrow_right),
              ))
        ],
      ),
    );
  }
}
