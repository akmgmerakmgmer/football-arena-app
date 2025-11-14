import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class SinglePlayerFinalResult extends StatelessWidget {
  final Map player;
  final String rank;
  const SinglePlayerFinalResult(
      {super.key, required this.player, required this.rank});

  @override
  Widget build(BuildContext context) {
    final avatar = player['userId']['selectedAvatar'];
    final username = player['userId']?['username'] ?? '';
    final points = player['points'];
    final int rankInt = int.tryParse(rank) ?? 0;

    List<Shadow> shadow = rankInt == 1
        ? NeonBoxShadow().goldNeon(context)
        : rankInt == 2
            ? NeonBoxShadow().silverNeon(context)
            : rankInt == 3
                ? NeonBoxShadow().bronzeNeon(context)
                : NeonBoxShadow().whiteNeon(context);
    
    return BlurContainer(
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.white.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Rank badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade700,
                        Colors.grey.shade900,
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: NeonWhiteText(
                      word: rank,
                      fontSize: 18,
                      shadow: shadow,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                UserImage(
                  image: avatar['image'],
                  video: avatar['video'],
                  showVideo: true,
                  height: 65,
                  width: 65,
                ),
                const SizedBox(width: 12),
                UsernameText(
                  title: username,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ],
            ),
            // Points
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: NeonWhiteText(
                word: points.toString(),
                fontSize: 22,
                shadow: NeonBoxShadow().whiteNeon(context),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
