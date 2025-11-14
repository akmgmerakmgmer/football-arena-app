import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class EventCountdown extends StatefulWidget {
  final DateTime endDate;
  final String locale;
  
  const EventCountdown({
    super.key,
    required this.endDate,
    required this.locale,
  });

  @override
  State<EventCountdown> createState() => _EventCountdownState();
}

class _EventCountdownState extends State<EventCountdown> {
  late Timer _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateTimeRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeRemaining();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateTimeRemaining() {
    final now = DateTime.now();
    final difference = widget.endDate.difference(now);
    
    if (mounted) {
      setState(() {
        _timeRemaining = difference.isNegative ? Duration.zero : difference;
      });
    }
  }

  Color _getUrgencyColor() {
    final hours = _timeRemaining.inHours;
    if (hours < 1) return Colors.red;
    if (hours < 6) return Colors.orange;
    if (hours < 24) return Colors.amber;
    return Colors.green;
  }

  String _getFormattedTime() {
    if (_timeRemaining == Duration.zero) {
      return widget.locale == 'en' ? 'Event Ended' : 'انتهى الحدث';
    }

    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else {
      return '${minutes}m ${seconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final urgencyColor = _getUrgencyColor();
    final isUrgent = _timeRemaining.inHours < 6;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            urgencyColor.withOpacity(0.3),
            urgencyColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: urgencyColor.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: isUrgent
            ? [
                BoxShadow(
                  color: urgencyColor.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.access_time,
            color: urgencyColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                title: widget.locale == 'en' ? 'Event Ends In' : 'ينتهي الحدث في',
                fontSize: 11,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 2),
              TextWidget(
                title: _getFormattedTime(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: urgencyColor,
                alwaysEnglish: true,
              ),
            ],
          ),
          if (isUrgent) ...[
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: urgencyColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: urgencyColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: urgencyColor,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  TextWidget(
                    title: widget.locale == 'en' ? 'URGENT' : 'عاجل',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: urgencyColor,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
