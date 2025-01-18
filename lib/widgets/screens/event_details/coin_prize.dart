import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/event_details/prize_reason.dart';

class CoinPrize extends StatelessWidget {
  final int numberOfCoins;
  final String searchTime;
  const CoinPrize(
      {super.key, required this.numberOfCoins, this.searchTime = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrizeReason(
            searchTime: searchTime,
          ),
          searchTime.isNotEmpty
              ? const SizedBox(
                  height: 4,
                )
              : Container(),
          Row(
            children: [
              const Coin(),
              const SizedBox(
                width: 4,
              ),
              TextWidget(
                title:
                    '${numberOfCoins.toString()} ${AppLocalizations.of(context)!.inzoneCoins}',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                alwaysEnglish: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
