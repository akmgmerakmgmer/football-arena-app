import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/screens/questions/multi_stats.dart';
import 'package:provider/provider.dart';

class TwoPlayersStats extends StatefulWidget {
  const TwoPlayersStats({super.key});

  @override
  State<TwoPlayersStats> createState() => _TwoPlayersStatsState();
}

class _TwoPlayersStatsState extends State<TwoPlayersStats> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.sendPointsListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map room = Provider.of<LocaleProvider>(context, listen: true).room;
    Map player1 = room['players'][0];
    Map player2 = room['players'][1];
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 10,
          child: MultiStats(
              image: player1['userId']['selectedAvatar']['image'],
              points: player1['points'].toString()),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: MultiStats(
              image: player2['userId']['selectedAvatar']['image'],
              points: player2['points'].toString()),
        ),
      ],
    );
  }
}
