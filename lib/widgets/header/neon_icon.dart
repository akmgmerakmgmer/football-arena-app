import 'package:flutter/material.dart';

class NeonIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  const NeonIcon({super.key, required this.icon, this.size = 18});

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
          size: size,
          color: Colors.white,
        ),
      ],
    );
  }
}
