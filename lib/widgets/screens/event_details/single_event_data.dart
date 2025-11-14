import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_player/single_player_position_card.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_player/score_progress_card.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_player/prize_showcase.dart';

class SingleEventData extends StatelessWidget {
  final Map event;
  final String locale;
  final String userId;
  const SingleEventData({
    super.key,
    required this.event,
    required this.locale,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final rankings = event['rankings'] ?? [];
    final prizes = event['prizes'] ?? [];
    
    if (rankings.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // Show prizes even if no rankings yet
              if (prizes.isNotEmpty) ...[
                PrizeShowcase(
                  prizes: prizes,
                  userRank: 0, // Not ranked yet
                  locale: locale,
                ),
                const SizedBox(height: 20),
              ],
              TextWidget(
                title: AppLocalizations.of(context)!.noRankedUsers,
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.3),
                      Colors.cyan.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    TextWidget(
                      title: locale == 'en'
                          ? 'Play now to be the first!'
                          : 'العب الآن لتكون الأول!',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // Find user's rank and score
    int userRank = 0;
    int userScore = 0;
    for (int i = 0; i < rankings.length; i++) {
      if (rankings[i]['userId']['_id'].toString() == userId.toString()) {
        userRank = i + 1;
        userScore = rankings[i]['points'] ?? 0;
        break;
      }
    }
    
    // Get best rank score (1st place) for progress tracking
    int? nextRankScore;
    if (userRank > 1 && rankings.isNotEmpty) {
      nextRankScore = rankings[0]['points']; // Always aim for 1st place
    }
    
    final totalPlayers = rankings.length;
    final isInTop5 = userRank > 0 && userRank <= 5;
    
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // User's Position Card (if user is ranked)
          if (userRank > 0) ...[
            SinglePlayerPositionCard(
              userRank: userRank,
              userScore: userScore,
              totalPlayers: totalPlayers,
              locale: locale,
              isInTop5: isInTop5,
            ),
            const SizedBox(height: 16),
          ],
          
          // Score Progress Card (if user is ranked and not #1)
          if (userRank > 1 && nextRankScore != null) ...[
            ScoreProgressCard(
              currentScore: userScore,
              nextRankScore: nextRankScore,
              currentRank: userRank,
              locale: locale,
              canImprove: true,
            ),
            const SizedBox(height: 16),
          ],
          
          // Top Players Leaderboard
          // TopPlayersLeaderboard(
          //   rankings: rankings,
          //   currentUserId: userId,
          //   prizes: prizes,
          //   locale: locale,
          // ),
          
          const SizedBox(height: 16),
          
          // Prize Showcase
          if (prizes.isNotEmpty)
            PrizeShowcase(
              prizes: prizes,
              userRank: userRank,
              locale: locale,
            ),
        ],
      ),
    );
  }
}
