import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeasonEnds extends StatelessWidget {
  const SeasonEnds({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlurBackgroundContainer(
        padding: 12,
        border: 10,
        body: Row(
          children: [
            TextWidget(
              title: AppLocalizations.of(context)!.endsAt,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            TextWidget(
              title: ' 23-12-2025',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              alwaysEnglish: true,
            ),
          ],
        ),
      ),
    );
  }
}
