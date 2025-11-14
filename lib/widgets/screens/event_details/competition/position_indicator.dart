import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PositionIndicator extends StatelessWidget {
  final int currentPosition;
  final int previousPosition;
  final int? pointsToNextRank;
  final String locale;
  final bool showTrend;
  
  const PositionIndicator({
    super.key,
    required this.currentPosition,
    required this.previousPosition,
    this.pointsToNextRank,
    required this.locale,
    this.showTrend = true,
  });

  int _getPositionChange() {
    return previousPosition - currentPosition;
  }

  Color _getTrendColor(int change) {
    if (change > 0) return Colors.green;
    if (change < 0) return Colors.red;
    return Colors.grey;
  }

  IconData _getTrendIcon(int change) {
    if (change > 0) return Icons.trending_up;
    if (change < 0) return Icons.trending_down;
    return Icons.trending_flat;
  }

  String _getPositionSuffix(int position) {
    if (locale != 'en') return '';
    
    if (position % 100 >= 11 && position % 100 <= 13) {
      return 'th';
    }
    
    switch (position % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    final positionChange = _getPositionChange();
    final trendColor = _getTrendColor(positionChange);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            trendColor.withOpacity(0.3),
            trendColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: trendColor.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: trendColor.withOpacity(0.2),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Position Display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rank Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      trendColor.withOpacity(0.5),
                      trendColor.withOpacity(0.3),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: trendColor.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Position Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title: '#',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.6),
                        alwaysEnglish: true,
                      ),
                      TextWidget(
                        title: currentPosition.toString(),
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alwaysEnglish: true,
                      ),
                      if (locale == 'en')
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextWidget(
                            title: _getPositionSuffix(currentPosition),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.7),
                            alwaysEnglish: true,
                          ),
                        ),
                    ],
                  ),
                  TextWidget(
                    title: locale == 'en' ? 'YOUR RANK' : 'ترتيبك',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 2,
                  ),
                ],
              ),
            ],
          ),
          
          // Trend Indicator
          if (showTrend && positionChange != 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: trendColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: trendColor.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getTrendIcon(positionChange),
                    color: trendColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: positionChange > 0
                        ? (locale == 'en' 
                            ? 'Up ${positionChange.abs()} positions'
                            : 'تقدم ${positionChange.abs()} مراكز')
                        : (locale == 'en'
                            ? 'Down ${positionChange.abs()} positions'
                            : 'تراجع ${positionChange.abs()} مراكز'),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: trendColor,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: trendColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextWidget(
                      title: '${positionChange > 0 ? '+' : ''}$positionChange',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      alwaysEnglish: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Points to Next Rank
          if (pointsToNextRank != null && pointsToNextRank! > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stars,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: locale == 'en'
                        ? '$pointsToNextRank points to rank ${currentPosition - 1}'
                        : '$pointsToNextRank نقطة للوصول إلى المركز ${currentPosition - 1}',
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.withOpacity(0.5),
                          Colors.teal.withOpacity(0.5),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Motivational Message
          const SizedBox(height: 12),
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
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 6),
                TextWidget(
                  title: _getMotivationalMessage(),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage() {
    final positionChange = _getPositionChange();
    
    if (positionChange > 0) {
      return locale == 'en' ? 'Keep climbing!' : 'استمر في التقدم!';
    } else if (positionChange < 0) {
      return locale == 'en' ? 'Fight back!' : 'لا تستسلم!';
    } else {
      return locale == 'en' ? 'Push harder!' : 'ابذل المزيد!';
    }
  }
}
