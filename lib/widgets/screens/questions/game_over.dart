import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_options.dart';

class GameOver extends StatelessWidget {
  final Function playAgain;
  final Function exitGame;
  const GameOver({super.key, required this.playAgain, required this.exitGame});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
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
          GameDoneOptions(
              playAgain: playAgain,
              exitGame: exitGame,
              loading: false,
              showPlayAgain: true)
        ],
      ),
    );
  }
}
