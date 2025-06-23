import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/account_profile.dart';
import 'package:in_zone_app/screens/all_ranks.dart';
import 'package:in_zone_app/screens/best_offers.dart';
import 'package:in_zone_app/screens/challenges.dart';
import 'package:in_zone_app/screens/event_details.dart';
import 'package:in_zone_app/screens/home.dart';
import 'package:in_zone_app/screens/login.dart';
import 'package:in_zone_app/screens/main_online.dart';
import 'package:in_zone_app/screens/main_online_screen.dart';
import 'package:in_zone_app/screens/multi-questions.dart';
import 'package:in_zone_app/screens/multi_screen.dart';
import 'package:in_zone_app/screens/play_alone.dart';
import 'package:in_zone_app/screens/prev_ranks.dart';
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
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
late AppsflyerSdk appsflyerSdk;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RequestConfiguration configuration = RequestConfiguration(
    tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
    tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
  );
  AppsFlyerOptions options = AppsFlyerOptions(
    afDevKey: "cWVdmyZBAK6bLpAJKq3CMG", // From Appsflyer dashboard
    appId: "", // iOS App ID only – leave empty for Android
    showDebug: true,
  );

  appsflyerSdk = AppsflyerSdk(options);

  appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: false,
    registerOnDeepLinkingCallback: false,
  );
  MobileAds.instance.updateRequestConfiguration(configuration);
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
      // Get the device locale
      final deviceLocale =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      final isArabic = deviceLocale == 'ar';

      setState(() {
        _locale = Locale(isArabic ? 'ar' : 'ar');
      });
      // Save the locale preference
      locale.setString('locale', isArabic ? 'ar' : 'ar');
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
                  '/profile': (context) => const AccountProfile(),
                  '/events': (context) => const EventDetails(),
                  '/best-offers': (context) => const BestOffers(),
                  '/shop': (context) => const Shop(),
                  '/play-alone': (context) => const PlayAlone(),
                  '/main-online': (context) => const MainOnline(),
                  '/main-online-screen': (context) => const MainOnlineScreen(),
                  '/results': (context) => const Results(),
                  '/ranks': (context) => const AllRanks(),
                  '/prev-ranks': (context) => const PrevRanks(),
                  '/multi-screen': (context) => const MultiScreen(),
                  '/multi-questions': (context) => const MultiQuestions()
                },
                title: 'InZone Football',
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
                  // const Color.fromARGB(255, 251, 8, 49)
                  splashColor: const Color.fromARGB(255, 22, 22, 22),
                  primaryColorDark: const Color.fromARGB(255, 30, 30, 30),
                ),
                home: const PlayAlone()),
          )),
    );
  }
}
