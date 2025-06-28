import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/animations/pulse_animation.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image_background.dart';
import 'package:in_zone_app/widgets/screens/home/event_data_background.dart';
import 'package:in_zone_app/widgets/screens/home/shiny_icon.dart';

class EventImage extends StatelessWidget {
  final int numberOfImages;
  final Map event;
  final String locale;
  final bool showIcon;
  const EventImage(
      {super.key,
      required this.event,
      required this.locale,
      this.showIcon = false,
      this.numberOfImages = 1});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: EventImageBackground(
            numberOfImages: numberOfImages,
            image: event['image'],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EventDataBackground(
                        locale: locale, title: event['eventName'][locale]),
                    showIcon
                        ? Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.all(4),
                            child: const PulseAnimation(
                                child: ShinyIcon(
                                    size: 16,
                                    icon: Icons.question_mark_rounded)),
                          )
                        : Container(),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: EventDataBackground(
                      bottom: true,
                      locale: locale,
                      title:
                          '${AppLocalizations.of(context)!.ends_on} ${event['endDate']}'),
                )
              ],
            )));
  }
}
