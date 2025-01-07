import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundEffect extends StatelessWidget {
  final double radius;
  final EdgeInsets padding;
  final Widget widget;
  const BlurBackgroundEffect({super.key, required this.radius, required this.padding, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius), // Apply rounded corners to blur
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // Apply blur
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05), // Semi-transparent overlay
            borderRadius: BorderRadius.circular(radius),
          ),
          child: widget
        ),
      ),
    );
  }
}
