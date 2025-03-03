import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class UserImage extends StatelessWidget {
  final String image;
  final dynamic video;
  final Color borderColor;
  final double imageSize;
  const UserImage(
      {super.key,
      required this.image,
      required this.borderColor,
      this.imageSize = 75,
      this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(color: borderColor, width: 4)),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: CachedImage(
            image: image,
            height: imageSize,
            width: imageSize,
          ),
        ));
  }
}
