import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/containers/home_section_containers.dart';
import 'package:in_zone_app/widgets/footer/single_icon.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Footer extends StatelessWidget {
  final Color backgroundColor;
  const Footer({super.key, this.backgroundColor = const Color(0xFF111111)});

  @override
  Widget build(BuildContext context) {
    return HomeSectionContainers(
        padding: 24.0,
        backgroundColor: backgroundColor,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleIcon(
                  icon: 'assets/images/icons8-facebook.svg',
                  action: () => ExternalUrl().launchNewUrl(
                      'https://www.facebook.com/profile.php?id=61560132416554')),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-youtube.svg',
                action: () =>  ExternalUrl().launchNewUrl(
                    'https://www.facebook.com/profile.php?id=61560132416554'),
              ),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-tiktok.svg',
                action: () =>  ExternalUrl().launchNewUrl('https://www.tiktok.com/@inzonegaming'),
              ),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-instagram.svg',
                action: () =>
                     ExternalUrl().launchNewUrl('https://www.instagram.com/inzone2024'),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextWidget(
          //       title: AppLocalizations.of(context)!.terms,
          //       fontSize: 18,
          //     ),
          //     const SizedBox(
          //       width: 32,
          //     ),
          //     TextWidget(
          //       title: AppLocalizations.of(context)!.privacy,
          //       fontSize: 18,
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          TextWidget(
            title: AppLocalizations.of(context)!.copyrights,
            color: Colors.grey.shade500,
            textAlign: TextAlign.center,
            fontSize: 15,
          )
        ]);
  }
}
