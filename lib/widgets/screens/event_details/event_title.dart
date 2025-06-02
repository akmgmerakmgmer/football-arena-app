import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_prizes.dart';

class EventTitle extends StatelessWidget {
  final Map event;
  final String locale;
  const EventTitle({super.key, required this.event, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventPrizes(
          prizes: event['prizes'],
          isSinglePlayer: event['isSinglePlayer'] ?? false,
        ),
        const SizedBox(
          height: 4,
        ),
        TextWidget(
          title: event['description'][locale] ?? '',
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.85),
        ),
      ],
    );
  }
}
