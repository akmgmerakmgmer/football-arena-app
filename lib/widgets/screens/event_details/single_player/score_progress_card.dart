import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class ScoreProgressCard extends StatelessWidget {
  final int currentScore;
  final int? nextRankScore;
  final int currentRank;
  final String locale;
  final bool canImprove;

  const ScoreProgressCard({
    super.key,
    required this.currentScore,
    this.nextRankScore,
    required this.currentRank,
    required this.locale,
    this.canImprove = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasNextRank = nextRankScore != null && nextRankScore! > currentScore;
    final scoreGap = hasNextRank ? nextRankScore! - currentScore : 0;
    final progress =
        hasNextRank ? (currentScore / nextRankScore!).clamp(0.0, 1.0) : 1.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyan.withOpacity(0.2),
            Colors.blue.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.cyan.withOpacity(0.3),
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
                      Colors.cyan.withOpacity(0.3),
                      Colors.blue.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.cyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: locale == 'en' ? 'SCORE PROGRESS' : 'تقدم النتيجة',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      title: hasNextRank
                          ? (locale == 'en'
                              ? 'Aim for the top spot!'
                              : 'اهدف للمركز الأول!')
                          : (locale == 'en'
                              ? 'You\'re at the top!'
                              : 'أنت في القمة!'),
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (hasNextRank) ...[
            const SizedBox(height: 20),

            // Score comparison
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildScoreBox(
                  context,
                  label: locale == 'en' ? 'Your Score' : 'نتيجتك',
                  score: currentScore,
                  color: Colors.cyan,
                  icon: Icons.person,
                ),

                // Arrow with gap
                Column(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.amber,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.5),
                        ),
                      ),
                      child: TextWidget(
                        title: '+$scoreGap',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        alwaysEnglish: true,
                      ),
                    ),
                  ],
                ),

                _buildScoreBox(
                  context,
                  label: locale == 'en' ? '1st Place' : 'المركز الأول',
                  score: nextRankScore!,
                  color: Colors.green,
                  icon: Icons.emoji_events,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Progress Bar
            Column(
              children: [
                Stack(
                  children: [
                    // Background
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    // Progress
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.cyan,
                              Colors.blue,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: '${(progress * 100).toStringAsFixed(1)}%',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      alwaysEnglish: true,
                    ),
                    TextWidget(
                      title: locale == 'en'
                          ? '$scoreGap points to go'
                          : '$scoreGap نقطة متبقية',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),

            // Motivational message
            if (canImprove) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.2),
                      Colors.teal.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextWidget(
                        title: _getMotivationalMessage(scoreGap),
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ] else ...[
            const SizedBox(height: 16),
            // At the top message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.3),
                    const Color(0xFFFFA500).withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFD700),
                          Color(0xFFFFA500),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: locale == 'en'
                              ? '🎉 You\'re #1!'
                              : '🎉 أنت الأول!',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        TextWidget(
                          title: locale == 'en'
                              ? 'Defend your position!'
                              : 'دافع عن مركزك!',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreBox(
    BuildContext context, {
    required String label,
    required int score,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 6),
          TextWidget(
            title: score.toString(),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: label,
            fontSize: 10,
            color: Colors.white.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage(int gap) {
    if (locale == 'en') {
      if (gap <= 1) return '💪 Just 1 point away! You can do it!';
      if (gap <= 3) return '🔥 So close! One more try!';
      if (gap <= 5) return '⚡ Almost there! Keep pushing!';
      return '🎯 You can reach it! Keep playing!';
    } else {
      if (gap <= 1) return '💪 نقطة واحدة فقط! يمكنك فعلها!';
      if (gap <= 3) return '🔥 قريب جدا! محاولة أخرى!';
      if (gap <= 5) return '⚡ تقريبا هناك! استمر!';
      return '🎯 يمكنك الوصول! استمر في اللعب!';
    }
  }
}
