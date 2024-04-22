import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/regular_button.dart';
import 'package:flutter_challenge_mobile/widgets/containers/image_background_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
        body: Column(
      children: [
        MainButton(
          buttonText: AppLocalizations.of(context)!.start,
          action: () {
            if (Provider.of<LocaleProvider>(context, listen: false)
                .user
                .containsKey('username')) {
              Navigator.pushNamed(context, '/questions');
            } else {
              Navigator.pushNamed(context, '/login');
            }
          },
          uppercase: true,
        ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            buttonText: AppLocalizations.of(context)!.practice,
            action: () {},
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            buttonText: AppLocalizations.of(context)!.rules,
            action: () {},
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
          buttonText: AppLocalizations.of(context)!.contactUs,
          action: () {},
          uppercase: true,
        )
      ],
    ));
  }
}
