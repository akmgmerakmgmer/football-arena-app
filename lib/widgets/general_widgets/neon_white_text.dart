import 'package:flutter/material.dart';

class NeonWhiteText extends StatelessWidget {
  final String word;
  final double fontSize;
  final List<Shadow> shadow;
  const NeonWhiteText(
      {super.key,
      required this.word,
      required this.fontSize,
      required this.shadow});

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
          shadows: shadow,
        ),
      ),
    );
  }
}
