import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade600,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade600,
      onPrimary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.grey.shade200,
      surfaceContainer: Colors.grey.shade300,
      onSurface: Colors.black87,
      error: Colors.red,
      onError: Colors.white,
      secondary: Colors.blue.shade400,
      onSecondary: Colors.white,
      tertiary: Colors.grey[600],
      inversePrimary: Colors.white,
    ),
    textTheme: TextTheme(
      // -----------------//
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black87, // Medium title
        // Slightly lighter headline
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade900, // Lighter color for smaller headlines
      ),

      // ------------------- //
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black, // Black for large titles
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black87, // Medium title
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black54, // Smaller title text
      ),

      // ------------- //
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black, // Black for large labels
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600, // Medium label
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600, // Small label text
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.grey.shade50));
