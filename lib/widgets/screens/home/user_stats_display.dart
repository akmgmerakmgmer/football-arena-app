import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class UserStatsDisplay extends StatelessWidget {
  final Map user;
  final String locale;

  const UserStatsDisplay({
    super.key,
    required this.user,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    // Get user stats
    int coins = user['coins'] ?? 0;
    Map rank = user['rank'] ?? {};
    String rankTitle = rank.isNotEmpty &&
            rank.containsKey('title') &&
            rank['title'].containsKey(locale)
        ? rank['title'][locale]
        : 'No Rank';

    return Container(
      margin: const EdgeInsets.only(top: 12.0, bottom: 0.0, left: 12.0, right: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.9),
            Theme.of(context).primaryColor.withOpacity(0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Online Rank
          Expanded(
            flex: 3,
            child: Row(
              children: [
                rank.isNotEmpty && rank.containsKey('image')
                    ? CachedImage(
                        image: rank['image'],
                        width: 50,
                        height: 50,
                      )
                    : const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 32,
                      ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        title: rankTitle,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextWidget(
                        title: 'Online Rank',
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 50,
            width: 1.5,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.white.withOpacity(0.3),
          ),

          // Coins
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Coin(width: 30,)
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        title: coins.toString(),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        alwaysEnglish: true,
                      ),
                      TextWidget(
                        title: AppLocalizations.of(context)!.coins,
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
