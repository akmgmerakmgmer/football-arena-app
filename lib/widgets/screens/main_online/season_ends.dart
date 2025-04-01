import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeasonEnds extends StatelessWidget {
  final String endsDate;
  const SeasonEnds({super.key, required this.endsDate});

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
              title: AppLocalizations.of(context)!.ends_on,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            TextWidget(
              title: ' $endsDate',
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
