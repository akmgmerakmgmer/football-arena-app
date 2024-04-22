import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class Descriptions extends StatelessWidget {
  final String desc;
  const Descriptions({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      title: desc,
      color: Colors.grey.shade300,
      fontSize: 16,
      textAlign: TextAlign.center,
    );
  }
}
