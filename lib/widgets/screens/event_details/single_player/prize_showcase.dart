import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PrizeShowcase extends StatelessWidget {
  final List prizes;
  final int userRank;
  final String locale;
  
  const PrizeShowcase({
    super.key,
    required this.prizes,
    required this.userRank,
    required this.locale,
  });

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      case 4:
        return Colors.purple;
      case 5:
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  IconData _getRankIcon(int rank) {
    switch (rank) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.military_tech;
      case 3:
        return Icons.workspace_premium;
      case 4:
      case 5:
        return Icons.star;
      default:
        return Icons.card_giftcard;
    }
  }

  String _getRankLabel(int rank) {
    if (locale == 'en') {
      switch (rank) {
        case 1:
          return '1ST PLACE';
        case 2:
          return '2ND PLACE';
        case 3:
          return '3RD PLACE';
        case 4:
          return '4TH PLACE';
        case 5:
          return '5TH PLACE';
        default:
          return '${rank}TH PLACE';
      }
    } else {
      return 'المركز $rank';
    }
  }

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
                child: Icon(
                  Icons.card_giftcard,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: locale == 'en' ? 'PRIZE POOL' : 'جوائز المسابقة',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      title: locale == 'en'
                          ? 'Top 5 players win prizes'
                          : 'أفضل 5 لاعبين يفوزون بجوائز',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Prize Grid
          ...prizes.asMap().entries.map((entry) {
            final rank = entry.key + 1;
            final prize = entry.value;
            final coins = prize['coins'] ?? 0;
            final isUserPrize = userRank == rank;
            
            return _buildPrizeCard(
              context,
              rank: rank,
              coins: coins,
              isUserPrize: isUserPrize,
            );
          }),
          
          // Total Prize Pool Summary
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.pink.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.purple.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    TextWidget(
                      title: locale == 'en' ? 'Total Prize Pool' : 'مجموع الجوائز',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Coin(width: 22),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: _calculateTotalPrize().toString(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      alwaysEnglish: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeCard(
    BuildContext context, {
    required int rank,
    required int coins,
    required bool isUserPrize,
  }) {
    final rankColor = _getRankColor(rank);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: isUserPrize
            ? LinearGradient(
                colors: [
                  rankColor.withOpacity(0.4),
                  rankColor.withOpacity(0.2),
                ],
              )
            : null,
        color: isUserPrize ? null : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isUserPrize 
              ? rankColor.withOpacity(0.8)
              : Colors.white.withOpacity(0.1),
          width: isUserPrize ? 2 : 1,
        ),
        boxShadow: isUserPrize
            ? [
                BoxShadow(
                  color: rankColor.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Rank Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  rankColor.withOpacity(0.6),
                  rankColor.withOpacity(0.4),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: isUserPrize
                  ? [
                      BoxShadow(
                        color: rankColor.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    _getRankIcon(rank),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                if (rank <= 3)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: rankColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: TextWidget(
                        title: rank.toString(),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alwaysEnglish: true,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Rank Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: _getRankLabel(rank),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isUserPrize ? rankColor : Colors.white,
                  letterSpacing: 0.5,
                ),
                if (isUserPrize) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: rankColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: rankColor.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 10,
                        ),
                        const SizedBox(width: 4),
                        TextWidget(
                          title: locale == 'en' ? 'YOUR PRIZE' : 'جائزتك',
                          fontSize: 9,
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
          
          // Prize Amount
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber.withOpacity(0.3),
                  Colors.orange.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.amber.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                const Coin(width: 18),
                const SizedBox(width: 6),
                TextWidget(
                  title: coins.toString(),
                  fontSize: 16,
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

  int _calculateTotalPrize() {
    return prizes.fold<int>(
      0,
      (sum, prize) => sum + (prize['coins'] as int? ?? 0),
    );
  }
}
