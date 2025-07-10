import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_images.dart';

class PlayerPartyAvatar extends StatelessWidget {
  final Map player;
  final Map user;
  const PlayerPartyAvatar(
      {super.key, required this.player, required this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = player['userId']['selectedAvatar'];
    final username = player['userId']?['username'] ?? '';
    return Column(
      children: [
        ProfileImages(
          isSelected: username == user['username'],
          image: avatar['image'],
          video: avatar['video'],
          showVideo: avatar['video'] != '',
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 4,
        ),
        username.isEmpty
            ? Container()
            : WhiteGlassBackground(
                body: UsernameText(
                  title: username,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
