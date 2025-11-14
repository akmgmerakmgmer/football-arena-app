
import 'package:flutter/material.dart';

class PolygonSidePainter extends CustomPainter {
  @override
   void paint(Canvas canvas, Size size) {
    // Shadow Paint
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.6) // Shadow color with opacity
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6); // Blur effect

    // // Border Paint
    // final borderPaint = Paint()
    //   ..color = Colors.white.withOpacity(0.6) // Border color
    //   ..style = PaintingStyle.stroke // Only stroke (border)
    //   ..strokeWidth = 0; // Border width

    // Polygon Paint
    final polygonPaint = Paint()
      ..color = Colors.white.withOpacity(0.1) // Main polygon color
      ..style = PaintingStyle.fill;

    final path = Path();
    // Define the polygon shape
    path.moveTo(0, 0); // Top-left
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(size.width * 0.95, size.height); // Bottom-right slant
    path.lineTo(size.width * 0.05, size.height); // Bottom-left slant
    path.close();

    // Draw shadow (shifted slightly for shadow effect)
    canvas.drawPath(path.shift(const Offset(4, 4)), shadowPaint);

    // // Draw the border
    // canvas.drawPath(path, borderPaint);

    // Draw the filled polygon
    canvas.drawPath(path, polygonPaint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
