import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayEventButton extends StatelessWidget {
  final Map event;
  final Map user;
  const PlayEventButton(
      {super.key,
      required this.event,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: AppLocalizations.of(context)!.playEventNow,
      uppercase: true,
      action: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/questions'),
            builder: (context) => Questions(
              eventId: event['_id'],
              eventName: event['eventName']['en'],
              userId: user['_id'],
              eventTheme: event['gameBackground'],
            ),
          ),
        );
      },
      fontSize: 13,
      radius: 10,
    );
  }
}
