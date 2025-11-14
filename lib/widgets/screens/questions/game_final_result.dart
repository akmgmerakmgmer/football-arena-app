import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_multi.dart';
import 'package:in_zone_app/widgets/screens/questions/single_player_final_result.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

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

    // Split into podium (top 3) and rest
    final hasPodium = sortedPlayers.length >= 3;
    final podiumPlayers = hasPodium ? sortedPlayers.take(3).toList().cast<Map>() : <Map>[];
    final remainingPlayers = hasPodium ? sortedPlayers.skip(3).toList() : sortedPlayers;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlurContainer(
        blurSigma: 15,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade600,
                      Colors.blue.shade600,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🏆', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    NeonWhiteText(
                      word: AppLocalizations.of(context)!.finalRankings,
                      fontSize: 28,
                      uppercase: true,
                      letterSpacing: 1.0,
                      shadow: NeonBoxShadow().whiteNeon(context),
                    ),
                    const SizedBox(width: 10),
                    const Text('🏆', style: TextStyle(fontSize: 28)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Podium for top 3
              if (hasPodium) ...[
                _buildPodium(context, podiumPlayers),
                const SizedBox(height: 32),
              ],
              
              // Remaining players
              if (remainingPlayers.isNotEmpty)
                Column(
                  children: remainingPlayers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final player = entry.value;
                    final rank = hasPodium ? index + 4 : index + 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SinglePlayerFinalResult(
                        player: player,
                        rank: rank.toString(),
                      ),
                    );
                  }).toList(),
                ),
              
              const SizedBox(height: 24),
              const GameDoneMulti(isCasual: true)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodium(BuildContext context, List<Map> podiumPlayers) {
    // Arrange as: 2nd - 1st - 3rd
    final first = podiumPlayers.length > 0 ? podiumPlayers[0] : null;
    final second = podiumPlayers.length > 1 ? podiumPlayers[1] : null;
    final third = podiumPlayers.length > 2 ? podiumPlayers[2] : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 2nd place
        if (second != null)
          Expanded(
            child: _buildPodiumCard(context, second, 2, height: 140),
          ),
        const SizedBox(width: 12),
        // 1st place (taller)
        if (first != null)
          Expanded(
            child: _buildPodiumCard(context, first, 1, height: 180),
          ),
        const SizedBox(width: 12),
        // 3rd place
        if (third != null)
          Expanded(
            child: _buildPodiumCard(context, third, 3, height: 120),
          ),
      ],
    );
  }

  Widget _buildPodiumCard(BuildContext context, Map player, int rank, {required double height}) {
    final avatar = player['userId']['selectedAvatar'];
    final username = player['userId']?['username'] ?? '';
    final points = player['points'];

    final medal = rank == 1 ? '🥇' : rank == 2 ? '🥈' : '🥉';
    final gradientColors = rank == 1
        ? [Color(0xFFFFD700), Color(0xFFFFAA00)] // Gold
        : rank == 2
            ? [Color(0xFFC0C0C0), Color(0xFF999999)] // Silver
            : [Color(0xFFCD7F32), Color(0xFF996633)]; // Bronze

    List<Shadow> shadow = rank == 1
        ? NeonBoxShadow().goldNeon(context)
        : rank == 2
            ? NeonBoxShadow().silverNeon(context)
            : NeonBoxShadow().bronzeNeon(context);

    return Container(
      constraints: BoxConstraints(minHeight: height),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.6),
            blurRadius: rank == 1 ? 20 : 12,
            spreadRadius: rank == 1 ? 4 : 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Medal and rank
          Text(
            medal,
            style: TextStyle(fontSize: rank == 1 ? 32 : 28),
          ),
          const SizedBox(height: 4),
          // Avatar
          UserImage(
            image: avatar['image'],
            video: avatar['video'],
            showVideo: true,
            height: rank == 1 ? 60 : 50,
            width: rank == 1 ? 60 : 50,
          ),
          const SizedBox(height: 6),
          // Username
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              width: double.infinity,
              child: TextWidget(
                title: username.length > 12 ? '${username.substring(0, 12)}...' : username,
                fontSize: rank == 1 ? 14 : 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Points
          NeonWhiteText(
            word: points.toString(),
            fontSize: rank == 1 ? 20 : 18,
            shadow: shadow,
            letterSpacing: 0.5,
          ),
        ],
      ),
    );
  }
}
