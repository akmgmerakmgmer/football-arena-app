// ignore: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in_zone_app/my_I18n.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralMethods {
  final SocketMethods socketMethods = SocketMethods();
  void changeLanguage(context) async {
    String lang = getLocale(context) == 'ar' ? 'en' : 'ar';
    MyI18n.of(context)!.changeLocale(Locale(lang));
    Provider.of<LocaleProvider>(context, listen: false).changeLocale(lang);
    SharedPreferences locale = await SharedPreferences.getInstance();
    locale.setString('locale', lang);
  }

  bool isUserExists(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isNotEmpty && user.containsKey('username')) return true;
    return false;
  }

  String getLocale(context) {
    return Provider.of<LocaleProvider>(context, listen: false).locale;
  }

  bool isUserUnder13(Map user) {
    if (user['birthdate'] != null) {
      try {
        DateTime birthdate = DateTime.parse(user['birthdate']);
        int age = DateTime.now().year - birthdate.year;
        if (DateTime.now().month < birthdate.month ||
            (DateTime.now().month == birthdate.month && DateTime.now().day < birthdate.day)) {
          age--;
        }
        return age < 13;
      } catch (_) {
        return false; // fallback: show ad if parsing fails
      }
    }
    return false;
  }

  joinGameWithAds(context, localeProvider,
      {hostRoom = false,
      isCasual = false,
      code = '',
      mode = '',
      isOnline = false,
      numberOfPlayers = 2,
      gameDuration = 90}) {
    int getRandomNumber() {
      List coinsList = [1, 2, 3];
      final random = Random(); // Create a Random instance
      int randomIndex = random.nextInt(coinsList.length); // Get a random index
      return coinsList[randomIndex]; // Return the coin at the random index
    }

    bool showAd = getRandomNumber() == 1 ? true : false;
    bool isUnder13 = isUserUnder13(localeProvider.user);
    if (showAd && !isUnder13) {
      AdMethods().showInterstitialAd(() {
        Future.delayed(const Duration(seconds: 4), () {
          socketMethods.joinRoom(context, localeProvider,
              questionMode: mode,
              hostRoom: hostRoom,
              isCasual: isCasual,
              isOnline: isOnline,
              code: code,
              numberOfPlayers: numberOfPlayers,
              gameDuration: gameDuration);
        });
      }, context);
    } else {
      socketMethods.joinRoom(context, localeProvider,
          questionMode: mode,
          hostRoom: hostRoom,
          isCasual: isCasual,
          isOnline: isOnline,
          code: code,
          numberOfPlayers: numberOfPlayers,
          gameDuration: gameDuration);
    }
  }

  playWithCoins(BuildContext context, LocaleProvider localeProvider,
      String mode, bool isOnline, bool hostRoom, bool isCasual) {
    if (context.mounted) {
      Map user = localeProvider.user;
      if (user['coins'] < 100) {
        return SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.not_enough_coins,
            label: AppLocalizations.of(context)!.buy_coins,
            error: true, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/shop');
        });
      } else {
        if (isOnline) {
          PutApi('users/${user['_id']}', {'coins': user['coins'] - 100}, (res) {
            localeProvider.setUser(res);
          }).put(context);
          socketMethods.joinRoom(context, localeProvider,
              questionMode: mode,
              coinsPayed: true,
              hostRoom: hostRoom,
              isCasual: isCasual);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: '/questions'),
              builder: (context) => Questions(
                questionMode: mode,
                price: 100,
                userId: localeProvider.user['_id'],
              ),
            ),
          );
        }
      }
    }
  }

  dynamicMethod(BuildContext context) {
    FetchApi('dynamic-question-method', (res) => {print(res)}).fetch(context);
  }
}
