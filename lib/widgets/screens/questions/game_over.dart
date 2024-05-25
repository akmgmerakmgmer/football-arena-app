import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/save_exit_button.dart';
import 'package:flutter_challenge_mobile/widgets/containers/fade_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameOver extends StatelessWidget {
  final Function playAgain;
  final Function exitGame;
  const GameOver({super.key, required this.playAgain, required this.exitGame});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: FadeTransitionContainer(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gameOver.png',
              width: 200,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SaveExitButton(
                  buttonText: AppLocalizations.of(context)!.playAgain,
                  action: () => playAgain(),
                  icon: Icons.restart_alt,
                ),
                const SizedBox(
                  width: 15,
                ),
                SaveExitButton(
                  buttonText: AppLocalizations.of(context)!.exitGame,
                  action: () => exitGame(),
                  icon: Icons.exit_to_app,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
