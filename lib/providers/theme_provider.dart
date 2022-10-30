import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark(useMaterial3: true);
var lightTheme = ThemeData.light(useMaterial3: true);

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeProvider(this._themeData);

  ThemeData get getTheme => _themeData;
  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
