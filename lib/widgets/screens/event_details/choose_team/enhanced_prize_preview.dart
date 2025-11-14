import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class EnhancedPrizePreview extends StatelessWidget {
  final List prizes;
  final String locale;
  final bool isSinglePlayer;
  
  const EnhancedPrizePreview({
    super.key,
    required this.prizes,
    required this.locale,
    this.isSinglePlayer = false,
  });

  int _calculateTotalPrize() {
    return prizes.fold<int>(
      0,
      (sum, prize) => sum + (prize['coins'] as int? ?? 0),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700); // Gold
      case 1:
        return const Color(0xFFC0C0C0); // Silver
      case 2:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.purple;
    }
  }

  IconData _getRankIcon(int index) {
    switch (index) {
      case 0:
        return Icons.emoji_events;
      case 1:
        return Icons.military_tech;
      case 2:
        return Icons.workspace_premium;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrize = _calculateTotalPrize();
    final topPrizes = prizes.take(3).toList();
    
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
        borderRadius: BorderRadius.circular(16),
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
                  Icons.emoji_events,
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
                      title: isSinglePlayer
                          ? (locale == 'en' ? 'Top players win' : 'أفضل اللاعبين يفوزون')
                          : (locale == 'en' ? 'Every winning team player gets' : 'كل لاعب في الفريق الفائز يحصل على'),
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
              // Total Prize Badge
              Container(
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
                    const Coin(width: 16),
                    const SizedBox(width: 4),
                    TextWidget(
                      title: totalPrize.toString(),
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
          
          const SizedBox(height: 16),
          
          // Top 3 Prizes Display
          Row(
            children: topPrizes.asMap().entries.map((entry) {
              final index = entry.key;
              final prize = entry.value;
              final coins = prize['coins'] ?? 0;
              
              return Expanded(
                child: _buildPrizeCard(
                  context,
                  rank: index + 1,
                  coins: coins,
                  color: _getRankColor(index),
                  icon: _getRankIcon(index),
                ),
              );
            }).toList(),
          ),
          
          // More Prizes Indicator
          if (prizes.length > 3) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white.withOpacity(0.7),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: locale == 'en'
                        ? '${prizes.length - 3} more prize tiers'
                        : '${prizes.length - 3} مستوى جوائز إضافي',
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrizeCard(
    BuildContext context, {
    required int rank,
    required int coins,
    required Color color,
    required IconData icon,
  }) {
    final isFirst = rank == 1;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isFirst ? 0 : 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: isFirst ? 2 : 1,
        ),
        boxShadow: isFirst
            ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          // Rank Badge
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.8),
                  color.withOpacity(0.6),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isFirst ? 24 : 20,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Rank Number
          TextWidget(
            title: '#$rank',
            fontSize: isFirst ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: color,
            alwaysEnglish: true,
          ),
          
          const SizedBox(height: 4),
          
          // Coins
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Coin(width: isFirst ? 16 : 14),
              const SizedBox(width: 4),
              Flexible(
                child: TextWidget(
                  title: coins.toString(),
                  fontSize: isFirst ? 15 : 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  alwaysEnglish: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
