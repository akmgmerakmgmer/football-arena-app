import 'package:flutter/material.dart';

class FadeTransitionContainer extends StatefulWidget {
  final Widget body; // Widget to animate
  final Duration duration; // Duration for fade animation
  final bool isVisible; // Whether the widget should be visible or not

  const FadeTransitionContainer({
    super.key,
    required this.body,
    this.duration = const Duration(milliseconds: 300),
    this.isVisible = true,
  });

  @override
  _FadeTransitionContainerState createState() =>
      _FadeTransitionContainerState();
}

class _FadeTransitionContainerState extends State<FadeTransitionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: const Duration(milliseconds: 300)
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start with the appropriate animation (visible or hidden)
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(FadeTransitionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if visibility changed, trigger the appropriate animation
    if (widget.isVisible && !_controller.isAnimating) {
      _controller.forward();
    } else if (!widget.isVisible && !_controller.isAnimating) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.body,
    );
  }
}
