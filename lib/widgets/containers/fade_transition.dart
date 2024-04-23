import 'package:flutter/material.dart';

class FadeTransitionContainer extends StatefulWidget {
  final Widget body;
  const FadeTransitionContainer({super.key, required this.body});

  @override
  // ignore: library_private_types_in_public_api
  _FadeTransitionContainerState createState() => _FadeTransitionContainerState();
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
      duration: const Duration(milliseconds: 300), // Adjust duration as per your need
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
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
      child: widget.body
    );
  }
}
