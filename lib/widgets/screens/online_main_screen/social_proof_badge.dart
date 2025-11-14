import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SocialProofBadge extends StatelessWidget {
  final int? recentJoins;
  final String? recentWinner;
  final int? friendsActive;
  final String locale;
  final Duration? timeWindow;
  
  const SocialProofBadge({
    super.key,
    this.recentJoins,
    this.recentWinner,
    this.friendsActive,
    required this.locale,
    this.timeWindow,
  });

  @override
  Widget build(BuildContext context) {
    // Priority order: recent joins > winner > friends
    if (recentJoins != null && recentJoins! > 0) {
      return _buildRecentJoins();
    } else if (recentWinner != null && recentWinner!.isNotEmpty) {
      return _buildRecentWinner();
    } else if (friendsActive != null && friendsActive! > 0) {
      return _buildFriendsActive();
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildRecentJoins() {
    final timeText = _getTimeWindowText();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up,
            color: Colors.green,
            size: 14,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: '$recentJoins',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: locale == 'en' 
                ? 'joined $timeText' 
                : 'انضموا $timeText',
            fontSize: 11,
            color: Colors.white.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentWinner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withOpacity(0.8),
            Colors.orange.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: TextWidget(
              title: recentWinner!,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: locale == 'en' ? 'won!' : 'فاز!',
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsActive() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.cyan.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: '$friendsActive',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: locale == 'en' 
                ? (friendsActive! == 1 ? 'friend' : 'friends')
                : (friendsActive! == 1 ? 'صديق' : 'أصدقاء'),
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
          const SizedBox(width: 2),
          TextWidget(
            title: locale == 'en' ? 'playing' : 'يلعب',
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  String _getTimeWindowText() {
    if (timeWindow == null) {
      return locale == 'en' ? 'recently' : 'مؤخراً';
    }
    
    final minutes = timeWindow!.inMinutes;
    if (minutes < 60) {
      return locale == 'en' ? 'in ${minutes}m' : 'في ${minutes}د';
    }
    
    final hours = timeWindow!.inHours;
    return locale == 'en' ? 'in ${hours}h' : 'في ${hours}س';
  }
}
