import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class UsernameText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  const UsernameText(
      {super.key,
      required this.title,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 13,
      this.letterSpacing = 0.2});

  @override
  Widget build(BuildContext context) {
    final hasEnglishChar = RegExp(r'[a-zA-Z]').hasMatch(title);
    return TextWidget(
      title: title,
      fontSize: fontSize,
      fontWeight: fontWeight,
      alwaysEnglish: hasEnglishChar,
      alwaysArabic: !hasEnglishChar,
    );
  }
}
