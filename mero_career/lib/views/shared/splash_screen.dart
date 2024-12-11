import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mero_career/views/job_seekers/common/main_screen.dart';
import 'package:mero_career/views/recruiters/common/recruiter_main_screen.dart';
import 'package:mero_career/views/shared/login/login_page.dart';
import 'package:mero_career/views/shared/onboarding/on_boarding.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices authServices = AuthServices();
  bool isLoggedIn = false;
  String userRole = "";
  bool isUserVerified = false;
  bool isRecruiterApproved = false;

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  // Await the async status check and navigation decision
  Future<void> checkUserLoginStatus() async {
    String? accessToken = await authServices.getAccessToken();
    String? refreshToken = await authServices.getRefreshToken();

    await Future.delayed(Duration(seconds: 3));

    if (accessToken == null || refreshToken == null) {
      navigateToOnboarding();
      return;
    }

    try {
      bool loggedIn = await authServices.isLoggedIn();
      if (!loggedIn) {
        await authServices.refreshAccessToken();
        loggedIn = await authServices.isLoggedIn();
      }

      if (loggedIn) {
        await handleLoggedInUser();
      } else {
        navigateToOnboarding();
      }
    } catch (e) {
      navigateToOnboarding();
    }
  }

  Future<void> handleLoggedInUser() async {
    try {
      String? role = await authServices.getUserRole();
      bool? isVerified = await authServices.getUserVerificationStatus();
      bool? hasRecruiterApproved =
          await authServices.getRecruiterApprovalStatus();

      setState(() {
        isLoggedIn = true;
        userRole = role!;
        isUserVerified = isVerified ?? false;
        if (role == "recruiter") {
          isRecruiterApproved = hasRecruiterApproved ?? false;
        }
      });

      Timer(Duration(seconds: 1), navigateUser);
    } catch (e) {
      showCustomFlushbar(
          context: context,
          message: "Error fetching user data",
          type: MessageType.error);
      navigateToOnboarding();
    }
  }

  void navigateToOnboarding() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoarding()));
  }

  void navigateUser() {
    if (isLoggedIn) {
      if (userRole == "job_seeker") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      } else if (userRole == "recruiter") {
        if (isRecruiterApproved) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RecruiterMainScreen()),
              (route) => false);
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } else if (userRole == "admin") {
        // Handle admin role
      } else {
        showCustomFlushbar(
            context: context,
            message: "Unauthorized User",
            type: MessageType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/images/app_logo.png',
                  width: 200,
                  height: 85,
                )),
              ),
              SizedBox(
                height: 0,
              ),
              Text(
                "MeroCareer",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 0.2),
                          blurRadius: 5.0,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
              ),
              const Text(
                "Your Career, Your Path.",
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.05),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          right: 0,
          left: 0,
          child: LoadingAnimationWidget.fourRotatingDots(
            size: 35,
            color: Colors.blue,
          ),
        ),
      ]),
    );
  }
}
