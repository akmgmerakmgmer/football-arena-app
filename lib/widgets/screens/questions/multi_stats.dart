import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/username_text.dart';
import 'package:in_zone_app/widgets/screens/questions/player_points.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class MultiStats extends StatelessWidget {
  final String image;
  final String points;
  final bool isMainUser;
  final String username;
  const MultiStats(
      {super.key,
      required this.image,
      required this.points,
      required this.isMainUser,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: BlurBackgroundContainer(
          symmetricPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          border: 10,
          isSymmetricPadding: true,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserImage(
                    image: image,
                    borderColor: Colors.transparent,
                    imageSize: 60,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  UsernameText(
                    title: username,
                    fontSize: 18,
                  ),
                ],
              ),
              PlayerPoints(points: points) 
            ],
          )),
    );
  }
}
