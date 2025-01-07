import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/account_profile.dart';
import 'package:in_zone_app/screens/best_offers.dart';
import 'package:in_zone_app/screens/challenges.dart';
import 'package:in_zone_app/screens/event_details.dart';
import 'package:in_zone_app/screens/home.dart';
import 'package:in_zone_app/screens/login.dart';
import 'package:in_zone_app/screens/main_online.dart';
import 'package:in_zone_app/screens/multi-questions.dart';
import 'package:in_zone_app/screens/multi_screen.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/screens/rankings.dart';
import 'package:in_zone_app/screens/results.dart';
import 'package:in_zone_app/screens/shop.dart';
import 'package:in_zone_app/screens/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/locale_provider.dart';
import './my_I18n.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
                  '/challenges': (context) => const Challenges(),
                  '/profile': (context) => AccountProfile(),
                  '/events': (context) => const EventDetails(),
                  '/best-offers': (context) => const BestOffers(),
                  '/shop': (context) => const Shop(),
                  '/main-online': (context) => const MainOnline(),
                  '/results': (context) => const Results(),
                  '/multi-screen': (context) => const MultiScreen(),
                  '/multi-questions': (context) => const MultiQuestions()
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
                  splashColor: const Color.fromARGB(255, 22, 22, 22),
                  primaryColorDark: const Color.fromARGB(255, 30, 30, 30),
                ),
                home: const Home()),
          )),
    );
  }
}
