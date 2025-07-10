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
    return Column(
      children: [
        BlurContainer(
          child: Container(
            constraints:
                BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(0.15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NeonWhiteText(
                      word: rank,
                      fontSize: 24,
                      shadow: shadow,
                    ),
                    const SizedBox(width: 15),
                    UserImage(
                      image: avatar['image'],
                      video: avatar['video'],
                      showVideo: true,
                      height: 75,
                      width: 75,
                    ),
                    const SizedBox(width: 8),
                    UsernameText(
                      title: username,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ],
                ),
                NeonWhiteText(
                    word: points.toString(),
                    fontSize: 28,
                    shadow: NeonBoxShadow().whiteNeon(context))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
