import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PlayEventButton extends StatelessWidget {
  final Map event;
  final Map user;
  const PlayEventButton({super.key, required this.event, required this.user});

  bool checkIfUserHasTheEvent(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    List currentEvent = user['events']
        .where((userEvent) =>
            userEvent['id'] == event['_id'] &&
            userEvent['endDate'] == event['endDate'])
        .toList();
    if (currentEvent.isNotEmpty && currentEvent[0]['id'] == event['_id']) {
      return true;
    }
    return false;
  }

  void addEventToUser(context) {
    Map eventPayload = {
      'eventId': event['_id'],
      'endDate': event['endDate'],
      'price': 0
    };
    PutApi('add-event/${user['_id']}', eventPayload, (res) {
      Provider.of<LocaleProvider>(context, listen: false).setUser(res);
    }).put(context);
  }

  void joinGame(BuildContext context) {
    if (!checkIfUserHasTheEvent(context)) {
      addEventToUser(context);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: '/questions'),
        builder: (context) => Questions(
          eventId: event['_id'],
          eventName: event['eventName']['en'],
          userId: user['_id'],
          eventTheme: event['gameBackground'],
          isSinglePlayerEvent: event['isSinglePlayer'] ?? false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: AppLocalizations.of(context)!.playEventNow,
      uppercase: true,
      action: () {
        final userEvents = user['events'] ?? [];
        final eventId = event['_id'];
        final matchingEvent = userEvents.firstWhere(
          (e) => e is Map && e['_id'] == eventId,
          orElse: () => null,
        );
        final gamesPlayed =
            matchingEvent != null && matchingEvent['gamesPlayed'] != null
                ? matchingEvent['gamesPlayed'] as int
                : 0;

        if (gamesPlayed % 2 == 0 && gamesPlayed != 0) {
          AdMethods().showInterstitialAd(() {
            Future.delayed(const Duration(seconds: 4), () {
              joinGame(context);
            });
          }, context);
        } else {
          joinGame(context);
        }
      },
      fontSize: 13,
      radius: 10,
    );
  }
}
