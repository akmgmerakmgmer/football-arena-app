import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class PlayerBarTwo extends StatelessWidget {
  final Map player;
  final int index;
  const PlayerBarTwo({super.key, required this.index, required this.player});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height,
      child: BlurBackgroundContainer(
        padding: 24,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserImage(
              image: player['userId']['selectedAvatar']['image'],
              borderColor: Colors.transparent,
              imageSize: 100,
            ),
            Column(
              children: [
                const Divider(color: Colors.grey),
                const SizedBox(
                  height: 8,
                ),
                UsernameText(
                  title: player['userId']['username'],
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 16,
                ),
                CachedImage(
                  image: player['userId']['rank']['image'],
                  width: 60,
                )
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
