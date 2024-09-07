import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class SinglePerk extends StatelessWidget {
  final Function action;
  final String image;
  final bool disabled;
  const SinglePerk(
      {super.key,
      required this.action,
      required this.image,
      required this.disabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => action(),
        child: AnimatedOpacity(
          opacity: disabled ? 0.4 : 1,
          duration: const Duration(milliseconds: 200),
          child: CachedImage(
            image: image,
            width: 35,
          ),
        ));
  }
}
