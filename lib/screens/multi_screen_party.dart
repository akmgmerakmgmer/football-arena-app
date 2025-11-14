import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/multi-questions.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/general_widgets/waiting_for_other_players.dart';
import 'package:in_zone_app/widgets/screens/multi_screen/placeholder_avatar.dart';
import 'package:in_zone_app/widgets/screens/multi_screen/player_counter_header.dart';
import 'package:in_zone_app/widgets/screens/multi_screen/player_party_avatar.dart';
import 'package:in_zone_app/widgets/screens/questions/room_code.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MultiScreenParty extends StatefulWidget {
  final bool coinsPayed;
  const MultiScreenParty({super.key, this.coinsPayed = false});

  @override
  State<MultiScreenParty> createState() => _MultiScreenState();
}

class _MultiScreenState extends State<MultiScreenParty>
    with WidgetsBindingObserver {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    if (mounted) {
      super.initState();
      WidgetsBinding.instance.addObserver(this);
      leavePageWhenStateChanges();
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

  void leavePageWhenStateChanges() {
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (message == AppLifecycleState.inactive.toString()) {
      } else if (message == AppLifecycleState.paused.toString()) {
        leaveRoomEarly();
      } else if (message == AppLifecycleState.detached.toString()) {
        leaveRoomEarly();
      }
      return null;
    });
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
    Map user = localeProvider.user;
    Map data = {
      'roomId': localeProvider.room['_id'],
      'userId': localeProvider.user['_id']
    };
    _socketMethods.leaveRoomEarly(
        data, widget.coinsPayed, context, localeProvider, user);
    Navigator.pushReplacementNamed(context, '/main-online-screen');
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    Map room = localeProvider.room;
    Map user = localeProvider.user;
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
            room['code'] != null && room['code'] != ''
                ? RoomCode(code: room['code'])
                : Container(),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlayerCounterHeader(
                        currentPlayers: room['players'].length,
                        totalPlayers: room['numberOfPlayers'],
                        locale: localeProvider.locale,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GridContainer(
                              fixedGrids: true,
                              widget: List.generate(
                                  room['numberOfPlayers'],
                                  (index) => index < room['players'].length
                                      ? PlayerPartyAvatar(
                                          player: room['players'][index],
                                          user: user,
                                        )
                                      : const PlaceholderAvatar()),
                              numberOfGrids: 3,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            room['players'].length != room['numberOfPlayers']
                                ? WaitingForOtherPlayers(
                                    title: AppLocalizations.of(context)!
                                        .waiting_for_players,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
