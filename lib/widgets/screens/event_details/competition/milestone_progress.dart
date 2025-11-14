import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class MilestoneProgress extends StatelessWidget {
  final List<Milestone> milestones;
  final int currentPoints;
  final String locale;
  
  const MilestoneProgress({
    super.key,
    required this.milestones,
    required this.currentPoints,
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
            Colors.indigo.withOpacity(0.2),
            Colors.indigo.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.indigo.withOpacity(0.3),
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
                      Colors.indigo.withOpacity(0.3),
                      Colors.purple.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.military_tech,
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
                      title: locale == 'en' ? 'MILESTONES' : 'الإنجازات',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      title: locale == 'en' 
                          ? 'Unlock rewards as you progress'
                          : 'افتح المكافآت مع تقدمك',
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Milestones List
          ...milestones.map((milestone) => _buildMilestoneItem(
            context,
            milestone: milestone,
          )),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(
    BuildContext context, {
    required Milestone milestone,
  }) {
    final isUnlocked = currentPoints >= milestone.pointsRequired;
    final progress = currentPoints >= milestone.pointsRequired 
        ? 1.0 
        : currentPoints / milestone.pointsRequired;
    final pointsRemaining = milestone.pointsRequired - currentPoints;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? Colors.green.withOpacity(0.1)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isUnlocked
              ? Colors.green.withOpacity(0.5)
              : Colors.indigo.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Milestone Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: isUnlocked
                      ? LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.5),
                            Colors.teal.withOpacity(0.5),
                          ],
                        )
                      : LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.grey.withOpacity(0.1),
                          ],
                        ),
                  shape: BoxShape.circle,
                  boxShadow: isUnlocked
                      ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  isUnlocked ? Icons.check_circle : milestone.icon,
                  color: isUnlocked ? Colors.white : Colors.grey,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Milestone Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            title: milestone.title,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? Colors.green : Colors.white,
                          ),
                        ),
                        if (isUnlocked)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                const SizedBox(width: 2),
                                TextWidget(
                                  title: locale == 'en' ? 'UNLOCKED' : 'مفتوح',
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: Colors.amber,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        TextWidget(
                          title: '${milestone.pointsRequired}',
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.7),
                          alwaysEnglish: true,
                        ),
                        const SizedBox(width: 4),
                        TextWidget(
                          title: locale == 'en' ? 'points' : 'نقطة',
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Reward Display
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      milestone.rewardIcon,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                      title: milestone.rewardValue,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      alwaysEnglish: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Progress Bar
          if (!isUnlocked) ...[
            const SizedBox(height: 12),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo,
                              Colors.purple,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: '${(progress * 100).toStringAsFixed(0)}%',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.5),
                      alwaysEnglish: true,
                    ),
                    TextWidget(
                      title: locale == 'en'
                          ? '$pointsRemaining pts to go'
                          : 'باقي $pointsRemaining نقطة',
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class Milestone {
  final String title;
  final IconData icon;
  final int pointsRequired;
  final IconData rewardIcon;
  final String rewardValue; // e.g., "100", "x2", "50%"
  
  const Milestone({
    required this.title,
    required this.icon,
    required this.pointsRequired,
    required this.rewardIcon,
    required this.rewardValue,
  });
}
