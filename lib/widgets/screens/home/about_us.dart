import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/home_section_containers.dart';
import 'package:in_zone_app/widgets/general_widgets/descriptions.dart';
import 'package:in_zone_app/widgets/general_widgets/titles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeSectionContainers(children: [
      Titles(title: AppLocalizations.of(context)!.about),
      const SizedBox(
        height: 16,
      ),
      Descriptions(desc: AppLocalizations.of(context)!.aboutDesc),
      const SizedBox(
        height: 16,
      ),
      MainButton(
        buttonText: AppLocalizations.of(context)!.facebookGroup,
        action: () {},
        uppercase: true,
        fontSize: 13,
      )
    ]);
  }
}
