import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/text_style.dart';
import 'package:provider/provider.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final double height;
  final double letterSpacing;
  final bool number;
  final dynamic textAlign;
  final TextDecoration textDecoration;
  final bool uppercase;
  final bool alwaysEnglish;
  final bool alwaysArabic;
  final List<Shadow> shadow;
  const TextWidget(
      {super.key,
      required this.title,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 13,
      this.color = Colors.white,
      this.height = 1.2,
      this.letterSpacing = 0.2,
      this.number = false,
      this.textAlign,
      this.textDecoration = TextDecoration.none,
      this.uppercase = false,
      this.alwaysEnglish = false,
      this.alwaysArabic = false,
      this.shadow = const []});

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Text(
      uppercase ? title.toUpperCase() : title,
      textDirection: number ? TextDirection.ltr : null,
      textAlign: textAlign,
      softWrap: true, // Ensures text wraps instead of overflowing
      style: getCustomTextStyle(
          height: height,
          fontSize: locale == 'ar' ? fontSize - 1 : fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: locale == 'ar' ? 0 : letterSpacing,
          locale: locale,
          alwaysEnglish: alwaysEnglish,
          alwaysArabic: alwaysArabic,
          shadow: shadow),
    );
  }
}
