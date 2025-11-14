import 'package:flutter/material.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image_background.dart';

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
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Stack(
          children: [
            // Background image with gradient overlay
            EventImageBackground(
              numberOfImages: numberOfImages,
              image: event['image'],
              child: Container(),
            ),
            
            // Content
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bottom section - End date
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white.withOpacity(0.9),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          TextWidget(
                            title: '${AppLocalizations.of(context)!.ends_on} ${event['endDate']}',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
