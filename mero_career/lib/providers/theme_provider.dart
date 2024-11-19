import 'package:flutter/material.dart';
import 'package:mero_career/theme/dark_theme.dart';
import 'package:mero_career/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _isDarkMode;

  void updateTheme({required bool value}) {
    if (value) {
      _isDarkMode = value;
      _themeData = darkMode;
    } else {
      _isDarkMode = value;
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
