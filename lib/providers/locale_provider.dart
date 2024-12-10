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

  List _themes = [];
  List get themes {
    return _themes;
  }

  void setThemes(value) {
    _themes = value;
    notifyListeners();
  }

  List _events = [];
  List get events {
    return _events;
  }

  void setEvents(value) {
    _events = value;
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

  Map _room = {};
  Map get room {
    return _room;
  }

  void setRoom(value) {
    _room = value;
    notifyListeners();
  }
}
