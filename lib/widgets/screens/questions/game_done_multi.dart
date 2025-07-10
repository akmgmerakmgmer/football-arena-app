import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_options.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';

class GameDoneMulti extends StatefulWidget {
  final bool isCasual;
  final String code;
  const GameDoneMulti({super.key, required this.isCasual, this.code = ''});

  @override
  State<GameDoneMulti> createState() => _GameDoneContainerState();
}

class _GameDoneContainerState extends State<GameDoneMulti> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    playAgain() async {
      if (widget.isCasual) {
        return ModalContainer.bottomSheetHostGame(context, localeProvider,
            isCasual: true);
      } else {
        setState(() {
          loading = true;
        });
        await GeneralMethods()
            .joinGameWithAds(context, localeProvider, isOnline: true);
      }
    }

    exit() {
      if (widget.isCasual || widget.code != '') {
        Navigator.pushReplacementNamed(context, '/main-online-screen');
      } else {
        Navigator.pushReplacementNamed(context, '/main-online');
      }
    }

    return GameDoneOptions(
        playAgain: playAgain,
        exitGame: exit,
        loading: loading,
        showPlayAgain: widget.code == '');
  }
}
