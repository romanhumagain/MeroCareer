import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mero_career/views/shared/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoarding()));
    });
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
                  'assets/images/logo.png',
                  width: 200,
                  height: 100,
                )),
              ),
              SizedBox(
                height:0,
              ),
              Text(
                "MeroCareer",
                style: TextStyle(
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
