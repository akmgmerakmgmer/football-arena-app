import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/text_style.dart';
import 'package:provider/provider.dart';

class RotateAnimatedTextWidget extends StatelessWidget {
  final List titles;
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
  const RotateAnimatedTextWidget({
    super.key,
    required this.titles,
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
  });

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return AnimatedTextKit(
        animatedTexts: titles
            .map(
              (name) => RotateAnimatedText(
                  uppercase ? name.toUpperCase() : name,
                  textStyle: getCustomTextStyle(
                      height: height,
                      fontSize: locale == 'ar' ? fontSize - 1 : fontSize,
                      fontWeight: fontWeight,
                      color: color,
                      letterSpacing: locale == 'ar' ? 0 : letterSpacing,
                      locale: locale,
                      alwaysEnglish: alwaysEnglish,
                      alwaysArabic: alwaysArabic)),
            )
            .toList());
  }
}
