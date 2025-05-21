import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';

class NeonWhiteText extends StatelessWidget {
  final String word;
  final double fontSize;
  const NeonWhiteText({super.key, required this.word, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        word,
        style: TextStyle(
          fontFamily: 'Oswald',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
          shadows: NeonBoxShadow().whiteNeon(context),
        ),
      ),
    );
  }
}
