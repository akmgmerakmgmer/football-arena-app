import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_prizes.dart';
import 'package:in_zone_app/widgets/screens/event_details/play_event_button.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_event_data.dart';
import 'package:in_zone_app/widgets/screens/event_details/team_event_data.dart';
import 'package:provider/provider.dart';

class TeamResults extends StatelessWidget {
  final Map event;
  final String locale;
  const TeamResults({super.key, required this.event, required this.locale});

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;

    return PagesAssetBackground(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventImage(
            event: event,
            locale: locale,
          ),
          const SizedBox(
            height: 16,
          ),
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
          const SizedBox(
            height: 12,
          ),
          PlayEventButton(event: event, user: user),
          event['isSinglePlayer'] == true
              ? SingleEventData(event: event, locale: locale)
              : TeamEventData(event: event, currentUser: user, locale: locale)
        ],
      ),
    );
  }
}
