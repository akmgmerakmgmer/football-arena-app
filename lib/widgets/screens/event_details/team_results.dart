import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_title.dart';
import 'package:in_zone_app/widgets/screens/event_details/play_event_button.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_event_data.dart';
import 'package:in_zone_app/widgets/screens/event_details/team_event_data.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/event_countdown.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/live_competition_stats.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/position_indicator.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/rival_players_card.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/milestone_progress.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/prize_tier_display.dart';
import 'package:in_zone_app/widgets/screens/event_details/competition/performance_comparison.dart';
import 'package:provider/provider.dart';

class TeamResults extends StatelessWidget {
  final Map event;
  final String locale;
  const TeamResults({super.key, required this.event, required this.locale});

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    int userScore = user['events'] != null
        ? (user['events'].firstWhere(
              (e) => e['id'] == event['_id'],
              orElse: () => null,
            )?['points'] ??
            0)
        : 0;
    
    // Get user's event data for competition stats
    Map? userEventData;
    if (user['events'] != null) {
      userEventData = user['events'].firstWhere(
        (e) => e['id'] == event['_id'],
        orElse: () => null,
      );
    }
    
    // Mock data for competition features - replace with real data from API
    final int currentUserRank = userEventData?['rank'] ?? 50;
    final int previousUserRank = userEventData?['previousRank'] ?? 55;
    final int totalPlayers = event['totalPlayers'] ?? 1000;
    final DateTime eventEndTime = event['endDate'] != null 
        ? DateTime.parse(event['endDate']) 
        : DateTime.now().add(const Duration(hours: 24));
    
    return PagesAssetBackground(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventImage(
            event: event,
            locale: locale,
          ),
          const SizedBox(
            height: 16,
          ),
          EventTitle(event: event, locale: locale),
          const SizedBox(
            height: 12,
          ),
          PlayEventButton(event: event, user: user),
          
          // Competition Features Section
          if (!event['isSinglePlayer']) ...[
            const SizedBox(height: 24),
            
            // Event Countdown
            EventCountdown(
              endDate: eventEndTime,
              locale: locale,
            ),
            
            const SizedBox(height: 16),
            
            // Position Indicator
            PositionIndicator(
              currentPosition: currentUserRank,
              previousPosition: previousUserRank,
              pointsToNextRank: 150,
              locale: locale,
            ),
            
            const SizedBox(height: 16),
            
            // Live Competition Stats
            LiveCompetitionStats(
              totalPlayers: totalPlayers,
              currentPosition: currentUserRank,
              previousPosition: previousUserRank,
              locale: locale,
              intensityLevel: totalPlayers > 500 ? 'HIGH' : 'MEDIUM',
            ),
            
            const SizedBox(height: 16),
            
            // Rival Players
            RivalPlayersCard(
              playerAbove: RivalPlayer(
                rank: currentUserRank - 1,
                username: 'TopPlayer123',
                avatarUrl: 'https://i.pravatar.cc/150?img=12',
                points: userScore + 200,
                wins: 15,
                pointsDifference: 200,
              ),
              playerBelow: RivalPlayer(
                rank: currentUserRank + 1,
                username: 'Challenger99',
                avatarUrl: 'https://i.pravatar.cc/150?img=15',
                points: userScore - 50,
                wins: 10,
                pointsDifference: -50,
              ),
              locale: locale,
            ),
            
            const SizedBox(height: 16),
            
            // Milestones
            MilestoneProgress(
              currentPoints: userScore,
              locale: locale,
              milestones: [
                Milestone(
                  title: locale == 'en' ? 'Bronze Badge' : 'شارة برونزية',
                  icon: Icons.workspace_premium,
                  pointsRequired: 500,
                  rewardIcon: Icons.stars,
                  rewardValue: '100',
                ),
                Milestone(
                  title: locale == 'en' ? 'Silver Badge' : 'شارة فضية',
                  icon: Icons.military_tech,
                  pointsRequired: 1000,
                  rewardIcon: Icons.stars,
                  rewardValue: '250',
                ),
                Milestone(
                  title: locale == 'en' ? 'Gold Badge' : 'شارة ذهبية',
                  icon: Icons.emoji_events,
                  pointsRequired: 2000,
                  rewardIcon: Icons.stars,
                  rewardValue: '500',
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Prize Tiers
            PrizeTierDisplay(
              currentUserPosition: currentUserRank,
              locale: locale,
              tiers: [
                PrizeTier(
                  tierName: locale == 'en' ? '1st Place' : 'المركز الأول',
                  tierLevel: 1,
                  rankStart: 1,
                  rankEnd: 1,
                  specialBadge: locale == 'en' ? 'Champion Badge' : 'شارة البطل',
                  rewards: [
                    PrizeReward(
                      icon: Icons.stars,
                      value: '10,000',
                      label: locale == 'en' ? 'coins' : 'عملة',
                      color: Colors.amber,
                    ),
                    PrizeReward(
                      icon: Icons.card_giftcard,
                      value: '5',
                      label: locale == 'en' ? 'perks' : 'مزايا',
                      color: Colors.purple,
                    ),
                  ],
                ),
                PrizeTier(
                  tierName: locale == 'en' ? 'Top 10' : 'أفضل 10',
                  tierLevel: 2,
                  rankStart: 2,
                  rankEnd: 10,
                  rewards: [
                    PrizeReward(
                      icon: Icons.stars,
                      value: '5,000',
                      label: locale == 'en' ? 'coins' : 'عملة',
                      color: Colors.amber,
                    ),
                    PrizeReward(
                      icon: Icons.card_giftcard,
                      value: '3',
                      label: locale == 'en' ? 'perks' : 'مزايا',
                      color: Colors.purple,
                    ),
                  ],
                ),
                PrizeTier(
                  tierName: locale == 'en' ? 'Top 50' : 'أفضل 50',
                  tierLevel: 3,
                  rankStart: 11,
                  rankEnd: 50,
                  rewards: [
                    PrizeReward(
                      icon: Icons.stars,
                      value: '2,000',
                      label: locale == 'en' ? 'coins' : 'عملة',
                      color: Colors.amber,
                    ),
                    PrizeReward(
                      icon: Icons.card_giftcard,
                      value: '1',
                      label: locale == 'en' ? 'perk' : 'ميزة',
                      color: Colors.purple,
                    ),
                  ],
                ),
                PrizeTier(
                  tierName: locale == 'en' ? 'Top 100' : 'أفضل 100',
                  tierLevel: 4,
                  rankStart: 51,
                  rankEnd: 100,
                  rewards: [
                    PrizeReward(
                      icon: Icons.stars,
                      value: '500',
                      label: locale == 'en' ? 'coins' : 'عملة',
                      color: Colors.amber,
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Performance Comparison
            PerformanceComparison(
              userPoints: userScore,
              userWins: userEventData?['wins'] ?? 5,
              averagePoints: userScore * 0.7,
              averageWins: 3.5,
              topPlayerPoints: userScore * 2,
              topPlayerWins: 20,
              locale: locale,
            ),
            
            const SizedBox(height: 24),
          ],
          
          event['isSinglePlayer']
              ? const SizedBox(
                  height: 24,
                )
              : Container(),
          event['isSinglePlayer'] == true
              ? SingleEventData(
                  event: event,
                  locale: locale,
                  userId: user['_id'],
                )
              : TeamEventData(event: event, currentUser: user, locale: locale)
        ],
      ),
    );
  }
}
