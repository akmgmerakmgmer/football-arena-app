import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class MatchInfoPanel extends StatelessWidget {
  final int entryFee;
  final int prize;
  final String locale;
  final int currentPlayers;
  final int totalPlayers;

  const MatchInfoPanel({
    super.key,
    required this.entryFee,
    required this.prize,
    required this.locale,
    required this.currentPlayers,
    required this.totalPlayers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Entry fee
          if (entryFee > 0)
            _buildInfoItem(
              icon: const Coin(width: 20),
              label: locale == 'en' ? 'Entry' : 'دخول',
              value: '$entryFee',
              color: Colors.red,
            ),
          // Prize
          if (prize > 0)
            _buildInfoItem(
              icon: const Coin(width: 20),
              label: locale == 'en' ? 'Prize' : 'جائزة',
              value: '$prize',
              color: Colors.amber,
            ),
          // Player count
          _buildInfoItem(
            icon: const Text('👥', style: TextStyle(fontSize: 20)),
            label: locale == 'en' ? 'Players' : 'لاعبين',
            value: '$currentPlayers/$totalPlayers',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required Widget icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          TextWidget(
            title: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: true,
          ),
          const SizedBox(height: 2),
          TextWidget(
            title: label,
            fontSize: 10,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
