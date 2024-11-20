import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NeonIcon extends StatelessWidget {
  final IconData icon;
  const NeonIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Neon Shadow Layer
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.6), // Outer neon shadow
                blurRadius: 30,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.3), // Subtle inner glow
                blurRadius: 40,
                spreadRadius: 1,
              ),
            ],
          ),
        ),

        // Main Icon
        Icon(
          icon, // Change to your preferred icon
          size: 18,
          color: Colors.white,
        ),
      ],
    );
  }
}
