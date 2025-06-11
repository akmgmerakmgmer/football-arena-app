import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class NeonWhiteText extends StatelessWidget {
  final String word;
  final double fontSize;
  final List<Shadow> shadow;
  final bool alwaysEnglish;
  const NeonWhiteText({
    super.key,
    required this.word,
    required this.fontSize,
    required this.shadow,
    this.alwaysEnglish = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 2,
        shadows: shadow,
      ),
      child: TextWidget(
        title: word,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        shadow: shadow,
        alwaysEnglish: alwaysEnglish,
      ),
    );
  }
}
