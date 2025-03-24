import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double border;
  final double padding;
  final double margin;
  final bool isSymmetricPadding;
  final EdgeInsets symmetricPadding;
  final bool darkenBackground;
  final bool whitenBackground;
  const BlurBackgroundContainer(
      {super.key,
      required this.body,
      this.border = 0,
      this.padding = 0,
      this.margin = 0,
      this.isSymmetricPadding = false,
      this.symmetricPadding = const EdgeInsets.all(0),
      this.darkenBackground = false,
      this.whitenBackground = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        color: whitenBackground
            ? Colors.white.withOpacity(0.1)
            : darkenBackground
                ? Colors.black.withOpacity(0.35)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Padding(
              padding: isSymmetricPadding
                  ? symmetricPadding
                  : EdgeInsets.all(padding),
              child: body),
        ),
      ),
    );
  }
}
