import 'package:flutter/material.dart';

class TiltedBackgroundPainter extends CustomPainter {
  final Color color;

  TiltedBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.2); // Start tilted
    path.lineTo(size.width, size.height * 0.1); // Top-right corner, slightly higher
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.lineTo(0, size.height); // Bottom-left corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
