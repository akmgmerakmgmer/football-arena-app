import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/questions/neon_title_and_number.dart';

class BankAndCurrentScore extends StatelessWidget {
  final ValueNotifier<int> bankScoreNotifier;
  final ValueNotifier<int> currentScoreNotifier;
  final double fontSize;
  final double? top;
  final String eventName;
  const BankAndCurrentScore({
    super.key,
    required this.bankScoreNotifier,
    required this.currentScoreNotifier,
    this.fontSize = 32,
    this.top = 22,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeonTitleAndNumber(
                    title: AppLocalizations.of(context)!.bank_score.toUpperCase(),
                    number: bankScoreNotifier,
                    shadow: NeonBoxShadow().blueNeon(context),
                    fontSize: fontSize,
                    eventName: eventName),
                const SizedBox(width: 32),
                NeonTitleAndNumber(
                    title: AppLocalizations.of(context)!.current_score.toUpperCase(),
                    number: currentScoreNotifier,
                    shadow: NeonBoxShadow().blueNeon(context),
                    fontSize: fontSize,
                    eventName: eventName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
