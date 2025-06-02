import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/event_details/best_score.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_title.dart';
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
    int userScore = user['events'] != null
        ? (user['events'].firstWhere(
              (e) => e['id'] == event['_id'],
              orElse: () => null,
            )?['points'] ??
            0)
        : 0;
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
          EventTitle(event: event, locale: locale),
          const SizedBox(
            height: 12,
          ),
          PlayEventButton(event: event, user: user),
          const SizedBox(
            height: 24,
          ),
          BestScore(
            score: userScore,
            eventName: event['eventName']['en'].toLowerCase() ?? '',
          ),
          event['isSinglePlayer'] == true
              ? SingleEventData(
                  event: event,
                  locale: locale,
                  userId: user['_id'],
                )
              : TeamEventData(event: event, currentUser: user, locale: locale)
        ],
      ),
    );
  }
}
