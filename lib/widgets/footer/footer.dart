import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/containers/home_section_containers.dart';
import 'package:flutter_challenge_mobile/widgets/footer/single_icon.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Footer extends StatelessWidget {
  final Color backgroundColor;
  const Footer({super.key, this.backgroundColor = const Color(0xFF191919)});

  @override
  Widget build(BuildContext context) {
    return HomeSectionContainers(
        padding: 24.0,
        backgroundColor: backgroundColor,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleIcon(icon: 'assets/images/icons8-facebook.svg'),
              SizedBox(
                width: 12,
              ),
              SingleIcon(icon: 'assets/images/icons8-twitter.svg'),
              SizedBox(
                width: 12,
              ),
              SingleIcon(icon: 'assets/images/icons8-youtube.svg'),
              SizedBox(
                width: 12,
              ),
              SingleIcon(icon: 'assets/images/icons8-tiktok.svg'),
              SizedBox(
                width: 12,
              ),
              SingleIcon(icon: 'assets/images/icons8-instagram.svg'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                title: AppLocalizations.of(context)!.terms,
                fontSize: 18,
              ),
              const SizedBox(
                width: 32,
              ),
              TextWidget(
                title: AppLocalizations.of(context)!.privacy,
                fontSize: 18,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          TextWidget(
            title: AppLocalizations.of(context)!.copyrights,
            color: Colors.grey.shade500,
            textAlign: TextAlign.center,
            fontSize: 15,
          )
        ]);
  }
}
