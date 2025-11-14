import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PerformanceComparison extends StatelessWidget {
  final int userPoints;
  final int userWins;
  final double averagePoints;
  final double averageWins;
  final int topPlayerPoints;
  final int topPlayerWins;
  final String locale;
  
  const PerformanceComparison({
    super.key,
    required this.userPoints,
    required this.userWins,
    required this.averagePoints,
    required this.averageWins,
    required this.topPlayerPoints,
    required this.topPlayerWins,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.teal.withOpacity(0.2),
            Colors.cyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.teal.withOpacity(0.3),
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
                      Colors.teal.withOpacity(0.3),
                      Colors.cyan.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
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
                      title: locale == 'en' 
                          ? 'PERFORMANCE COMPARISON'
                          : 'مقارنة الأداء',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      title: locale == 'en'
                          ? 'See how you stack up'
                          : 'شاهد ترتيبك مع الآخرين',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Points Comparison
          _buildComparisonSection(
            context,
            title: locale == 'en' ? 'POINTS' : 'النقاط',
            icon: Icons.stars,
            iconColor: Colors.amber,
            userValue: userPoints.toDouble(),
            avgValue: averagePoints,
            topValue: topPlayerPoints.toDouble(),
          ),
          
          const SizedBox(height: 20),
          
          // Wins Comparison
          _buildComparisonSection(
            context,
            title: locale == 'en' ? 'WINS' : 'الانتصارات',
            icon: Icons.emoji_events,
            iconColor: Colors.yellow,
            userValue: userWins.toDouble(),
            avgValue: averageWins,
            topValue: topPlayerWins.toDouble(),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required double userValue,
    required double avgValue,
    required double topValue,
  }) {
    final maxValue = topValue;
    final userPercentage = userValue / maxValue;
    final avgPercentage = avgValue / maxValue;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
            const SizedBox(width: 8),
            TextWidget(
              title: title,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Top Player Bar (Reference)
        _buildComparisonBar(
          context,
          label: locale == 'en' ? 'Top Player' : 'أفضل لاعب',
          value: topValue.toInt(),
          percentage: 1.0,
          color: const Color(0xFFFFD700), // Gold
          isReference: true,
        ),
        
        const SizedBox(height: 8),
        
        // User Bar
        _buildComparisonBar(
          context,
          label: locale == 'en' ? 'You' : 'أنت',
          value: userValue.toInt(),
          percentage: userPercentage,
          color: Colors.cyan,
          isUser: true,
        ),
        
        const SizedBox(height: 8),
        
        // Average Bar
        _buildComparisonBar(
          context,
          label: locale == 'en' ? 'Average' : 'المتوسط',
          value: avgValue.toInt(),
          percentage: avgPercentage,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildComparisonBar(
    BuildContext context, {
    required String label,
    required int value,
    required double percentage,
    required Color color,
    bool isUser = false,
    bool isReference = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Row(
                children: [
                  TextWidget(
                    title: label,
                    fontSize: 11,
                    color: isUser 
                        ? Colors.cyan 
                        : Colors.white.withOpacity(0.7),
                    fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                  ),
                  if (isUser) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.cyan,
                      size: 14,
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  // Background
                  Container(
                    height: isUser ? 24 : 20,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Progress Bar
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: isUser ? 24 : 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color,
                            color.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: isUser || isReference
                            ? [
                                BoxShadow(
                                  color: color.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                  // Value Label
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextWidget(
                          title: value.toString(),
                          fontSize: isUser ? 12 : 11,
                          fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                          color: Colors.white,
                          alwaysEnglish: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Percentage Badge
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: TextWidget(
                  title: '${(percentage * 100).toInt()}%',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color,
                  alwaysEnglish: true,
                ),
              ),
            ),
          ],
        ),
        
        // Comparison indicator for user
        if (isUser && percentage < 1.0) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: Colors.cyan.withOpacity(0.6),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextWidget(
                    title: locale == 'en'
                        ? '${((1 - percentage) * 100).toInt()}% behind leader'
                        : 'خلف المتصدر بـ ${((1 - percentage) * 100).toInt()}%',
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
