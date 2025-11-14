import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class RankFlag extends StatelessWidget {
  final bool promote;
  final String locale;
  const RankFlag({super.key, this.promote = true, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            gradient: promote
                ? locale == 'en'
                    ? LinearGradient(colors: [
                        Colors.yellow.shade800,
                        Colors.yellow.shade800,
                        Colors.yellow.shade800,
                        Colors.white.withOpacity(0.03)
                      ])
                    : LinearGradient(colors: [
                        Colors.white.withOpacity(0.03),
                        Colors.yellow.shade800,
                        Colors.yellow.shade800,
                        Colors.yellow.shade800
                      ])
                : locale == 'en'
                    ? LinearGradient(colors: [
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.white.withOpacity(0.03)
                      ])
                    : LinearGradient(colors: [
                        Colors.white.withOpacity(0.03),
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.deepPurple
                      ])),
        child: TextWidget(
          title: promote
              ? AppLocalizations.of(context)!.win_promotion_flag
              : AppLocalizations.of(context)!.lose_demotion_flag,
          fontWeight: FontWeight.bold,
          uppercase: true,
          fontSize: 16,
        ),
      ),
    );
  }
}
