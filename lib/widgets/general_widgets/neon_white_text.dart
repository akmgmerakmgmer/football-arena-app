import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

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
    return TextWidget(
      title: word,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 2,
      shadow: shadow,
    );
  }
}
