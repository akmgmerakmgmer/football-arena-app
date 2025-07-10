import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/game_data.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/user_inputs/dropdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomData extends StatefulWidget {
  final bool isCasual;
  final bool hostRoom;
  const RoomData({super.key, required this.isCasual, required this.hostRoom});

  @override
  State<RoomData> createState() => _RoomDataState();
}

class _RoomDataState extends State<RoomData> {
  bool loading = false;
  final SocketMethods _socketMethods = SocketMethods();
  int numberOfPlayers = GameData.numberOfPlayersAvailable[0];
  String mode = GameData.modes[0]['value'];
  int gameDuration = GameData.gameDuration[0]['value'];

  @override
  void initState() {
    if (mounted) {
      LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      _socketMethods.joinRoomSuccesListener(context, localeProvider);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            DropDownWidget(
              label: AppLocalizations.of(context)!.numberOfPlayers,
              items: GameData.numberOfPlayersAvailable,
              callback: (value) {
                numberOfPlayers = value;
              },
              initialValue: GameData.numberOfPlayersAvailable[0],
            ),
            const SizedBox(
              height: 4,
            ),
            DropDownWidget(
              label: AppLocalizations.of(context)!.gameDuration,
              items: GameData.gameDuration,
              callback: (value) {
                gameDuration = value;
              },
              initialValue: GameData.gameDuration[0]['value'],
            ),
            const SizedBox(
              height: 4,
            ),
            DropDownWidget(
              label: AppLocalizations.of(context)!.selectMode,
              items: GameData.modes,
              callback: (value) {
                mode = value;
              },
              initialValue: GameData.modes[0]['value'],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: MainButton(
                  buttonText: AppLocalizations.of(context)!.selectMode,
                  radius: 4,
                  padding: const EdgeInsets.all(8),
                  fontSize: 12,
                  uppercase: true,
                  loading: loading,
                  action: () => {
                        setState(() {
                          loading = true;
                        }),
                        GeneralMethods().joinGameWithAds(
                            context, localeProvider,
                            mode: mode,
                            hostRoom: widget.hostRoom,
                            isCasual: widget.isCasual,
                            numberOfPlayers: numberOfPlayers,
                            gameDuration: gameDuration)
                      }),
            ),
          ],
        ));
  }
}
