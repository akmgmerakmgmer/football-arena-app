import 'package:flutter/material.dart';

/// Displays current answer streak with fire icon and animations
/// Only shows when streak is 3 or more
/// 
/// Performance considerations:
/// - Only rebuilds when streak value changes
/// - Uses SingleTickerProviderStateMixin for efficient animation
/// - Animation triggered only on streak increase, not continuous
/// - Shrinks to SizedBox when streak < 3
class StreakCounter extends StatefulWidget {
  final int streak;
  final bool showAnimation;

  const StreakCounter({
    Key? key,
    required this.streak,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  State<StreakCounter> createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Scale animation for streak update
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // Pulsing glow animation
    _glowAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(StreakCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger animation only when streak increases
    if (widget.streak > oldWidget.streak && widget.showAnimation) {
      _controller.forward(from: 0.0).then((_) {
        if (mounted) {
          _controller.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getStreakColor() {
    if (widget.streak >= 10) {
      return Colors.orange;
    } else if (widget.streak >= 5) {
      return Colors.amber;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide when streak is less than 3
    if (widget.streak < 3) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _getStreakColor().withOpacity(_glowAnimation.value * 0.5),
                  blurRadius: 10 * _glowAnimation.value,
                  spreadRadius: 2 * _glowAnimation.value,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: _getStreakColor(),
                  size: 24 * _glowAnimation.value,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.streak}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _getStreakColor(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
