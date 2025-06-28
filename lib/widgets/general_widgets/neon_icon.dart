import 'package:flutter/material.dart';

class NeonIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final List<Shadow> shadow;
  final Color color;
  const NeonIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.shadow,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
      shadows: shadow,
    );
  }
}
