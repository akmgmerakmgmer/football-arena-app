import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameDoneOptions extends StatelessWidget {
  final Function playAgain;
  final Function exitGame;
  final bool loading;
  final bool showPlayAgain;

  const GameDoneOptions(
      {super.key,
      required this.playAgain,
      required this.exitGame,
      required this.loading,
      required this.showPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showPlayAgain
            ? SaveExitButton(
                buttonText: AppLocalizations.of(context)!.playAgain,
                action: () => playAgain(),
                icon: Icons.restart_alt,
                radius: 10,
                fontSize: 16,
                loading: loading,
              )
            : Container(),
        showPlayAgain
            ? const SizedBox(
                width: 15,
              )
            : Container(),
        SaveExitButton(
          buttonText: AppLocalizations.of(context)!.exitGame,
          action: () => exitGame(),
          icon: Icons.exit_to_app,
          radius: 10,
          fontSize: 16,
        ),
      ],
    );
  }
}
