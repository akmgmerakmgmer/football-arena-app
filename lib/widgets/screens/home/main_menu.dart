import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/regular_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PageArguments {
  final String message;
  final bool status;

  PageArguments(this.message, this.status);
}

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
              Navigator.pushNamed(context, '/questions',
                  arguments: PageArguments('practice', false));
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
            action: () {
              if (Provider.of<LocaleProvider>(context, listen: false)
                  .user
                  .containsKey('username')) {
                Navigator.pushNamed(context, '/questions',
                    arguments: PageArguments('practice', true));
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            buttonText: AppLocalizations.of(context)!.rankings,
            action: () {
              Navigator.pushNamed(context, '/rankings');
            },
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
