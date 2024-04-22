import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/my_I18n.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralMethods {
  void changeLanguage(context, lang) async {
    MyI18n.of(context)!.changeLocale(Locale(lang));
    Provider.of<LocaleProvider>(context, listen: false).changeLocale(lang);
    SharedPreferences locale = await SharedPreferences.getInstance();
    locale.setString('locale', lang);
  }
}
