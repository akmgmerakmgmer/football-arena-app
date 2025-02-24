import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NeedUpdate extends StatelessWidget {
  const NeedUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 300,
      child: Column(
        children: [
          TextWidget(
            title: AppLocalizations.of(context)!.update_app,
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 16,
          ),
          MainButton(
              buttonText: AppLocalizations.of(context)!.update_app_text,
              fontSize: 14,
              radius: 10,
              action: () {
                ExternalUrl().launchNewUrl(
                      'https://play.google.com/store/apps/details?id=soccer.in_zone_gaming_app');
              })
        ],
      ),
    );
  }
}
