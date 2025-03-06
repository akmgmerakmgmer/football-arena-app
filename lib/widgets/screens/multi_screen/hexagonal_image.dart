import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/hexagon_painter.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/video_network_widget.dart';

class HexagonalImage extends StatelessWidget {
  final String image;
  final dynamic video;
  const HexagonalImage({super.key, required this.image, this.video});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Silver Border (Slightly larger hexagon)
          ClipPath(
            clipper: HexagonPainter(),
            child: Container(
              width: 100, // Slightly larger than the image
              height: 100,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          // Hexagonal Image
          ClipPath(
            clipper: HexagonPainter(),
            child: video != null && video != ''
                ? NetworkVideoWidget(
                    videoUrl: Uri.parse(video),
                    radius: 0,
                    height: 90,
                    width: 90,
                    image: image,
                  )
                : CachedImage(
                    image: image, // Replace with your image path
                    width: 90,
                    height: 90,
                  ),
          ),
        ],
      ),
    );
  }
}
