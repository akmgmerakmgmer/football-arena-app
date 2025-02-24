import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/screens/questions/multi_stats.dart';

class TwoPlayersStats extends StatefulWidget {
  final Map user;
  final int points;
  final Function stopTime;
  final Function penalty;
  final Function varMethod;
  final Function stoppageTime;
  final Function pointsMultiplicationMethod;
  final Function skipQuestion;
  final List usedPerks;
  final String locale;
  final LocaleProvider localeProvider;
  const TwoPlayersStats(
      {super.key,
      required this.user,
      required this.points,
      required this.stopTime,
      required this.penalty,
      required this.varMethod,
      required this.stoppageTime,
      required this.pointsMultiplicationMethod,
      required this.skipQuestion,
      required this.usedPerks,
      required this.locale,
      required this.localeProvider});

  @override
  State<TwoPlayersStats> createState() => _TwoPlayersStatsState();
}

class _TwoPlayersStatsState extends State<TwoPlayersStats> {
  final SocketMethods _socketMethods = SocketMethods();
  void action(perk) {
    bool isPerkUsed = widget.usedPerks
        .where((item) => item == perk['id']['_id'])
        .toList()
        .isNotEmpty;
    if (perk['quantity'] > 0 && !isPerkUsed && perk['id']['applicableOnline']) {
      switch (perk['id']['title']['en']) {
        case '+90':
          widget.stoppageTime(perk['id']['_id']);
        case 'Penalty':
          widget.penalty(perk['id']['_id']);
        case 'VAR':
          widget.varMethod(perk['id']['_id']);
        case 'Stop Time':
          widget.stopTime(perk['id']['_id']);
        case 'Double Points':
          widget.pointsMultiplicationMethod(perk['id']['_id'], 2, 30);
        case 'Hero Personality':
          widget.pointsMultiplicationMethod(perk['id']['_id'], 3, 20);
        case 'Skip Question':
          widget.skipQuestion(perk['id']['_id']);
        default:
          () => {};
      }
    }
  }

  bool isPerkDisabled(perk) {
    if (perk['quantity'] == 0 ||
        widget.usedPerks.contains(perk['id']['_id']) ||
        !perk['id']['applicableOnline']) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _socketMethods.sendPointsListener(widget.localeProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map room = widget.localeProvider.room;
    Map user = widget.localeProvider.user;
    String userId = user['_id'];
    Map player1 = room['players'][0];
    Map player2 = room['players'][1];
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 10,
          child: MultiStats(
            image: player1['userId']['selectedAvatar']['image'],
            points: player1['userId']['_id'] == userId
                ? widget.points.toString()
                : player1['points'].toString(),
            isMainUser: player1['userId']['_id'] == userId,
            username: player1['userId']['username'],
            user: user,
            action: (perk) => action(perk),
            isPerkDisabled: (perk) => isPerkDisabled(perk),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: MultiStats(
            image: player2['userId']['selectedAvatar']['image'],
            points: player2['userId']['_id'] == userId
                ? widget.points.toString()
                : player2['points'].toString(),
            isMainUser: player2['userId']['_id'] == userId,
            username: player2['userId']['username'],
            action: (perk) => action(perk),
            isPerkDisabled: (perk) => isPerkDisabled(perk),
            user: user,
          ),
        ),
      ],
    );
  }
}
