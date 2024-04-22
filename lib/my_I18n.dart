import 'package:flutter/material.dart';

class MyI18n extends InheritedWidget {
  final Function(Locale) _localeChangeCallback;

  const MyI18n(
    this._localeChangeCallback, {
    super.key,
    required super.child,
  });

  static MyI18n? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyI18n>();
  }

  void changeLocale(Locale locale) {
    _localeChangeCallback.call(locale);
  }

  @override
  bool updateShouldNotify(MyI18n oldWidget) {
    return true;
  }
}
