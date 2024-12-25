import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/event_details/image_prize.dart';
import 'package:in_zone_app/widgets/screens/event_details/coin_prize.dart';

class PrizesContent extends StatelessWidget {
  final List prizes;
  final bool showExclusiveText;
  const PrizesContent(
      {super.key, required this.prizes, required this.showExclusiveText});

  @override
  Widget build(BuildContext context) {
    Widget prizeWidget(prizeType, numberOfCoins, image, theme) {
      switch (prizeType) {
        case "coins":
          return CoinPrize(numberOfCoins: numberOfCoins);
        case "avatar":
          return ImagePrize(
              image: image,
              showExclusiveText: showExclusiveText,
              prizeType: prizeType);
        case "theme":
          return ImagePrize(
            image: theme,
            showExclusiveText: showExclusiveText,
            prizeType: prizeType,
            topMargin: true,
          );
        default:
          return Container();
      }
    }

    return Column(
      children: prizes
          .map((prize) => prizeWidget(prize['prizeType'], prize['coins'],
              prize['avatar'], prize['theme']))
          .toList(),
    );
  }
}
