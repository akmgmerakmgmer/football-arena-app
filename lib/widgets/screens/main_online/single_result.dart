import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SingleResult extends StatelessWidget {
  final String text;
  final dynamic number;
  const SingleResult({super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WhiteGlassBackground(body: TextWidget(title: text)),
        const SizedBox(
          height: 8,
        ),
        TextWidget(
          title: number.toString(),
          alwaysEnglish: true,
        )
      ],
    );
  }
}
