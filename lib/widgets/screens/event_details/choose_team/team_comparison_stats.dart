import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class TeamComparisonStats extends StatelessWidget {
  final List sides;
  final String locale;
  
  const TeamComparisonStats({
    super.key,
    required this.sides,
    required this.locale,
  });

  int _getTotalPlayers(dynamic side) {
    return side['numberOfPlayers'] ?? 0;
  }

  int _getTotalPoints(dynamic side) {
    return side['points'] ?? 0;
  }

  double _getWinPercentage(dynamic side) {
    // Calculate win percentage based on points
    // You can adjust this logic based on your actual calculation
    final points = side['points'] ?? 0;
    if (points == 0) return 0.0;
    // Mock calculation - replace with actual formula if you have historical data
    return (points / 1000).clamp(0.0, 1.0);
  }

  Color _getTeamColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (sides.isEmpty) return const SizedBox.shrink();
    
    // Calculate total players across all teams
    int totalPlayers = 0;
    List<int> playerCounts = [];
    for (var side in sides) {
      final count = _getTotalPlayers(side);
      playerCounts.add(count);
      totalPlayers += count;
    }
    
    // If only 2 teams, show detailed comparison
    if (sides.length == 2) {
      final side1 = sides[0];
      final side2 = sides[1];
      final side1Players = playerCounts[0];
      final side2Players = playerCounts[1];
      
      final side1Percentage = totalPlayers > 0 ? side1Players / totalPlayers : 0.5;
      final side2Percentage = totalPlayers > 0 ? side2Players / totalPlayers : 0.5;
      
      return _buildTwoTeamComparison(
        context,
        side1,
        side2,
        side1Players,
        side2Players,
        side1Percentage,
        side2Percentage,
      );
    }
    
    // For 3+ teams, show distribution bars
    return _buildMultiTeamComparison(context, playerCounts, totalPlayers);
  }

  Widget _buildTwoTeamComparison(
    BuildContext context,
    dynamic side1,
    dynamic side2,
    int side1Players,
    int side2Players,
    double side1Percentage,
    double side2Percentage,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.withOpacity(0.2),
            Colors.indigo.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.3),
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
                      Colors.deepPurple.withOpacity(0.3),
                      Colors.indigo.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.deepPurple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: locale == 'en' ? 'TEAM COMPARISON' : 'مقارنة الفرق',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Distribution Bar
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      title: locale == 'ar' 
                          ? '${side1['nameAr']}' 
                          : '${side1['nameEn']}',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: 'VS',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.5),
                    alwaysEnglish: true,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextWidget(
                      title: locale == 'ar'
                          ? '${side2['nameAr']}'
                          : '${side2['nameEn']}',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Player Distribution Bar
              Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: side1Percentage,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blue.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
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
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.blue,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: '$side1Players',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        alwaysEnglish: true,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: '(${(side1Percentage * 100).toInt()}%)',
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.7),
                        alwaysEnglish: true,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: '(${(side2Percentage * 100).toInt()}%)',
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.7),
                        alwaysEnglish: true,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: '$side2Players',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        alwaysEnglish: true,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.people,
                        color: Colors.red,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Quick Stats Row - Points Display
          Row(
            children: [
              Expanded(
                child: _buildStatBox(
                  context,
                  label: locale == 'ar' 
                      ? '${side1['nameAr']}' 
                      : '${side1['nameEn']}',
                  value: '${_getTotalPoints(side1)}',
                  subLabel: locale == 'en' ? 'Points' : 'نقاط',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatBox(
                  context,
                  label: locale == 'ar'
                      ? '${side2['nameAr']}'
                      : '${side2['nameEn']}',
                  value: '${_getTotalPoints(side2)}',
                  subLabel: locale == 'en' ? 'Points' : 'نقاط',
                  color: Colors.red,
                ),
              ),
            ],
          ),
          
          // Balanced indicator
          if ((side1Percentage - side2Percentage).abs() < 0.1) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.balance,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: locale == 'en'
                        ? 'Teams are balanced!'
                        : 'الفرق متوازنة!',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMultiTeamComparison(BuildContext context, List<int> playerCounts, int totalPlayers) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.withOpacity(0.2),
            Colors.indigo.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.3),
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
                      Colors.deepPurple.withOpacity(0.3),
                      Colors.indigo.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.groups,
                  color: Colors.deepPurple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: locale == 'en' ? 'TEAM DISTRIBUTION' : 'توزيع الفرق',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Multi-Team Distribution Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 30,
              child: Row(
                children: sides.asMap().entries.map((entry) {
                  final index = entry.key;
                  final players = playerCounts[index];
                  final percentage = totalPlayers > 0 ? players / totalPlayers : 1.0 / sides.length;
                  
                  return Expanded(
                    flex: (percentage * 100).round().clamp(1, 100),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getTeamColor(index),
                            _getTeamColor(index).withOpacity(0.7),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _getTeamColor(index).withOpacity(0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: percentage > 0.08 ? TextWidget(
                        title: '${(percentage * 100).toInt()}%',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alwaysEnglish: true,
                      ) : const SizedBox(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Team Stats Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: sides.length,
            itemBuilder: (context, index) {
              final side = sides[index];
              final players = playerCounts[index];
              final percentage = totalPlayers > 0 ? players / totalPlayers : 1.0 / sides.length;
              
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _getTeamColor(index).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: _getTeamColor(index),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            title: locale == 'ar' 
                                ? '${side['nameAr'] ?? 'فريق ${index + 1}'}'
                                : '${side['nameEn'] ?? 'Team ${index + 1}'}',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _getTeamColor(index),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.white.withOpacity(0.7),
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              TextWidget(
                                title: '$players (${(percentage * 100).toInt()}%)',
                                fontSize: 11,
                                color: Colors.white,
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
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context, {
    required String label,
    required String value,
    required String subLabel,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          TextWidget(
            title: label,
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 6),
          TextWidget(
            title: value,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: subLabel,
            fontSize: 9,
            color: Colors.white.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
