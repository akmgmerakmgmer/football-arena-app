import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImagePrize extends StatelessWidget {
  final String image;
  final String prizeType;
  final bool topMargin;
  const ImagePrize(
      {super.key,
      required this.image,
      required this.prizeType,
      this.topMargin = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topMargin ? 16 : 0,
        ),
        TextWidget(
          title: prizeType == 'avatar'
              ? AppLocalizations.of(context)!.exclusiveAvatar
              : AppLocalizations.of(context)!.exclusiveTheme,
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 8,
        ),
        CachedImage(
          image: image,
          width: MediaQuery.of(context).size.width,
          radius: 10,
          height: MediaQueryHeight().largeImageHeight(context),
        ),
      ],
    );
  }
}
