import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RankingPrize extends StatelessWidget {
  final int numberOfCoins;
  const RankingPrize({super.key, required this.numberOfCoins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.1)),
      child: Row(
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
      ),
    );
  }
}
