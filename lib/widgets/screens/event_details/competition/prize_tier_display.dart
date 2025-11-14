import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PrizeTierDisplay extends StatelessWidget {
  final List<PrizeTier> tiers;
  final int currentUserPosition;
  final String locale;
  
  const PrizeTierDisplay({
    super.key,
    required this.tiers,
    required this.currentUserPosition,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber.withOpacity(0.2),
            Colors.orange.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.amber.withOpacity(0.3),
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
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: locale == 'en' ? 'PRIZE TIERS' : 'مستويات الجوائز',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Prize Tiers
          ...tiers.map((tier) => _buildTierCard(
            context,
            tier: tier,
          )),
        ],
      ),
    );
  }

  Widget _buildTierCard(
    BuildContext context, {
    required PrizeTier tier,
  }) {
    final isUserInTier = currentUserPosition >= tier.rankStart && 
                         currentUserPosition <= tier.rankEnd;
    final tierColor = _getTierColor(tier.tierLevel);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: isUserInTier
            ? LinearGradient(
                colors: [
                  tierColor.withOpacity(0.3),
                  tierColor.withOpacity(0.1),
                ],
              )
            : null,
        color: isUserInTier ? null : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUserInTier 
              ? tierColor.withOpacity(0.6)
              : Colors.grey.withOpacity(0.3),
          width: isUserInTier ? 2 : 1,
        ),
        boxShadow: isUserInTier
            ? [
                BoxShadow(
                  color: tierColor.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          // Tier Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tierColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                // Trophy Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        tierColor.withOpacity(0.5),
                        tierColor.withOpacity(0.3),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getTierIcon(tier.tierLevel),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Tier Name and Rank Range
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            title: tier.tierName,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          if (isUserInTier) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: tierColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: TextWidget(
                                title: locale == 'en' ? 'YOU' : 'أنت',
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        title: tier.rankStart == tier.rankEnd
                            ? '#${tier.rankStart}'
                            : '#${tier.rankStart} - #${tier.rankEnd}',
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        alwaysEnglish: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Rewards Section
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Primary Rewards
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tier.rewards.map((reward) => _buildRewardChip(
                    context,
                    reward: reward,
                    tierColor: tierColor,
                  )).toList(),
                ),
                
                // Special Badge if available
                if (tier.specialBadge != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.3),
                          Colors.pink.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.purple.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Colors.pink,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        TextWidget(
                          title: tier.specialBadge!,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardChip(
    BuildContext context, {
    required PrizeReward reward,
    required Color tierColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: tierColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            reward.icon,
            color: reward.color,
            size: 16,
          ),
          const SizedBox(width: 6),
          TextWidget(
            title: reward.value,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: reward.label,
            fontSize: 11,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Color _getTierColor(int level) {
    switch (level) {
      case 1: // Gold
        return const Color(0xFFFFD700);
      case 2: // Silver
        return const Color(0xFFC0C0C0);
      case 3: // Bronze
        return const Color(0xFFCD7F32);
      case 4: // Diamond
        return const Color(0xFF00CED1);
      default:
        return Colors.grey;
    }
  }

  IconData _getTierIcon(int level) {
    switch (level) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.military_tech;
      case 3:
        return Icons.workspace_premium;
      case 4:
        return Icons.diamond;
      default:
        return Icons.star;
    }
  }
}

class PrizeTier {
  final String tierName;
  final int tierLevel; // 1 = Gold, 2 = Silver, 3 = Bronze, 4 = Diamond, etc.
  final int rankStart;
  final int rankEnd;
  final List<PrizeReward> rewards;
  final String? specialBadge;
  
  const PrizeTier({
    required this.tierName,
    required this.tierLevel,
    required this.rankStart,
    required this.rankEnd,
    required this.rewards,
    this.specialBadge,
  });
}

class PrizeReward {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  
  const PrizeReward({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
}
