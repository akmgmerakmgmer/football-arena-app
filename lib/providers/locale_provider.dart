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

  List _advertisments = [];
  List get advertisments {
    return _advertisments;
  }

  void setAdvertisments(value) {
    _advertisments = value;
    notifyListeners();
  }

  int _adCountDown = 181;
  int get adCountDown {
    return _adCountDown;
  }

  void setAdCountDown(value) {
    _adCountDown = value;
    notifyListeners();
  }

  Map _challenges = {};
  Map get challenges {
    return _challenges;
  }

  void setChallenges(value) {
    _challenges = value;
    notifyListeners();
  }
}
