import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RivalPlayersCard extends StatelessWidget {
  final RivalPlayer? playerAbove;
  final RivalPlayer? playerBelow;
  final String locale;
  final VoidCallback? onViewLeaderboard;
  
  const RivalPlayersCard({
    super.key,
    this.playerAbove,
    this.playerBelow,
    required this.locale,
    this.onViewLeaderboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.withOpacity(0.2),
            Colors.deepPurple.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                TextWidget(
                  title: locale == 'en' ? 'RIVAL PLAYERS' : 'المنافسون',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                const Spacer(),
                if (onViewLeaderboard != null)
                  InkWell(
                    onTap: onViewLeaderboard,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepPurple.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(
                            title: locale == 'en' ? 'View All' : 'عرض الكل',
                            fontSize: 11,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Player Above
          if (playerAbove != null)
            _buildRivalPlayerRow(
              context,
              player: playerAbove!,
              isAbove: true,
            ),
          
          // Divider with "YOU" indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.amber,
                    thickness: 1.5,
                    indent: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.withOpacity(0.8),
                        Colors.orange.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: TextWidget(
                    title: locale == 'en' ? 'YOU' : 'أنت',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.amber,
                    thickness: 1.5,
                    endIndent: 16,
                  ),
                ),
              ],
            ),
          ),
          
          // Player Below
          if (playerBelow != null)
            _buildRivalPlayerRow(
              context,
              player: playerBelow!,
              isAbove: false,
            ),
          
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRivalPlayerRow(
    BuildContext context, {
    required RivalPlayer player,
    required bool isAbove,
  }) {
    final pointsDifference = player.pointsDifference.abs();
    final actionColor = isAbove ? Colors.green : Colors.orange;
    final actionText = isAbove
        ? (locale == 'en' ? 'BEAT' : 'تجاوز')
        : (locale == 'en' ? 'DEFEND' : 'دافع');
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAbove 
              ? Colors.green.withOpacity(0.3) 
              : Colors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Rank with arrow
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isAbove
                    ? [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.1)]
                    : [Colors.orange.withOpacity(0.3), Colors.orange.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  isAbove ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isAbove ? Colors.green : Colors.orange,
                  size: 14,
                ),
                TextWidget(
                  title: '#${player.rank}',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  alwaysEnglish: true,
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isAbove ? Colors.green : Colors.orange,
                width: 2,
              ),
            ),
            child: CachedImage(
              image: player.avatarUrl,
              width: 40,
              height: 40,
              radius: 20,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Name and Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: player.username,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.stars,
                      color: Colors.amber,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: '${player.points}',
                      fontSize: 11,
                      color: Colors.amber,
                      alwaysEnglish: true,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.emoji_events,
                      color: Colors.yellow,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: '${player.wins}',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.7),
                      alwaysEnglish: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Points Difference and Action
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: actionColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: actionColor.withOpacity(0.5),
                  ),
                ),
                child: TextWidget(
                  title: actionText,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: actionColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isAbove ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white.withOpacity(0.5),
                    size: 10,
                  ),
                  const SizedBox(width: 2),
                  TextWidget(
                    title: '$pointsDifference',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.7),
                    alwaysEnglish: true,
                  ),
                  const SizedBox(width: 2),
                  TextWidget(
                    title: locale == 'en' ? 'pts' : 'نقطة',
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RivalPlayer {
  final int rank;
  final String username;
  final String avatarUrl;
  final int points;
  final int wins;
  final int pointsDifference; // Positive if above, negative if below

  const RivalPlayer({
    required this.rank,
    required this.username,
    required this.avatarUrl,
    required this.points,
    required this.wins,
    required this.pointsDifference,
  });
}
