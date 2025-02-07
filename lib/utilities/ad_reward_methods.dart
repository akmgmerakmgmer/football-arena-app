import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddRewardMethods {
  bool isFreeCoinsAvailable(
      LocaleProvider localeProvider, BuildContext context) {
    Map user = localeProvider.user;
    if (user['free_coins']['numberOfTimes'] >= 3) {
      String message = AppLocalizations.of(context)!.maximum_free_coins;
      SnackbarMessage().snackbar(context, message, error: true);
      return false;
    }
    return true;
  }

  addCoinsMethod(LocaleProvider localeProvider, BuildContext context) {
    Map user = localeProvider.user;
    int getRandomCoin() {
      List coinsList = [50, 100, 50, 25, 50, 200, 50, 100, 50, 25, 50];
      final random = Random(); // Create a Random instance
      int randomIndex = random.nextInt(coinsList.length); // Get a random index
      return coinsList[randomIndex]; // Return the coin at the random index
    }

    int coins = getRandomCoin();
    user['coins'] += coins;
    localeProvider.setUser(user);
    PutApi('add-coins/${user['_id']}', {'coins': coins}, (value) {
      localeProvider.setUser(value);
      List<Map> prizes = [
        {"prizeType": "coins", "coins": coins}
      ];
      ModalContainer.modal(context, PrizesContent(prizes: prizes),
          AppLocalizations.of(context)!.congratulations);
    }).put(context);
  }
}
