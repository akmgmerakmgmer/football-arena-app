import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:in_zone_app/widgets/containers/blur_container.dart'; // Add this import for BackdropFilter

class LoadingCard extends StatefulWidget {
  final double height;
  final double width;
  final double radius;
  final Color bgColor;
  final double scaleEnd;
  const LoadingCard(
      {super.key,
      required this.height,
      required this.width,
      this.radius = 16.0,
      this.bgColor = const Color.fromARGB(255, 41, 41, 41),
      this.scaleEnd = 1.01});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingCardState createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the speed of the scaling
    )..repeat(reverse: true); // Makes the animation repeat forever in a loop

    // Define a scaling animation
    _animation = Tween<double>(begin: 1.0, end: widget.scaleEnd).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation, // Apply the scaling animation
        child: BlurContainer(
          radius: widget.radius,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.bgColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        ));
  }
}
