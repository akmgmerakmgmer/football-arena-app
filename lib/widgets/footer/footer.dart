import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/containers/home_section_containers.dart';
import 'package:flutter_challenge_mobile/widgets/footer/single_icon.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final Color backgroundColor;
  const Footer({super.key, this.backgroundColor = const Color(0xFF191919)});
  Future<void> _launchUrl(url) async {
    final Uri updatedUrl = Uri.parse(url);
    if (!await launchUrl(updatedUrl)) {
      throw Exception('Could not launch $updatedUrl');
    }
  }

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
                action: () => _launchUrl(
                    'https://www.facebook.com/profile.php?id=61560132416554'),
              ),
              const SizedBox(
                width: 12,
              ),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-youtube.svg',
                action: () => _launchUrl(
                    'https://www.facebook.com/profile.php?id=61560132416554'),
              ),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-tiktok.svg',
                action: () => _launchUrl(
                    'https://www.tiktok.com/@inzone2024'),
              ),
              const SizedBox(
                width: 12,
              ),
              SingleIcon(
                icon: 'assets/images/icons8-instagram.svg',
                action: () => _launchUrl(
                    'https://www.instagram.com/inzone2024'),
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
