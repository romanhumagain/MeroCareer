import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue.shade600,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      onPrimary: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.grey.shade900.withOpacity(0.4),
      surfaceContainer: Colors.grey.shade900,
      onSurface: Colors.white70,
      error: Colors.red,
      onError: Colors.white,
      secondary: Colors.blue.shade400,
      onSecondary: Colors.black,
      tertiary: Colors.grey[500],
      inversePrimary: Colors.black,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 0.4),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade200,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade400,
      ),

      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade200, // Medium title
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade500, // Smaller title text
      ),

      // ----------------- ///

      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade400,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade500,
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.grey.shade900));
