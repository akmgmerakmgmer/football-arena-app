import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PrizeReason extends StatelessWidget {
  final String searchTime;
  const PrizeReason({super.key, this.searchTime = ''});

  @override
  Widget build(BuildContext context) {
    return searchTime.isNotEmpty
        ? TextWidget(
            fontSize: 13,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.bold,
            title: searchTime == 'daily'
                ? AppLocalizations.of(context)!.daily_challenge
                : searchTime == 'weekly'
                    ? AppLocalizations.of(context)!.weekly_challenge
                    : searchTime == 'monthly'
                        ? AppLocalizations.of(context)!.monthly_challenge
                        : AppLocalizations.of(context)!.yearly_challenge)
        : Container();
  }
}
