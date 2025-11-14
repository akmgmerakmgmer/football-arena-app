import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/live_stats_badge.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/match_rewards_preview.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/urgency_timer.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/social_proof_badge.dart';

class ContainerBody extends StatelessWidget {
  final String title;
  final String desc;
  final String locale;
  final IconData? titleIcon;
  final int? playersOnline;
  final int? matchesStarting;
  final int? friendsPlaying;
  final int? rewardCoins;
  final String? xpMultiplier;
  final String? quickMatchPromise;
  final DateTime? urgencyEndTime;
  final int? recentJoins;
  final String? recentWinner;
  
  const ContainerBody({
    super.key,
    required this.title,
    required this.desc,
    required this.locale,
    this.titleIcon,
    this.playersOnline,
    this.matchesStarting,
    this.friendsPlaying,
    this.rewardCoins,
    this.xpMultiplier,
    this.quickMatchPromise,
    this.urgencyEndTime,
    this.recentJoins,
    this.recentWinner,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top badges row
            if (playersOnline != null || matchesStarting != null || friendsPlaying != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: LiveStatsBadge(
                  playersOnline: playersOnline,
                  matchesStarting: matchesStarting,
                  friendsPlaying: friendsPlaying,
                  locale: locale,
                ),
              ),
            
            // Title with icon and gradient
            Row(
              children: [
                if (titleIcon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.8),
                          Theme.of(context).primaryColor.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      titleIcon,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                    child: TextWidget(
                      title: title,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Description with better contrast
            TextWidget(
              title: desc,
              color: Colors.white.withOpacity(0.95),
              fontWeight: FontWeight.w600,
              fontSize: 13,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 10),
            
            // Bottom badges row
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                if (rewardCoins != null || xpMultiplier != null)
                  MatchRewardsPreview(
                    coins: rewardCoins,
                    xpMultiplier: xpMultiplier,
                    locale: locale,
                    showGlow: true,
                  ),
                
                if (quickMatchPromise != null || urgencyEndTime != null)
                  UrgencyTimer(
                    quickMatchPromise: quickMatchPromise,
                    endTime: urgencyEndTime,
                    locale: locale,
                  ),
                
                if (recentJoins != null || recentWinner != null)
                  SocialProofBadge(
                    recentJoins: recentJoins,
                    recentWinner: recentWinner,
                    locale: locale,
                    timeWindow: const Duration(minutes: 5),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
