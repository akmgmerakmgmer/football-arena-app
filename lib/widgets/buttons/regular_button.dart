import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RegularButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  const RegularButton(
      {super.key,
      required this.buttonText,
      required this.action,
      this.uppercase = false,
      this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20, // Equivalent to backdrop-blur-md
              spreadRadius: 2, // Optional
              offset: const Offset(0, 3), // Optional
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: TextWidget(
          title: uppercase ? buttonText.toUpperCase() : buttonText,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
