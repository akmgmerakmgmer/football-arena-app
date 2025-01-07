import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/event_details/image_prize.dart';
import 'package:in_zone_app/widgets/screens/event_details/coin_prize.dart';

class PrizesContent extends StatelessWidget {
  final List prizes;
  const PrizesContent({super.key, required this.prizes});

  @override
  Widget build(BuildContext context) {
    Widget prizeWidget(prizeType, numberOfCoins, image, theme, searchTime) {
      switch (prizeType) {
        case "coins":
          return CoinPrize(
            numberOfCoins: numberOfCoins,
            searchTime: searchTime,
          );
        case "avatar":
          return ImagePrize(image: image, prizeType: prizeType);
        case "theme":
          return ImagePrize(
            image: theme,
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
              prize['avatar'], prize['theme'], prize['searchTime'] ?? ''))
          .toList(),
    );
  }
}
