import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class ProfileImages extends StatelessWidget {
  final bool isSelected;
  final String image;
  const ProfileImages(
      {super.key, required this.isSelected, required this.image});

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
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: CachedImage(
            image: image,
            width: 260,
            height: 180,
          ),
        ),
      ),
    );
  }
}
