import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/screens/account_profile.dart';
import 'package:flutter_challenge_mobile/screens/home.dart';
import 'package:flutter_challenge_mobile/screens/login.dart';
import 'package:flutter_challenge_mobile/screens/questions.dart';
import 'package:flutter_challenge_mobile/screens/rankings.dart';
import 'package:flutter_challenge_mobile/screens/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/locale_provider.dart';
import './my_I18n.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  dynamic _locale;
  void getLocale() async {
    SharedPreferences locale = await SharedPreferences.getInstance();
    if (locale.getString('locale') == null) {
      setState(() {
        _locale = const Locale('ar');
      });
    } else {
      setState(() {
        _locale = Locale(locale.getString('locale') as String);
      });
    }
  }

  @override
  void initState() {
    getLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: MyI18n((locale) => setState(() => _locale = locale),
          child: Consumer<LocaleProvider>(
            builder: (context, value, child) => MaterialApp(
                routes: {
                  '/home': (context) => const Home(),
                  '/signup': (context) => const Signup(),
                  '/login': (context) => const Login(),
                  '/questions': (context) => const Questions(),
                  '/rankings': (context) => const Rankings(),
                  '/profile': (context) => AccountProfile()
                },
                title: 'InZone',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ar', ''),
                ],
                locale: _locale,
                theme: ThemeData(
                  fontFamily: _locale == 'en' ? 'Oswald' : 'NotoKufiArabic',
                  primaryColor: const Color(0xFFF61A1A),
                  splashColor: const Color(0xFF111111),
                  primaryColorDark: const Color(0xFF191919),
                ),
                home: const Home()),
          )),
    );
  }
}
