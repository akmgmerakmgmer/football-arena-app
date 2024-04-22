import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  String _locale = '';

  String get locale {
    return _locale;
  }

  void changeLocale(value) {
    _locale = value;
    notifyListeners();
  }

  Map _user = {};
  Map get user {
    return _user;
  }
  
  void setUser(value) {
    _user = value;
    notifyListeners();
  }

}
