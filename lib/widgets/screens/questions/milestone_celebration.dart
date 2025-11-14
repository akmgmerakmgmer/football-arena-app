import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'dart:math' as math;

class MilestoneCelebration extends StatefulWidget {
  final int milestone;
  final VoidCallback onDismiss;
  final String message;
  
  const MilestoneCelebration({
    super.key,
    required this.milestone,
    required this.onDismiss,
    required this.message,
  });

  @override
  State<MilestoneCelebration> createState() => _MilestoneCelebrationState();
}

class _MilestoneCelebrationState extends State<MilestoneCelebration> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          widget.onDismiss();
        }
      });
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
        return Opacity(
          opacity: _fadeAnimation.value.clamp(0.0, 1.0),
          child: Container(
            color: Colors.black.withOpacity(0.7 * (1 - _fadeAnimation.value)),
            child: Center(
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti particles
                    ...List.generate(20, (index) {
                      return _ConfettiParticle(
                        index: index,
                        animation: _controller,
                      );
                    }),
                    // Main content
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 60,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 16),
                          TextWidget(
                            title: '${widget.milestone} QUESTIONS!',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                            title: widget.message,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ConfettiParticle extends StatelessWidget {
  final int index;
  final Animation<double> animation;
  
  const _ConfettiParticle({
    required this.index,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final random = math.Random(index);
    final angle = random.nextDouble() * 2 * math.pi;
    final distance = 100 + random.nextDouble() * 150;
    final color = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple][index % 5];
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final x = math.cos(angle) * distance * progress;
        final y = math.sin(angle) * distance * progress - (progress * progress * 100);
        
        return Transform.translate(
          offset: Offset(x, y),
          child: Transform.rotate(
            angle: progress * 4 * math.pi,
            child: Opacity(
              opacity: (1 - progress).clamp(0.0, 1.0),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
