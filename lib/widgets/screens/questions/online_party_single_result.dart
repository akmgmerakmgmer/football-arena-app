import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_images.dart';

class OnlinePartySingleResult extends StatelessWidget {
  final double top;
  final double bottom;
  final double left;
  final double right;
  final Map player;
  final Map user;
  const OnlinePartySingleResult({
    super.key,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
    required this.player,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = player['userId']['selectedAvatar'];
    final username = player['userId']?['username'] ?? '';
    final points = player['points'] ?? 0;
    return Column(
      children: [
        ProfileImages(
          isSelected: username == user['username'],
          image: avatar['image'],
          video: avatar['video'],
          showVideo: false,
          height: 75,
          width: 75,
          transparentBorder: false,
        ),
        const SizedBox(
          height: 4,
        ),
        UsernameText(
          title: username,
          fontSize: 15,
        ),
        const SizedBox(
          height: 4,
        ),
        TextWidget(
          title: points.toString(),
          alwaysEnglish: true,
          fontSize: 20,
        )
      ],
    );
  }
}
