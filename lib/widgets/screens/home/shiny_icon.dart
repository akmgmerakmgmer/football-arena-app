import 'package:flutter/material.dart';

class ShinyIcon extends StatelessWidget {
  final double size;
  final IconData icon;
  const ShinyIcon({super.key, required this.size, required this.icon});

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
      child: Icon(
        icon,
        size: size,
        color: Colors.black,
      ),
    );
  }
}
