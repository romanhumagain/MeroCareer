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

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final AuthServices authServices = AuthServices();
  bool isLoggedIn = false;
  String userRole = "";
  bool isUserVerified = false;
  bool isRecruiterApproved = false;

  @override
  void initState() {
    super.initState();
    logOut();
  }

  void logOut() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => true);
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
