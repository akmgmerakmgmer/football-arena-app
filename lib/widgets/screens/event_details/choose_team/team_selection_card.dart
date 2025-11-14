import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class TeamSelectionCard extends StatelessWidget {
  final String teamId;
  final String teamName;
  final int currentPlayers;
  final bool isSelected;
  final VoidCallback onTap;
  final String locale;
  final int sideIndex; // 0 or 1 for different styling
  final bool isPopular;
  
  const TeamSelectionCard({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.currentPlayers,
    required this.isSelected,
    required this.onTap,
    required this.locale,
    required this.sideIndex,
    this.isPopular = false,
  });

  Color _getTeamColor() {
    // Support multiple teams with different colors
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
    return colors[sideIndex % colors.length];
  }

  IconData _getTeamIcon() {
    // Support multiple teams with different icons
    final icons = [
      Icons.shield,
      Icons.sports_soccer,
      Icons.sports_basketball,
      Icons.sports_football,
      Icons.sports_baseball,
      Icons.sports_tennis,
      Icons.sports_hockey,
      Icons.sports_volleyball,
    ];
    return icons[sideIndex % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final teamColor = _getTeamColor();
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    teamColor.withOpacity(0.4),
                    teamColor.withOpacity(0.2),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? teamColor.withOpacity(0.8)
                : Colors.white.withOpacity(0.2),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: teamColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Team Icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        teamColor.withOpacity(0.6),
                        teamColor.withOpacity(0.4),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: teamColor.withOpacity(0.5),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    _getTeamIcon(),
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Team Name and Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextWidget(
                              title: teamName,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? teamColor : Colors.white,
                            ),
                          ),
                          if (isPopular) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.amber.withOpacity(0.8),
                                    Colors.orange.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
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
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  TextWidget(
                                    title: locale == 'en' ? 'POPULAR' : 'رائج',
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
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.white.withOpacity(0.7),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          TextWidget(
                            title: '$currentPlayers',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                            alwaysEnglish: true,
                          ),
                          const SizedBox(width: 4),
                          TextWidget(
                            title: locale == 'en' ? 'players' : 'لاعب',
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Selection Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? teamColor
                        : Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected 
                          ? Colors.white 
                          : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              ],
            ),
            
            // Win Chance Indicator (mock data - replace with real stats)
            if (isSelected) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: teamColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextWidget(
                        title: locale == 'en'
                            ? 'You\'re joining this team!'
                            : 'أنت تنضم لهذا الفريق!',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.5),
                            Colors.teal.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
