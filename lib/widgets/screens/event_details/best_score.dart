import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/event_neon_shadows.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BestScore extends StatelessWidget {
  final int score;
  final String eventName;
  const BestScore({super.key, required this.score, required this.eventName});

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = EventNeonShadows.get(eventName, context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NeonWhiteText(
          word: AppLocalizations.of(context)!.best_score,
          fontSize: 28,
          shadow: shadows,
        ),
        const SizedBox(
          width: 10,
        ),
        NeonWhiteText(
          word: score.toString(),
          fontSize: 28,
          shadow: shadows,
        )
      ],
    );
  }
}
