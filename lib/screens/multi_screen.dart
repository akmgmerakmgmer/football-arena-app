import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/multi-questions.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/general_widgets/waiting_for_other_players.dart';
import 'package:in_zone_app/widgets/screens/multi_screen/player_bar.dart';
import 'package:in_zone_app/widgets/screens/questions/rank_flag.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultiScreen extends StatefulWidget {
  const MultiScreen({super.key});

  @override
  State<MultiScreen> createState() => _MultiScreenState();
}

class _MultiScreenState extends State<MultiScreen> with WidgetsBindingObserver {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    if (mounted) {
      super.initState();
      final LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      _socketMethods.leaveRoomEarlyListener(localeProvider);
      _socketMethods.navigateToGameListener(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (localeProvider.room['players'].length ==
              localeProvider.room['numberOfPlayers']) navigateToGame();
        });
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      leaveRoomEarly();
    } else if (state == AppLifecycleState.paused) {
      leaveRoomEarly();
    } else if (state == AppLifecycleState.detached) {
      leaveRoomEarly();
    }
  }

  void navigateToGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: '/multi-questions'),
        builder: (context) => const MultiQuestions(),
      ),
    );
  }

  void leaveRoomEarly() {
    final LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    Map data = {
      'roomId': localeProvider.room['_id'],
      'userId': localeProvider.user['_id']
    };
    _socketMethods.leaveRoomEarly(data);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    Map room = Provider.of<LocaleProvider>(context, listen: true).room;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    bool willPromote = user['rank']['wins_to_promote'] ==
        user['season_results']['consecutive_rank_wins'] + 1;
    bool willDemote = user['rank']['loses_to_demote'] ==
        user['season_results']['consecutive_rank_loses'] + 1;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        leaveRoomEarly();
      },
      child: ImageBackgroundPlain(
        image: user['selectedTheme'],
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BlurBackgroundContainer(body: Container()),
            ),
            willPromote || willDemote
                ? RankFlag(
                    promote: willPromote ? true : false,
                  )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: room['players']
                      .asMap()
                      .entries
                      .map<Widget>(
                        (player) => Column(
                          children: [
                            PlayerBar(
                              index: player.key,
                              player: player.value,
                            ),
                            // Show "VS." only if there are more players to be displayed
                            player.key != room['players'].length - 1 ||
                                    room['players'].length !=
                                        room['numberOfPlayers']
                                ? Image.asset(
                                    'assets/images/vs.png',
                                    width: 60,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ],
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Show waiting message if not all players have joined
                room['players'].length != room['numberOfPlayers']
                    ? WaitingForOtherPlayers(
                        title: AppLocalizations.of(context)!
                            .waiting_for_other_players,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
