import 'package:flutter/material.dart';
import 'package:mero_career/views/shared/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/on_boarding_dot_navigation.dart';
import '../widgets/on_boarding_page.dart';

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
                imageUrl: 'assets/images/on_boarding3.jpg',
              ),

              OnBoardingPage(
                heading: "Personalize Your Journey",
                subHeading:
                "Customize your profile and manage applications with ease to make your job search journey truly yours, every step of the way.",
                imageUrl: 'assets/images/on_boarding2.jpg',
              ),

              OnBoardingPage(
                heading: "Apply Instantly",
                subHeading:
                "Create a profile, upload your resume, and apply to jobs with just one click, saving you time and effort in your job search.",
                imageUrl: 'assets/images/on_boarding4.jpg',
              ),

              OnBoardingPage(
                heading: "Track Your Applications",
                subHeading: "Stay on top of your job applications and get updates on the status of each one.",
                imageUrl: 'assets/images/on_boarding6.jpg',
              ),
              // OnBoardingPage(),
            ],

          ),
          Positioned(
              right: 25,
              top: 45,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ))),
          OnBoardingDotNavigation(
            pageController: _pageController,
          ),
          Positioned(
              bottom: 30,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  if(_currentPage < 4){
                    _pageController.nextPage(duration: Duration(microseconds: 500), curve: Curves.ease);
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  }
                },
                child: Icon(Icons.keyboard_arrow_right),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
              ))
        ],
      ),
    );
  }
}
