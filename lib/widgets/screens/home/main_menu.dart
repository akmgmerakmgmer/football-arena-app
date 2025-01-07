import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/regular_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return ImageBackgroundContainer(
        body: Column(
      children: [
        MainButton(
          fontSize: 15,
          buttonText: AppLocalizations.of(context)!.start,
          action: () {
            if (Provider.of<LocaleProvider>(context, listen: false)
                .user
                .containsKey('username')) {
              Navigator.pushNamed(
                context,
                '/questions',
              );
            } else {
              Navigator.pushNamed(context, '/login');
            }
          },
          uppercase: true,
          radius: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            fontSize: 15,
            buttonText: AppLocalizations.of(context)!.play_online,
            action: () {
              Navigator.pushNamed(context, '/main-online');
            },
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            fontSize: 15,
            buttonText: AppLocalizations.of(context)!.play_alone,
            action: () {
              Navigator.pushNamed(context, '/main-online');
            },
            uppercase: true),
        // RegularButton(
        //   buttonText: AppLocalizations.of(context)!.playOnSite,
        //   action: () {
        //     ExternalUrl().launchNewUrl(locale == 'en'
        //         ? 'https://www.inzonegaming.com/en'
        //         : 'https://www.inzonegaming.com/ar');
        //   },
        //   uppercase: true,
        // ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            fontSize: 15,
            buttonText: AppLocalizations.of(context)!.rankings,
            action: () {
              Navigator.pushNamed(context, '/rankings');
            },
            uppercase: true),
      ],
    ));
  }
}
