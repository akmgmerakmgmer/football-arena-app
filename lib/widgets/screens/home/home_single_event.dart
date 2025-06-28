import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image_background.dart';
import 'package:in_zone_app/widgets/screens/home/live_now.dart';

class HomeSingleEvent extends StatelessWidget {
  final LocaleProvider localeProvider;
  const HomeSingleEvent({super.key, required this.localeProvider});

  @override
  Widget build(BuildContext context) {
    final locale = localeProvider.locale;
    final events = localeProvider.events;
    final filteredEvents = events
        .where((event) =>
            event['isSinglePlayer'] != true && event['isMultiplayer'] != true)
        .toList();
    Map event = {};
    if (filteredEvents.isNotEmpty) {
      filteredEvents.shuffle();
      event = filteredEvents.first;
    }
    return Center(
        child: EventImageBackground(
      image: event['image'],
      numberOfImages: 1,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: LiveNow(),
      ),
    ));
  }
}
