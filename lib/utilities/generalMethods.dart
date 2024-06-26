import 'package:flutter/material.dart';
import 'package:in_zone_app/my_I18n.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
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
