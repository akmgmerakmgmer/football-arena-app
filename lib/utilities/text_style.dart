import 'package:flutter/material.dart';

TextStyle getCustomTextStyle({
  required String locale,
  required double fontSize,
  required bool alwaysEnglish,
  required bool alwaysArabic,
  FontWeight fontWeight = FontWeight.normal,
  double height = 1.0,
  Color color = Colors.white,
  double letterSpacing = 0.0,
  TextDecoration textDecoration = TextDecoration.none,
}) {
  return TextStyle(
    height: height,
    fontSize: locale == 'ar' ? fontSize - 1 : fontSize,
    fontWeight: fontWeight,
    fontFamily: alwaysEnglish
        ? 'Oswald'
        : alwaysArabic
            ? 'NotoKufiArabic'
            : locale == 'ar'
                ? 'NotoKufiArabic'
                : 'Oswald',
    color: color,
    letterSpacing: locale == 'ar' ? 0 : letterSpacing,
    decoration: textDecoration,
  );
}
