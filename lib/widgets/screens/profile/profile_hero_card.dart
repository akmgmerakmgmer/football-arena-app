import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/profile/main_image.dart';
import 'package:provider/provider.dart';

class ProfileHeroCard extends StatelessWidget {
  final Map user;
  final Function onAvatarTap;
  
  const ProfileHeroCard({
    super.key,
    required this.user,
    required this.onAvatarTap,
  });

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    
    if (hour < 12) {
      return locale == 'en' ? 'Good Morning' : 'صباح الخير';
    } else if (hour < 17) {
      return locale == 'en' ? 'Good Afternoon' : 'مساء الخير';
    } else {
      return locale == 'en' ? 'Good Evening' : 'مساء الخير';
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    
    // Calculate stats
    int totalMatches = user['totalMatches'] ?? 0;
    int wins = user['wins'] ?? 0;
    double winRate = totalMatches > 0 ? (wins / totalMatches * 100) : 0;
    int level = user['rank']['rank_number'] ?? 1;
    int coins = user['coins'] ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.2),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar and Level Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: MainImage(
                  image: user['selectedAvatar']['image'],
                  action: onAvatarTap,
                  width: 130,
                  height: 130,
                ),
              ),
              // Level Badge
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: level.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alwaysEnglish: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Greeting
          TextWidget(
            title: _getGreeting(context),
            fontSize: 16,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w500,
          ),
          
          const SizedBox(height: 4),
          
          // Username
          TextWidget(
            title: user['username'],
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          
          const SizedBox(height: 16),
          
          // Coins Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Coin(width: 24),
                const SizedBox(width: 8),
                TextWidget(
                  title: coins.toString(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  alwaysEnglish: true,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Stats Row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Matches
                _buildStatItem(
                  context,
                  icon: Icons.sports_soccer,
                  label: locale == 'en' ? 'Matches' : 'مباريات',
                  value: totalMatches.toString(),
                ),
                
                // Divider
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.withOpacity(0.3),
                ),
                
                // Wins
                _buildStatItem(
                  context,
                  icon: Icons.emoji_events,
                  label: locale == 'en' ? 'Wins' : 'انتصارات',
                  value: wins.toString(),
                ),
                
                // Divider
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.withOpacity(0.3),
                ),
                
                // Win Rate
                _buildStatItem(
                  context,
                  icon: Icons.trending_up,
                  label: locale == 'en' ? 'Win Rate' : 'نسبة الفوز',
                  value: '${winRate.toStringAsFixed(0)}%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
        const SizedBox(height: 6),
        TextWidget(
          title: value,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          alwaysEnglish: true,
        ),
        const SizedBox(height: 2),
        TextWidget(
          title: label,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
