import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddRewardMethods {
  addCoinsMethod(LocaleProvider localeProvider, BuildContext context) {
    int getRandomCoin() {
      List coinsList = [50, 100, 50, 25, 50, 200, 50, 100, 50, 25, 50];
      final random = Random(); // Create a Random instance
      int randomIndex = random.nextInt(coinsList.length); // Get a random index
      return coinsList[randomIndex]; // Return the coin at the random index
    }

    Map user = localeProvider.user;
    int coins = getRandomCoin();
    user['coins'] += coins;
    localeProvider.setUser(user);
    PutApi('users/${user['_id']}', {'coins': user['coins']}, (value) {})
        .put(context);
    List<Map> prizes = [
      {"prizeType": "coins", "coins": coins}
    ];
    ModalContainer.modal(
        context,
        PrizesContent(prizes: prizes),
        AppLocalizations.of(context)!.congratulations);
  }
  
}
