import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class NeonText extends StatelessWidget {
  final String text;
  final double fontSize;

  const NeonText({super.key, required this.text, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: locale == 'ar' ? 'NotoKufiArabic' : 'Oswald',
        shadows: [
          Shadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
          Shadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
          Shadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
