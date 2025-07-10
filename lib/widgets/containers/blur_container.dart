import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final double radius;
  final Widget child;
  final double blurSigma;
  const BlurContainer(
      {super.key, this.radius = 10, required this.child, this.blurSigma = 10});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: child),
    );
  }
}
