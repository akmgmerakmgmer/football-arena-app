import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class ProfileImages extends StatelessWidget {
  final bool isSelected;
  final String image;
  final dynamic video;
  final bool isTheme;
  final bool showVideo;
  const ProfileImages(
      {super.key,
      required this.isSelected,
      required this.image,
      this.isTheme = false,
      this.video,
      required this.showVideo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                  width: 3,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent)),
          child: UserImage(
            image: image,
            width: 220,
            height: isTheme ? 280 : 200,
            radius: 15,
            video: video,
            showVideo: showVideo,
          )),
    );
  }
}
