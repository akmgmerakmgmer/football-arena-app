import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/event_details/avatar_prize.dart';
import 'package:in_zone_app/widgets/screens/event_details/coin_prize.dart';

class PrizesContent extends StatelessWidget {
  final List prizes;
  final bool showExclusiveText;
  const PrizesContent({super.key, required this.prizes, required this.showExclusiveText});

  @override
  Widget build(BuildContext context) {
    Widget prizeWidget(prizeType, numberOfCoins, image) {
      switch (prizeType) {
        case "coins":
          return CoinPrize(numberOfCoins: numberOfCoins);
        case "avatar":
          return AvatarPrize(
            image: image,
            showExclusiveText: showExclusiveText,
          );
        default:
          return Container();
      }
    }

    return Column(
      children: prizes
          .map((prize) =>
              prizeWidget(prize['prizeType'], prize['coins'], prize['avatar']))
          .toList(),
    );
  }
}
