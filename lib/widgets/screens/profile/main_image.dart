import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/icon_neon_button.dart';

class MainImage extends StatelessWidget {
  final String image;
  final Function action;
  final double width;
  final double height;
  const MainImage({
    super.key,
    required this.image,
    required this.action,
    this.width = 115,
    this.height = 115,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
              image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: IconNeonButton(
            radius: 100,
            action: () {
              action();
            },
            icon: Icons.edit,
            size: 16,
          ),
        ));
  }
}
