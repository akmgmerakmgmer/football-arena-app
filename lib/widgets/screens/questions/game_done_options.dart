import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPlayAgain) ...[
            SaveExitButton(
              buttonText: AppLocalizations.of(context)!.playAgain,
              action: () => playAgain(),
              icon: Icons.refresh_rounded,
              radius: 12,
              fontSize: 16,
              loading: loading,
            ),
            const SizedBox(width: 16),
          ],
          SaveExitButton(
            buttonText: AppLocalizations.of(context)!.exitGame,
            action: () => exitGame(),
            icon: Icons.home_rounded,
            radius: 12,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
