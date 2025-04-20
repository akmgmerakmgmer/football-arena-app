import 'package:flutter/material.dart';

class WhiteGlassBackground extends StatelessWidget {
  final EdgeInsets padding;
  final Widget body;
  final bool darkenBackground;
  final double radius;
  const WhiteGlassBackground(
      {super.key,
      this.padding = const EdgeInsets.all(8),
      required this.body,
      this.darkenBackground = false,
      this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: darkenBackground
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20, // Equivalent to backdrop-blur-md
                      spreadRadius: 20, // Optional
                      offset: const Offset(0, 3), // Optional
                    ),
                  ]
                : null,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white.withOpacity(0.1)),
        child: body);
  }
}
