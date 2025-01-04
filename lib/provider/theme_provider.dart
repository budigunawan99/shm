import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
