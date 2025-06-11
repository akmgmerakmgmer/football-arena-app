import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayEventButton extends StatelessWidget {
  final Map event;
  final Map user;
  const PlayEventButton({super.key, required this.event, required this.user});

  void joinGame(BuildContext context) {
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

        if (gamesPlayed % 3 == 0 && gamesPlayed != 0) {
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
