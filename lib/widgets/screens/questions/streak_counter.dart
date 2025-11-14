import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class StreakCounter extends StatefulWidget {
  final int streak;
  final bool showAnimation;
  
  const StreakCounter({
    super.key,
    required this.streak,
    this.showAnimation = true,
  });

  @override
  State<StreakCounter> createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    if (widget.showAnimation) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(StreakCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.streak != widget.streak && widget.streak > oldWidget.streak) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getStreakColor() {
    if (widget.streak >= 10) return const Color(0xFFFF6B00); // Hot orange
    if (widget.streak >= 5) return const Color(0xFFFFA000); // Amber
    return const Color(0xFFFFD600); // Yellow
  }

  @override
  Widget build(BuildContext context) {
    if (widget.streak < 3) return const SizedBox.shrink();
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getStreakColor(),
                  _getStreakColor().withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _getStreakColor().withOpacity(0.5),
                  blurRadius: 12 * _pulseAnimation.value,
                  spreadRadius: 2 * _pulseAnimation.value,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: _pulseAnimation.value,
                  child: const Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 6),
                TextWidget(
                  title: '${widget.streak} STREAK!',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
