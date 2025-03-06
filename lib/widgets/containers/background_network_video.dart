import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/video_network_widget.dart';

class BackgroundNetworkVideo extends StatelessWidget {
  final Uri videoUrl;
  final Widget body;
  final String image;
  const BackgroundNetworkVideo(
      {super.key, required this.videoUrl, required this.body, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        NetworkVideoWidget(
          videoUrl: videoUrl,
          showPauseIcon: true,
          image: image,
        ),
        Positioned(
          bottom: 0,
          child: body,
        )
      ],
    );
  }
}
