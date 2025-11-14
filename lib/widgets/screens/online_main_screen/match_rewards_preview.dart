import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class MatchRewardsPreview extends StatelessWidget {
  final int? coins;
  final String? xpMultiplier;
  final String? bonusText;
  final String locale;
  final bool showGlow;
  
  const MatchRewardsPreview({
    super.key,
    this.coins,
    this.xpMultiplier,
    this.bonusText,
    required this.locale,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (coins == null && xpMultiplier == null && bonusText == null) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withOpacity(0.9),
            Colors.orange.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.orange.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 6),
          if (coins != null) ...[
            const Coin(width: 16),
            const SizedBox(width: 4),
            TextWidget(
              title: '$coins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              alwaysEnglish: true,
            ),
          ],
          if (coins != null && (xpMultiplier != null || bonusText != null))
            Container(
              width: 1,
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white.withOpacity(0.5),
            ),
          if (xpMultiplier != null) ...[
            Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            TextWidget(
              title: '${xpMultiplier}x XP',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              alwaysEnglish: true,
            ),
          ],
          if (bonusText != null && coins == null && xpMultiplier == null) ...[
            TextWidget(
              title: bonusText!,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ],
      ),
    );
  }
}
