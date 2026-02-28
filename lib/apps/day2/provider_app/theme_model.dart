import 'package:flutter/material.dart';

/// Q22: Another ChangeNotifier example for theme switching
class ThemeModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    notifyListeners();
    
    print('Theme changed to: $_themeMode');
  }
}