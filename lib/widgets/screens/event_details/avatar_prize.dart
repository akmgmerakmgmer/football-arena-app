import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvatarPrize extends StatelessWidget {
  final String image;
  final bool showExclusiveText;
  const AvatarPrize(
      {super.key, required this.image, required this.showExclusiveText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showExclusiveText
            ? TextWidget(
                title: AppLocalizations.of(context)!.exclusiveAvatar,
                color: Colors.white70,
                fontSize: 13,
              )
            : Container(),
        SizedBox(
          height: showExclusiveText ? 8 : 0,
        ),
        CachedImage(
          image: image,
          width: MediaQuery.of(context).size.width,
          radius: 10,
        ),
      ],
    );
  }
}
