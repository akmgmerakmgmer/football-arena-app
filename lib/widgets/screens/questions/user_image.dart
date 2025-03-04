import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/video_network_widget.dart';

class UserImage extends StatelessWidget {
  final String image;
  final dynamic video;
  final Color borderColor;
  final bool showVideo;
  final double radius;
  final double width;
  final double height;
  const UserImage(
      {super.key,
      required this.image,
      this.borderColor = Colors.transparent,
      this.video,
      this.showVideo = false,
      this.radius = 100,
      this.width = 75,
      this.height = 75});

  @override
  Widget build(BuildContext context) {
    return video != null && video != '' && showVideo
        ? NetworkVideoWidget(
            videoUrl: Uri.parse(video),
            radius: radius,
            height: width,
            width: height,
          )
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                border: Border.all(color: borderColor, width: 4)),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              child: CachedImage(
                image: image,
                height: height,
                width: width,
              ),
            ));
  }
}
