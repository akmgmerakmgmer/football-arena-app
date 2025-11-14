import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class UserInfoCard extends StatelessWidget {
  final Map user;
  final String locale;

  const UserInfoCard({
    super.key,
    required this.user,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    int level = user['rank']['rank_number'] ?? 1;
    int coins = user['coins'] ?? 0;
    String username = user['username'] ?? '';
    String avatarImage = user['selectedAvatar']?['image'] ?? '';

    // Get rank data
    Map rank = user['rank'] ?? {};
    String rankTitle = rank.isNotEmpty &&
            rank.containsKey('title') &&
            rank['title'].containsKey(locale)
        ? rank['title'][locale]
        : 'No Rank';
    String rankImage = rank['image'] ?? '';

    // Get stats data
    int totalMatches = user['season_results']['wins'] +
            user['season_results']['loses'] +
            user['season_results']['draws'] ??
        0;
    int wins = user['season_results']['wins'] ?? 0;
    double winRate = totalMatches > 0 ? (wins / totalMatches * 100) : 0;

    // Get position/ranking
    int position = user['position'] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.3),
              Theme.of(context).primaryColor.withOpacity(0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Avatar with Level
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                    image: avatarImage.isNotEmpty
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(avatarImage),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: avatarImage.isEmpty
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        )
                      : null,
                ),

                // Level Badge
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.orange,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: TextWidget(
                      title: level.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      alwaysEnglish: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // Username - Expanded to take available space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    title: username,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextWidget(
                          title: rankTitle,
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.9),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Divider
            Container(
              width: 1.5,
              height: 40,
              color: Colors.white.withOpacity(0.3),
            ),

            const SizedBox(width: 12),

            // Stats Section
            _buildStatItem(
              context,
              icon: Icons.sports_soccer,
              value: totalMatches.toString(),
              label: locale == 'en' ? 'Matches' : 'مباريات',
            ),

            const SizedBox(width: 12),

            // Divider
            Container(
              width: 1.5,
              height: 40,
              color: Colors.white.withOpacity(0.3),
            ),

            const SizedBox(width: 12),

            // Wins
            _buildStatItem(
              context,
              icon: Icons.emoji_events,
              value: wins.toString(),
              label: locale == 'en' ? 'Wins' : 'فوز',
              iconColor: Colors.amber,
            ),

            const SizedBox(width: 12),

            // Divider
            Container(
              width: 1.5,
              height: 40,
              color: Colors.white.withOpacity(0.3),
            ),

            const SizedBox(width: 12),

            // Win Rate
            _buildStatItem(
              context,
              icon: Icons.trending_up,
              value: '${winRate.toStringAsFixed(0)}%',
              label: locale == 'en' ? 'Win Rate' : 'معدل الفوز',
              iconColor: Colors.green,
            ),

            const SizedBox(width: 12),

            // Divider
            Container(
              width: 1.5,
              height: 40,
              color: Colors.white.withOpacity(0.3),
            ),

            const SizedBox(width: 12),

            // Rank Icon and Coins
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Rank Icon
                rankImage.isNotEmpty
                    ? CachedImage(
                        image: rankImage,
                        width: 28,
                        height: 28,
                      )
                    : const Icon(
                        Icons.workspace_premium,
                        color: Colors.amber,
                        size: 24,
                      ),
                const SizedBox(height: 4),
                // Coins
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Coin(width: 14),
                    const SizedBox(width: 3),
                    TextWidget(
                      title: coins.toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade300,
                      alwaysEnglish: true,
                    ),
                  ],
                ),
              ],
            ),

            // World Ranking (if available)
            if (position > 0) ...[
              const SizedBox(width: 12),

              // Divider
              Container(
                width: 1.5,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),

              const SizedBox(width: 12),

              _buildStatItem(
                context,
                icon: Icons.public,
                value: '#$position',
                label: locale == 'en' ? 'World' : 'عالمي',
                iconColor: Colors.blue,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor ?? Theme.of(context).primaryColor,
          size: 18,
        ),
        const SizedBox(height: 2),
        TextWidget(
          title: value,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          alwaysEnglish: true,
        ),
        TextWidget(
          title: label,
          fontSize: 9,
          color: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }
}
