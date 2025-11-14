import 'dart:math';
import 'package:flutter/material.dart';

/// Celebration widget for milestone achievements (every 10, 25, 50 questions)
/// Shows confetti animation with trophy icon
/// 
/// Performance considerations:
/// - Uses Transform for particles instead of rebuilding layouts
/// - Single shared AnimationController for all particles
/// - Auto-dismisses after animation to free resources
/// - Overlay pattern for better performance
class MilestoneCelebration extends StatefulWidget {
  final int milestone;
  final VoidCallback onDismiss;
  final String message;

  const MilestoneCelebration({
    Key? key,
    required this.milestone,
    required this.onDismiss,
    this.message = 'Amazing!',
  }) : super(key: key);

  @override
  State<MilestoneCelebration> createState() => _MilestoneCelebrationState();
}

class _MilestoneCelebrationState extends State<MilestoneCelebration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final List<_ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Generate confetti particles
    final random = Random();
    for (int i = 0; i < 20; i++) {
      _particles.add(_ConfettiParticle(
        angle: random.nextDouble() * 2 * pi,
        distance: 50 + random.nextDouble() * 150,
        rotation: random.nextDouble() * 2 * pi,
        color: _getRandomColor(random),
      ));
    }

    _controller.forward().then((_) {
      // Auto dismiss after 800ms
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          widget.onDismiss();
        }
      });
    });
  }

  Color _getRandomColor(Random random) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
    ];
    return colors[random.nextInt(colors.length)];
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
        return Container(
          color: Colors.black.withOpacity(0.7 * _fadeAnimation.value),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Confetti particles
                ..._particles.map((particle) {
                  final progress = _controller.value;
                  final x = cos(particle.angle) * particle.distance * progress;
                  final y = sin(particle.angle) * particle.distance * progress - 
                           (progress * progress * 100); // Gravity effect
                  
                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Transform.rotate(
                      angle: particle.rotation * progress,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: particle.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                
                // Central celebration card
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.amber.shade600,
                            Colors.orange.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            size: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.message,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${widget.milestone} Questions!',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ConfettiParticle {
  final double angle;
  final double distance;
  final double rotation;
  final Color color;

  _ConfettiParticle({
    required this.angle,
    required this.distance,
    required this.rotation,
    required this.color,
  });
}
