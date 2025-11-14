import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class TopPlayersLeaderboard extends StatelessWidget {
  final List rankings;
  final String currentUserId;
  final List prizes;
  final String locale;
  
  const TopPlayersLeaderboard({
    super.key,
    required this.rankings,
    required this.currentUserId,
    required this.prizes,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    // Take top 5 or all available rankings
    final top5 = rankings.take(5).toList();
    
    if (top5.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: TextWidget(
            title: locale == 'en' 
                ? 'No rankings yet. Be the first!'
                : 'لا يوجد ترتيب بعد. كن الأول!',
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.withOpacity(0.2),
            Colors.indigo.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.3),
                      Colors.orange.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: locale == 'en' ? 'TOP 5 LEADERBOARD' : 'أفضل 5 لاعبين',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Podium for top 3
          if (top5.isNotEmpty) _buildPodium(context, top5),
          
          const SizedBox(height: 20),
          
          // List for ranks 4-5
          if (top5.length > 3)
            ...top5.skip(3).toList().asMap().entries.map((entry) {
              final rank = entry.key + 4;
              final player = entry.value;
              return _buildPlayerRow(
                context,
                rank: rank,
                player: player,
                prizeCoins: rank <= prizes.length ? prizes[rank - 1]['coins'] : 0,
              );
            }),
        ],
      ),
    );
  }

  Widget _buildPodium(BuildContext context, List top5) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background glow effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 2nd Place (Left)
              if (top5.length > 1)
                _buildPodiumPosition(
                  context,
                  rank: 2,
                  player: top5[1],
                  height: 130,
                  color: const Color(0xFFC0C0C0),
                  icon: Icons.military_tech,
                  prizeCoins: prizes.length > 1 ? prizes[1]['coins'] : 0,
                ),
              
              const SizedBox(width: 8),
              
              // 1st Place (Center - Tallest)
              _buildPodiumPosition(
                context,
                rank: 1,
                player: top5[0],
                height: 160,
                color: const Color(0xFFFFD700),
                icon: Icons.emoji_events,
                prizeCoins: prizes.isNotEmpty ? prizes[0]['coins'] : 0,
              ),
              
              const SizedBox(width: 8),
              
              // 3rd Place (Right)
              if (top5.length > 2)
                _buildPodiumPosition(
                  context,
                  rank: 3,
                  player: top5[2],
                  height: 110,
                  color: const Color(0xFFCD7F32),
                  icon: Icons.workspace_premium,
                  prizeCoins: prizes.length > 2 ? prizes[2]['coins'] : 0,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(
    BuildContext context, {
    required int rank,
    required dynamic player,
    required double height,
    required Color color,
    required IconData icon,
    required int prizeCoins,
  }) {
    final userId = player['userId'];
    final isCurrentUser = userId['_id'].toString() == currentUserId;
    final points = player['points'] ?? 0;
    final username = userId['username'] ?? 'Player';
    final avatarUrl = userId['selectedAvatar']?['image'] ?? '';
    
    return Container(
      width: 100,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Avatar with rank badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CachedImage(
                  image: avatarUrl,
                  width: 60,
                  height: 60,
                  radius: 30,
                ),
              ),
              // Rank badge
              Positioned(
                top: -8,
                left: -8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.7),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Podium Base
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withOpacity(0.6),
                    color.withOpacity(0.3),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: color.withOpacity(0.8),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Username
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextWidget(
                      title: username,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  if (isCurrentUser) ...[
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextWidget(
                        title: locale == 'en' ? 'YOU' : 'أنت',
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 4),
                  
                  // Score
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stars,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      TextWidget(
                        title: points.toString(),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alwaysEnglish: true,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Prize
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Coin(width: 10),
                        const SizedBox(width: 2),
                        TextWidget(
                          title: prizeCoins.toString(),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          alwaysEnglish: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(
    BuildContext context, {
    required int rank,
    required dynamic player,
    required int prizeCoins,
  }) {
    final userId = player['userId'];
    final isCurrentUser = userId['_id'].toString() == currentUserId;
    final points = player['points'] ?? 0;
    final username = userId['username'] ?? 'Player';
    final avatarUrl = userId['selectedAvatar']?['image'] ?? '';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.amber.withOpacity(0.2)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser
              ? Colors.amber.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          width: isCurrentUser ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.5),
                  Colors.pink.withOpacity(0.5),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: TextWidget(
                title: '#$rank',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                alwaysEnglish: true,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrentUser ? Colors.amber : Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: CachedImage(
              image: avatarUrl,
              width: 40,
              height: 40,
              radius: 20,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Username
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextWidget(
                        title: username,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextWidget(
                          title: locale == 'en' ? 'YOU' : 'أنت',
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Coin(width: 12),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: '$prizeCoins',
                      fontSize: 11,
                      color: Colors.amber,
                      alwaysEnglish: true,
                    ),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: locale == 'en' ? 'coins' : 'عملة',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.pink.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.purple.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.stars,
                  color: Colors.amber,
                  size: 14,
                ),
                const SizedBox(width: 4),
                TextWidget(
                  title: points.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  alwaysEnglish: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
