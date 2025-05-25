import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';

class GameDoneContainer extends StatefulWidget {
  final String image;
  final bool isCasual;
  final String code;
  const GameDoneContainer(
      {super.key,
      required this.image,
      required this.isCasual,
      required this.code});

  @override
  State<GameDoneContainer> createState() => _GameDoneContainerState();
}

class _GameDoneContainerState extends State<GameDoneContainer> {
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

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.image,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.code == ''
                  ? SaveExitButton(
                      buttonText: AppLocalizations.of(context)!.playAgain,
                      action: () => playAgain(),
                      icon: Icons.restart_alt,
                      radius: 10,
                      fontSize: 16,
                      loading: loading,
                    )
                  : Container(),
              widget.code == ''
                  ? const SizedBox(
                      width: 15,
                    )
                  : Container(),
              SaveExitButton(
                buttonText: AppLocalizations.of(context)!.exitGame,
                action: () => exit(),
                icon: Icons.exit_to_app,
                radius: 10,
                fontSize: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
