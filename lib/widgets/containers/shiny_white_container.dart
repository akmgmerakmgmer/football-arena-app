import 'package:flutter/material.dart';

class ShinyWhiteContainer extends StatelessWidget {
  final Widget widget;
  const ShinyWhiteContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.7), // White glow color
              spreadRadius: 3, // Adjust for glow size
              blurRadius: 20, // Adjust for softness of the glow
            ),
          ],
        ),
        child: widget);
  }
}
