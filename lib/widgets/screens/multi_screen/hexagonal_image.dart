import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/hexagon_painter.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/video_network_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HexagonalImage extends StatelessWidget {
  final String image;
  final dynamic video;
  final bool isWaiting;
  final double width;
  final double height;
  const HexagonalImage(
      {super.key,
      required this.image,
      this.video,
      this.isWaiting = false,
      this.height = 90,
      this.width = 90});

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
            child: isWaiting
                ? SizedBox(
                    width: width,
                    height: height,
                    child: TextWidget(
                        title: AppLocalizations.of(context)!
                            .waiting_for_other_players),
                  )
                : video != null && video != ''
                    ? NetworkVideoWidget(
                        videoUrl: Uri.parse(video),
                        radius: 0,
                        height: height,
                        width: width,
                        image: image,
                      )
                    : CachedImage(
                        image: image, // Replace with your image path
                        width: width,
                        height: height,
                      ),
          ),
        ],
      ),
    );
  }
}
