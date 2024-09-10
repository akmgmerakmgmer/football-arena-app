import 'package:flutter/material.dart';

class LoadingCardNoEffects extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color bgColor;

  const LoadingCardNoEffects(
      {super.key,
      required this.height,
      required this.width,
      this.radius = 16.0,
      this.bgColor = const Color(0xFF191919)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
            radius), // Ensures the borderRadius stays the same
      ),
    );
  }
}
