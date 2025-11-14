import 'package:flutter/material.dart';

/// Shows a speed bonus indicator when user answers quickly
/// Slides up from center with bonus percentage
/// 
/// Performance considerations:
/// - Single-use widget that auto-disposes
/// - Uses Transform for efficient animations
/// - Simple gradient, minimal complexity
class SpeedBonusIndicator extends StatefulWidget {
  final double bonusMultiplier;
  final VoidCallback onComplete;

  const SpeedBonusIndicator({
    Key? key,
    required this.bonusMultiplier,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<SpeedBonusIndicator> createState() => _SpeedBonusIndicatorState();
}

class _SpeedBonusIndicatorState extends State<SpeedBonusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 50),
      end: const Offset(0, -200),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.15, curve: Curves.easeIn),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.of(context).size.width / 2 - 30,
          top: MediaQuery.of(context).size.height / 2 + _slideAnimation.value.dy,
          child: Opacity(
            opacity: _fadeAnimation.value * (1.0 - _controller.value),
            child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade600,
                    Colors.green.shade400,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt,
                color: Colors.yellow,
                size: 36,
              ),
            ),
          ),
        );
      },
    );
  }
}
