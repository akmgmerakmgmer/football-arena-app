import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class ModalButton extends StatelessWidget {
  final dynamic action;
  final String title;
  final Color color;
  const ModalButton(
      {super.key, this.action, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextWidget(
          title: title,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
