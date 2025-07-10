import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';

class BlurContainerWithBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsets padding;
  const BlurContainerWithBorder(
      {super.key,
      required this.child,
      this.radius = 8,
      this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8)});

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
        radius: radius,
        child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                borderRadius: BorderRadius.circular(radius),
                color: Colors.white.withOpacity(0.1)),
            padding: padding,
            child: child));
  }
}
