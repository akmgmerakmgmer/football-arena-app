import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/result_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleResult extends StatelessWidget {
  final Map side;
  final String locale;
  final int totalPoints;
  final bool playerTeam;
  const SingleResult(
      {super.key,
      required this.side,
      required this.locale,
      required this.totalPoints,
      required this.playerTeam});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              title: locale == 'ar' ? side['nameAr'] : side['nameEn'],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            playerTeam
                ? TextWidget(
                    title: '(${AppLocalizations.of(context)!.yourTeam})',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  )
                : Container()
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        ResultBar(
            width: side['points'] == 0
                ? 0
                : (side['points'] / totalPoints) * width),
        const SizedBox(
          height: 8,
        ),
        TextWidget(
          title:
              '${side['points'].toString()} ${locale == 'ar' ? AppLocalizations.of(context)!.point : AppLocalizations.of(context)!.points}',
          fontSize: 12.5,
          color: Colors.white70,
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
