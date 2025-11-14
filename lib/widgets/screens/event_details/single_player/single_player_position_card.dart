import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SinglePlayerPositionCard extends StatelessWidget {
  final int userRank;
  final int userScore;
  final int totalPlayers;
  final String locale;
  final bool isInTop5;
  
  const SinglePlayerPositionCard({
    super.key,
    required this.userRank,
    required this.userScore,
    required this.totalPlayers,
    required this.locale,
    required this.isInTop5,
  });

  Color _getRankColor() {
    if (userRank == 1) return const Color(0xFFFFD700); // Gold
    if (userRank == 2) return const Color(0xFFC0C0C0); // Silver
    if (userRank == 3) return const Color(0xFFCD7F32); // Bronze
    if (userRank <= 5) return Colors.green;
    return Colors.blue;
  }

  IconData _getRankIcon() {
    if (userRank == 1) return Icons.emoji_events;
    if (userRank == 2) return Icons.military_tech;
    if (userRank == 3) return Icons.workspace_premium;
    if (userRank <= 5) return Icons.star;
    return Icons.trending_up;
  }

  String _getRankTitle() {
    if (locale == 'en') {
      if (userRank == 1) return '🏆 CHAMPION';
      if (userRank == 2) return '🥈 RUNNER-UP';
      if (userRank == 3) return '🥉 THIRD PLACE';
      if (userRank <= 5) return '⭐ TOP 5';
      return '📊 COMPETING';
    } else {
      if (userRank == 1) return '🏆 البطل';
      if (userRank == 2) return '🥈 الوصيف';
      if (userRank == 3) return '🥉 المركز الثالث';
      if (userRank <= 5) return '⭐ أفضل 5';
      return '📊 منافس';
    }
  }

  String _getPositionSuffix(int position) {
    if (locale != 'en') return '';
    
    if (position % 100 >= 11 && position % 100 <= 13) {
      return 'th';
    }
    
    switch (position % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = _getRankColor();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rankColor.withOpacity(0.3),
            rankColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rankColor.withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: rankColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Rank Title Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  rankColor.withOpacity(0.8),
                  rankColor.withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: rankColor.withOpacity(0.4),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TextWidget(
              title: _getRankTitle(),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Main Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Rank Display
              Expanded(
                child: _buildStatBox(
                  context,
                  icon: _getRankIcon(),
                  iconColor: rankColor,
                  label: locale == 'en' ? 'YOUR RANK' : 'ترتيبك',
                  value: '#$userRank',
                  suffix: locale == 'en' ? _getPositionSuffix(userRank) : '',
                  color: rankColor,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Score Display
              Expanded(
                child: _buildStatBox(
                  context,
                  icon: Icons.stars,
                  iconColor: Colors.amber,
                  label: locale == 'en' ? 'YOUR BEST SCORE' : 'أفضل نتيجة لك ',
                  value: userScore.toString(),
                  suffix: '',
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Total Players Info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
                const SizedBox(width: 8),
                TextWidget(
                  title: locale == 'en'
                      ? 'Competing with $totalPlayers players'
                      : 'المنافسة مع $totalPlayers لاعب',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ),
          
          // Prize Eligibility Banner (only for top 5)
          if (isInTop5) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.teal.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.card_giftcard,
                    color: Colors.green,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: locale == 'en'
                        ? '🎉 You\'re winning a prize!'
                        : '🎉 أنت تفوز بجائزة!',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String suffix,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: value,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                alwaysEnglish: true,
              ),
              if (suffix.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextWidget(
                    title: suffix,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.7),
                    alwaysEnglish: true,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: label,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ],
      ),
    );
  }
}
