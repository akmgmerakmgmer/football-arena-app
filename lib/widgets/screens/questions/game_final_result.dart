import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_multi.dart';
import 'package:in_zone_app/widgets/screens/questions/single_player_final_result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameFinalResult extends StatelessWidget {
  final List players;
  const GameFinalResult({super.key, required this.players});

  int get totalPoints => players.fold<int>(
      0, (sum, player) => sum + ((player['points'] ?? 0) as int));

  @override
  Widget build(BuildContext context) {
    // Create a sorted copy of players from best to worst points
    final sortedPlayers = List<Map>.from(players)
      ..sort((a, b) =>
          ((b['points'] ?? 0) as int).compareTo((a['points'] ?? 0) as int));

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlurContainer(
        blurSigma: 15,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NeonWhiteText(
                  word: AppLocalizations.of(context)!.finalRankings,
                  fontSize: 42,
                  uppercase: true,
                  letterSpacing: 1.1,
                  shadow: NeonBoxShadow().whiteNeon(context)),
              const SizedBox(
                height: 36,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortedPlayers.length,
                    itemBuilder: (context, index) {
                      final player = sortedPlayers[index];
                      return SinglePlayerFinalResult(
                        player: player,
                        rank: (index + 1).toString(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const GameDoneMulti(isCasual: true)
            ],
          ),
        ),
      ),
    );
  }
}
