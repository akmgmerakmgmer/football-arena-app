import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RankingPrize extends StatelessWidget {
  final int numberOfCoins;
  const RankingPrize({super.key, required this.numberOfCoins});

  @override
  Widget build(BuildContext context) {
    return WhiteGlassBackground(
        body: Row(
      children: [
        TextWidget(
          title: numberOfCoins.toString(),
          fontSize: 16,
          alwaysEnglish: true,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          width: 3,
        ),
        const Coin(
          width: 20,
        ),
      ],
    ));
  }
}
