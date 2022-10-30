import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoggedIn;
  String _language;
  AppProvider(this._isLoggedIn, this._language);

  get getIsLoggedIn => _isLoggedIn;
  get getLanguage => _language;

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }
}
