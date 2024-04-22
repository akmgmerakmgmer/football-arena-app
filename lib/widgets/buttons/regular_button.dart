import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class RegularButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  const RegularButton(
      {super.key,
      required this.buttonText,
      required this.action,
      this.uppercase = false});

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
              color: Colors.black.withOpacity(0.6),
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
          fontSize: 18,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
