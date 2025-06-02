import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/event_score.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                Column(
                  children: [
                    NeonWhiteText(
                      word: AppLocalizations.of(context)!
                          .bank_score
                          .toUpperCase(),
                      fontSize: fontSize * 0.7,
                      shadow: NeonBoxShadow().blueNeon(context),
                    ),
                    const SizedBox(height: 4),
                    EventScore(
                      scoreNotifier: bankScoreNotifier,
                      fontSize: fontSize,
                      top: 0,
                      eventName: eventName,
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    NeonWhiteText(
                      word: AppLocalizations.of(context)!
                          .current_score
                          .toUpperCase(),
                      fontSize: fontSize * 0.7,
                      shadow: NeonBoxShadow().blueNeon(context),
                    ),
                    const SizedBox(height: 4),
                    EventScore(
                      scoreNotifier: currentScoreNotifier,
                      fontSize: fontSize,
                      top: 0,
                      eventName: eventName,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
