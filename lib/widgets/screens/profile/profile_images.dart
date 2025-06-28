import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class ProfileImages extends StatelessWidget {
  final bool isSelected;
  final String image;
  final dynamic video;
  final bool isTheme;
  final bool showVideo;
  final double height;
  final double width;
  final double radius;
  const ProfileImages(
      {super.key,
      required this.isSelected,
      required this.image,
      this.isTheme = false,
      this.video,
      required this.showVideo,
      this.height = 115,
      this.width = 115,
      this.radius = 100});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              border: Border.all(
                  width: 3,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent)),
          child: UserImage(
            image: image,
            width: width,
            height: height,
            radius: radius,
            video: video,
            showVideo: showVideo,
          )),
    );
  }
}
