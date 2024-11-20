import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class EventDataBackground extends StatelessWidget {
  final String locale;
  final String title;
  final bool bottom;
  const EventDataBackground(
      {super.key,
      required this.locale,
      required this.title,
      this.bottom = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: bottom
              ? const BorderRadius.only(topLeft: Radius.circular(10))
              : locale == 'ar'
                  ? const BorderRadius.only(bottomLeft: Radius.circular(10))
                  : const BorderRadius.only(bottomRight: Radius.circular(10))),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextWidget(
        title: title,
        fontWeight: locale == 'ar' ? FontWeight.w600 : FontWeight.bold,
        fontSize: 12.5,
      ),
    );
  }
}
