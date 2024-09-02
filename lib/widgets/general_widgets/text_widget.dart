import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
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
      this.textDecoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textDirection: number ? TextDirection.ltr : null,
      textAlign: textAlign,
      style: TextStyle(
          overflow: TextOverflow.clip,
          height: height,
          fontSize:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                  ? fontSize - 1
                  : fontSize,
          fontWeight: fontWeight,
          fontFamily:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                  ? 'NotoKufiArabic'
                  : 'Oswald',
          color: color,
          letterSpacing:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                  ? 0
                  : letterSpacing,
          decoration: textDecoration),
    );
  }
}
