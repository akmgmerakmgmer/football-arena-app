import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundContainer extends StatelessWidget {
  final int blurRate;
  final Widget body;
  final double border;
  final double padding;
  final double margin;
  const BlurBackgroundContainer(
      {super.key,
      this.blurRate = 5,
      required this.body,
      this.border = 0,
      this.padding = 0,
      this.margin = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Padding(padding: EdgeInsets.all(padding), child: body),
        ),
      ),
    );
  }
}
