import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'dart:async';

class EventDetailsCard extends StatefulWidget {
  final DateTime? endDate;
  final int totalParticipants;
  final int entryPrice;
  final String locale;
  final bool isSinglePlayer;
  final bool isNew;
  
  const EventDetailsCard({
    super.key,
    this.endDate,
    required this.totalParticipants,
    required this.entryPrice,
    required this.locale,
    this.isSinglePlayer = false,
    this.isNew = false,
  });

  @override
  State<EventDetailsCard> createState() => _EventDetailsCardState();
}

class _EventDetailsCardState extends State<EventDetailsCard> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.endDate != null) {
      _calculateTimeRemaining();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateTimeRemaining();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTimeRemaining() {
    if (widget.endDate != null) {
      final now = DateTime.now();
      final difference = widget.endDate!.difference(now);
      if (difference.isNegative) {
        _timer?.cancel();
        setState(() {
          _timeRemaining = Duration.zero;
        });
      } else {
        setState(() {
          _timeRemaining = difference;
        });
      }
    }
  }

  Color _getUrgencyColor() {
    if (widget.endDate == null) return Colors.blue;
    
    final hours = _timeRemaining.inHours;
    if (hours < 1) return Colors.red;
    if (hours < 6) return Colors.orange;
    if (hours < 24) return Colors.amber;
    return Colors.green;
  }

  String _getFormattedTime() {
    if (widget.endDate == null) return '--:--';
    
    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;
    
    if (days > 0) {
      return '${days}d ${hours}h';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final urgencyColor = _getUrgencyColor();
    final isUrgent = widget.endDate != null && _timeRemaining.inHours < 6;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.withOpacity(0.2),
            Colors.purple.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.indigo.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with badges
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
                  Icons.info_outline,
                  color: Colors.indigo,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: widget.locale == 'en' ? 'EVENT INFO' : 'معلومات الحدث',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const Spacer(),
              
              // Status badges
              if (widget.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.8),
                        Colors.teal.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fiber_new,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: widget.locale == 'en' ? 'NEW' : 'جديد',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              
              if (isUrgent) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.8),
                        Colors.orange.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: widget.locale == 'en' ? 'URGENT' : 'عاجل',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Info Grid
          Row(
            children: [
              // Time Remaining
              if (widget.endDate != null)
                Expanded(
                  child: _buildInfoBox(
                    context,
                    icon: Icons.timer,
                    iconColor: urgencyColor,
                    label: widget.locale == 'en' ? 'Time Left' : 'الوقت المتبقي',
                    value: _getFormattedTime(),
                    color: urgencyColor,
                  ),
                ),
              
              if (widget.endDate != null) const SizedBox(width: 12),
              
              // Participants
              Expanded(
                child: _buildInfoBox(
                  context,
                  icon: Icons.people,
                  iconColor: Colors.cyan,
                  label: widget.locale == 'en' 
                      ? (widget.isSinglePlayer ? 'Players' : 'Players') 
                      : 'لاعبين',
                  value: widget.totalParticipants.toString(),
                  color: Colors.cyan,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Entry Price
              Expanded(
                child: _buildInfoBoxWithWidget(
                  context,
                  iconWidget: const Coin(width: 24),
                  label: widget.locale == 'en' ? 'Entry Fee' : 'رسوم الدخول',
                  value: widget.entryPrice == 0 ? 'FREE' : widget.entryPrice.toString(),
                  color: widget.entryPrice == 0 ? Colors.green : Colors.amber,
                  isFree: widget.entryPrice == 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color color,
    bool isFree = false,
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
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          TextWidget(
            title: value,
            fontSize: isFree ? 12 : 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: !isFree,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: label,
            fontSize: 9,
            color: Colors.white.withOpacity(0.7),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBoxWithWidget(
    BuildContext context, {
    required Widget iconWidget,
    required String label,
    required String value,
    required Color color,
    bool isFree = false,
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
          iconWidget,
          const SizedBox(height: 8),
          TextWidget(
            title: value,
            fontSize: isFree ? 12 : 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            alwaysEnglish: !isFree,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          TextWidget(
            title: label,
            fontSize: 9,
            color: Colors.white.withOpacity(0.7),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
