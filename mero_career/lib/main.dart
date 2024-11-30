import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/recruiters/common/recruiter_main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
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
        // home: SplashScreen(),
        // home: MainScreen(),
        home: RecruiterMainScreen(),
        // home: ProfileSetupPage()
      );
    });
  }
}
