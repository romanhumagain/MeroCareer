import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mero_career/views/job_seekers/common/main_screen.dart';
import 'package:mero_career/views/recruiters/common/recruiter_main_screen.dart';
import 'package:mero_career/views/shared/onboarding/on_boarding.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLoginStatus();

    Timer(Duration(seconds: 4), () {
      if (isLoggedIn) {
        if (userRole == "job_seeker") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        } else if (userRole == "recruiter") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RecruiterMainScreen()));
        } else if (userRole == "admin") {
        } else {
          showCustomFlushbar(
              context: context,
              message: "Unauthorized User",
              type: MessageType.error);
        }
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    });
  }

  void checkUserLoginStatus() async {
    bool loggedIn = await authServices.isLoggedIn();
    bool? isVerified = await authServices.getUserVerificationStatus();

    if (isVerified!) {
      if (loggedIn) {
        String? role = await authServices.getUserRole();
        setState(() {
          isLoggedIn = true;
          userRole = role!;
        });
        return;
      }
      try {
        await authServices.refreshAccessToken();
        loggedIn = await authServices.isLoggedIn();
        String? role = await authServices.getUserRole();
        setState(() {
          isLoggedIn = loggedIn;
          userRole = role!;
        });
      } catch (e) {
        setState(() {
          isLoggedIn = false;
        });
      }
    }
    return;
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
