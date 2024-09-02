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

  Map _advertisments = {};
  Map get advertisments {
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

  List _avatars = [];
  List get avatars {
    return _avatars;
  }

  void setAvatars(value) {
    _avatars = value;
    notifyListeners();
  }

  Map _shopItems = {};
  Map get shopItems {
    return _shopItems;
  }

  void setShopItems(value) {
    _shopItems = value;
    notifyListeners();
  }
}
