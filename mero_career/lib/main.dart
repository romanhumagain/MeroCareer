import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_provider.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/providers/recruiter_provider.dart';
import 'package:mero_career/providers/search_provider.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/shared/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => RecruiterProvider()),
      ChangeNotifierProvider(create: (_) => JobProvider()),
      ChangeNotifierProvider(create: (_) => JobSeekerProvider()),
      ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
      ChangeNotifierProvider(create: (_) => JobSeekerJobProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.isDarkMode
            ? themeProvider.themeData
            : themeProvider.themeData,
        home: SplashScreen(),
        // home: MainScreen(),
        // home: RecruiterMainScreen(),
        // home: ProfileSetupPage()
        // home: AdminHomeScreen(),
      );
    });
  }
}
