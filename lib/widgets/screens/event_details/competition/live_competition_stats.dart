import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class LiveCompetitionStats extends StatelessWidget {
  final int totalPlayers;
  final int currentPosition;
  final int previousPosition;
  final String locale;
  final String intensityLevel; // 'LOW', 'MEDIUM', 'HIGH'
  
  const LiveCompetitionStats({
    super.key,
    required this.totalPlayers,
    required this.currentPosition,
    required this.previousPosition,
    required this.locale,
    this.intensityLevel = 'MEDIUM',
  });

  String _getIntensityText() {
    if (locale == 'en') {
      switch (intensityLevel) {
        case 'HIGH':
          return 'HIGH';
        case 'LOW':
          return 'LOW';
        default:
          return 'MEDIUM';
      }
    } else {
      switch (intensityLevel) {
        case 'HIGH':
          return 'عالي';
        case 'LOW':
          return 'منخفض';
        default:
          return 'متوسط';
      }
    }
  }

  Color _getIntensityColor() {
    switch (intensityLevel) {
      case 'HIGH':
        return Colors.red;
      case 'LOW':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  int _getPositionChange() {
    return previousPosition - currentPosition;
  }

  @override
  Widget build(BuildContext context) {
    final positionChange = _getPositionChange();
    final intensityColor = _getIntensityColor();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.2),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with live indicator
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextWidget(
                title: locale == 'en' ? 'LIVE COMPETITION' : 'المنافسة المباشرة',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Stats Grid
          Row(
            children: [
              // Total Players
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.people,
                  value: totalPlayers.toString(),
                  label: locale == 'en' ? 'Players' : 'لاعبين',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Position
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.leaderboard,
                  value: '#$currentPosition',
                  label: locale == 'en' ? 'Your Rank' : 'ترتيبك',
                  color: Colors.amber,
                  badge: positionChange != 0
                      ? _buildPositionBadge(positionChange)
                      : null,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Intensity
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.local_fire_department,
                  value: _getIntensityText(),
                  label: locale == 'en' ? 'Intensity' : 'الحدة',
                  color: intensityColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    Widget? badge,
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              if (badge != null)
                Positioned(
                  top: -8,
                  right: -8,
                  child: badge,
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextWidget(
            title: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: value.startsWith('#') || int.tryParse(value) != null,
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: label,
            fontSize: 10,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionBadge(int change) {
    final isPositive = change > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: isPositive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
            size: 10,
          ),
          const SizedBox(width: 2),
          TextWidget(
            title: change.abs().toString(),
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
        ],
      ),
    );
  }
}
