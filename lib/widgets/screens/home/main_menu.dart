import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/regular_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
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
              Navigator.pushReplacementNamed(
                context,
                '/questions',
              );
            } else {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          uppercase: true,
        ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
          buttonText: AppLocalizations.of(context)!.challengesWord,
          action: () {
            Navigator.pushReplacementNamed(context, '/challenges');
          },
          uppercase: true,
        ),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            buttonText: AppLocalizations.of(context)!.rankings,
            action: () {
              Navigator.pushReplacementNamed(context, '/rankings');
            },
            uppercase: true),
        const SizedBox(
          height: 15,
        ),
        RegularButton(
            buttonText: AppLocalizations.of(context)!.practice,
            action: () {
              if (Provider.of<LocaleProvider>(context, listen: false)
                  .user
                  .containsKey('username')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Questions(
                      practice: true,
                    ),
                  ),
                );
              } else {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            uppercase: true),
      ],
    ));
  }
}
