import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_prizes.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_result.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TeamResults extends StatelessWidget {
  final Map event;
  final String locale;
  const TeamResults({super.key, required this.event, required this.locale});

  @override
  Widget build(BuildContext context) {
    checkThePlayerSide(side) {
      Map user = Provider.of<LocaleProvider>(context, listen: false).user;
      for (var userEvent in user['events']) {
        if (userEvent['id'] == event['_id']) {
          if (userEvent['yourSide'] == side['_id']) return true;
        }
      }
      return false;
    }

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
          ),
          const SizedBox(
            height: 12,
          ),
          MainButton(
            buttonText: AppLocalizations.of(context)!.playEventNow,
            uppercase: true,
            action: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(name: '/questions'),
                  builder: (context) => Questions(
                    eventId: event['_id'],
                    userId: Provider.of<LocaleProvider>(context, listen: false)
                        .user['_id'],
                  ),
                ),
              );
            },
            fontSize: 13,
            radius: 10,
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 12),
            child: Column(
              children: event['sides']
                  .map<Widget>((side) => SingleResult(
                      playerTeam: checkThePlayerSide(side),
                      side: side,
                      locale: locale,
                      totalPoints: event['total_points']))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
