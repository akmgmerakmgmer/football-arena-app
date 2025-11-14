import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/regular_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    double defaultFontSize = localeProvider.locale == 'en' ? 15 : 16;

    return ImageBackgroundContainer(
        body: Column(
      children: [
        // MainButton(
        //   fontSize: defaultFontSize,
        //   buttonText: 'Dynamic Method',
        //   action: () {
        //     GeneralMethods().dynamicMethod(context);
        //   },
        //   uppercase: true,
        //   radius: 10,
        // ),
        MainButton(
          fontSize: defaultFontSize,
          buttonText: AppLocalizations.of(context)!.start,
          action: () {
            if (localeProvider.user.containsKey('username')) {
              Navigator.pushNamed(
                context,
                '/questions',
              );
            } else {
              Navigator.pushNamed(context, '/signup');
            }
          },
          uppercase: true,
          radius: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            fontSize: defaultFontSize,
            buttonText: AppLocalizations.of(context)!.play_online,
            action: () {
              if (localeProvider.user.containsKey('username')) {
                Navigator.pushNamed(context, '/main-online-screen');
              } else {
                Navigator.pushNamed(context, '/signup');
              }
            },
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            fontSize: defaultFontSize,
            buttonText: AppLocalizations.of(context)!.events_and_challenges,
            action: () {
              Navigator.pushNamed(context, '/play-alone');
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
            fontSize: defaultFontSize,
            buttonText: AppLocalizations.of(context)!.rankings,
            action: () {
              Navigator.pushNamed(context, '/rankings');
            },
            uppercase: true),
      ],
    ));
  }
}
