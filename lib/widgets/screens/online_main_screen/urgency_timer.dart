import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class UrgencyTimer extends StatefulWidget {
  final DateTime? endTime;
  final String? quickMatchPromise;
  final String? bonusEndText;
  final String locale;
  
  const UrgencyTimer({
    super.key,
    this.endTime,
    this.quickMatchPromise,
    this.bonusEndText,
    required this.locale,
  });

  @override
  State<UrgencyTimer> createState() => _UrgencyTimerState();
}

class _UrgencyTimerState extends State<UrgencyTimer> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.endTime != null) {
      _calculateTimeRemaining();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          _calculateTimeRemaining();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTimeRemaining() {
    if (widget.endTime != null) {
      final now = DateTime.now();
      final difference = widget.endTime!.difference(now);
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
    if (widget.endTime == null) return Colors.blue;
    
    final hours = _timeRemaining.inHours;
    if (hours < 1) return Colors.red;
    if (hours < 6) return Colors.orange;
    if (hours < 24) return Colors.amber;
    return Colors.green;
  }

  String _getFormattedTime() {
    if (widget.endTime == null) return '';
    
    final hours = _timeRemaining.inHours;
    final minutes = _timeRemaining.inMinutes % 60;
    
    if (hours > 24) {
      final days = hours ~/ 24;
      return '${days}d ${hours % 24}h';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      final seconds = _timeRemaining.inSeconds % 60;
      return '${minutes}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Quick match promise
    if (widget.quickMatchPromise != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.withOpacity(0.9),
              Colors.teal.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            TextWidget(
              title: widget.quickMatchPromise!,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
      );
    }
    
    // Countdown timer
    if (widget.endTime != null) {
      final urgencyColor = _getUrgencyColor();
      final isUrgent = _timeRemaining.inHours < 6;
      
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              urgencyColor.withOpacity(0.9),
              urgencyColor.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isUrgent
              ? [
                  BoxShadow(
                    color: urgencyColor.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUrgent ? Icons.local_fire_department : Icons.timer,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            TextWidget(
              title: _getFormattedTime(),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              alwaysEnglish: true,
            ),
            const SizedBox(width: 4),
            TextWidget(
              title: widget.locale == 'en' ? 'left' : 'متبقي',
              fontSize: 11,
              color: Colors.white.withOpacity(0.9),
            ),
          ],
        ),
      );
    }
    
    // Bonus text
    if (widget.bonusEndText != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.9),
              Colors.deepPurple.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            TextWidget(
              title: widget.bonusEndText!,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}
