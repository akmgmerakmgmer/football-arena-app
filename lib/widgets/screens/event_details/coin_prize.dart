import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/event_details/prize_reason.dart';

class CoinPrize extends StatelessWidget {
  final int numberOfCoins;
  final Map message;
  final String locale;
  const CoinPrize(
      {super.key,
      required this.numberOfCoins,
      this.message = const {"en": "", "ar": ""},
      required this.locale});

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
          message[locale].isNotEmpty
              ? PrizeReason(
                  message: message,
                  locale: locale,
                )
              : Container(),
          message[locale].isNotEmpty
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
