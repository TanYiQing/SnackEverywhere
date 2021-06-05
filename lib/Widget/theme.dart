import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
      backgroundColor: Colors.grey[800],
      focusColor: Colors.black,
      accentColor: Colors.grey[900],
      primaryColor: Colors.grey[900],
      primaryColorLight: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: Colors.white,
      cardColor: Colors.black,
      colorScheme: ColorScheme.dark(
          primary: Colors.grey[900], secondary: Colors.grey[900]),
    );
  }

  static ThemeData get lighttheme {
    return ThemeData(
      backgroundColor: Colors.grey[200],
      focusColor: Colors.black,
      primaryColor: Colors.white,
      accentColor: Colors.amber,
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.black,
      brightness: Brightness.light,
      cardColor: Colors.white,
      
      colorScheme: ColorScheme.light(
          primary: Colors.orange[400], secondary: Colors.yellowAccent),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = true;
    notifyListeners();
    _saveToPrefs();
  }

  toggleTheme1() {
    _darkTheme = false;
    notifyListeners();
    _saveToPrefs();
  }

  _loadFromPrefs() async {
    await _initPref();
    _darkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPref();
    _prefs.setBool(key, _darkTheme);
  }

  _initPref() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }
}
