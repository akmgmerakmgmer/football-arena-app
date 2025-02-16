import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PrizeReason extends StatelessWidget {
  final Map message;
  final String locale;
  const PrizeReason(
      {super.key,
      this.message = const {"en": "", "ar": ""},
      required this.locale});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
        fontSize: 13,
        color: Colors.grey.shade300,
        fontWeight: FontWeight.bold,
        title: message[locale]);
  }
}
