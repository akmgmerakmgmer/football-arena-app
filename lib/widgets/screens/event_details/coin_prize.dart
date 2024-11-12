import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoinPrize extends StatelessWidget {
  final int numberOfCoins;
  const CoinPrize({super.key, required this.numberOfCoins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Image.asset(
            'assets/images/coin.png',
            fit: BoxFit.cover,
            width: 25,
          ),
          const SizedBox(
            width: 4,
          ),
          TextWidget(
            title:
                '${numberOfCoins.toString()} ${AppLocalizations.of(context)!.inzoneCoins}',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            alwaysEnglish: true,
          ),
        ],
      ),
    );
  }
}