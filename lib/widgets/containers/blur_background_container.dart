import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundContainer extends StatelessWidget {
  final int blurRate;
  final Widget body;
  final double border;
  const BlurBackgroundContainer(
      {super.key, this.blurRate = 5, required this.body, this.border = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: body,
      ),
    );
  }
}
