import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class Titles extends StatelessWidget {
  final String title;
  const Titles({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      title: title.toUpperCase(),
      fontSize: 32,
      letterSpacing: 10,
      textAlign: TextAlign.center,
    );
  }
}
