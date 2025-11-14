import 'package:flutter/material.dart';

/// Visual feedback widget that flashes green for correct answers and red for wrong answers.
/// Shows a screen edge glow effect that fades out quickly.
/// 
/// Performance considerations:
/// - Uses AnimatedOpacity instead of full rebuilds
/// - Simple border decoration, minimal complexity
/// - Auto-disposes after animation completes
class AnswerFlashAnimation extends StatefulWidget {
  final bool isCorrect;
  final VoidCallback onComplete;
  
  const AnswerFlashAnimation({
    Key? key,
    required this.isCorrect,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<AnswerFlashAnimation> createState() => _AnswerFlashAnimationState();
}

class _AnswerFlashAnimationState extends State<AnswerFlashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create animation controller for fade effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Create fade animation with custom curve for smooth fade out
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start animation and call onComplete when done
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
    // Choose color based on answer correctness
    final color = widget.isCorrect
        ? Colors.green.withOpacity(0.3)
        : Colors.red.withOpacity(0.3);

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.withOpacity(_fadeAnimation.value),
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Alternative flash style that fills the entire screen with a colored overlay
/// Use this for a more dramatic effect
class AnswerFlashAnimationFull extends StatefulWidget {
  final bool isCorrect;
  final VoidCallback onComplete;
  
  const AnswerFlashAnimationFull({
    Key? key,
    required this.isCorrect,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<AnswerFlashAnimationFull> createState() => _AnswerFlashAnimationFullState();
}

class _AnswerFlashAnimationFullState extends State<AnswerFlashAnimationFull>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Start at full opacity and fade out
    _fadeAnimation = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
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
    final color = widget.isCorrect ? Colors.green : Colors.red;

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: IgnorePointer(
            child: Container(
              color: color.withOpacity(_fadeAnimation.value),
            ),
          ),
        );
      },
    );
  }
}
