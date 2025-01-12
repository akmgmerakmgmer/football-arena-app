import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_bg_opacity_no_blur.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SingleRank extends StatelessWidget {
  final Map rank;
  final String locale;
  final bool alwaysEnglish;
  const SingleRank(
      {super.key,
      required this.rank,
      required this.locale,
      this.alwaysEnglish = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedImage(
          image: rank['image'],
          width: alwaysEnglish?140:120,
        ),
        const SizedBox(
          height: 4,
        ),
        WhiteBgOpacityNoBlur(
            widget: TextWidget(
                title: rank['title'][locale],
                alwaysEnglish: alwaysEnglish,
                fontSize: alwaysEnglish ? 16 : 13,
                fontWeight: FontWeight.w600,),
            padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: locale == 'en' || alwaysEnglish ? 18 : 8))
      ],
    );
  }
}
