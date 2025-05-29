import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_result.dart';

class TeamEventData extends StatelessWidget {
  final Map event;
  final String locale;
  final Map currentUser;
  const TeamEventData(
      {super.key,
      required this.event,
      required this.locale,
      required this.currentUser});

  @override
  Widget build(BuildContext context) {
    checkThePlayerSide(side) {
      Map user = currentUser;
      for (var userEvent in user['events']) {
        if (userEvent['id'] == event['_id']) {
          if (userEvent['yourSide'] == side['_id']) return true;
        }
      }
      return false;
    }

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 12),
      child: Column(
        children: event['sides']
            .map<Widget>((side) => SingleResult(
                playerTeam: checkThePlayerSide(side),
                side: side,
                locale: locale,
                totalPoints: event['total_points']))
            .toList(),
      ),
    );
  }
}
