import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleChallenge extends StatelessWidget {
  final String image;
  final String title;
  final String challengeValue;
  const SingleChallenge({
    super.key,
    required this.image,
    required this.title,
    required this.challengeValue,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width > 1024 ? 600 : 500,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.3),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width > 1024 ? 600 : 500,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 16.0),
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  children: [
                    TextWidget(
                      title: title,
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      title:
                          '$title ${AppLocalizations.of(context)!.comingSoon}',
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: MainButton(
                          buttonText:
                              AppLocalizations.of(context)!.willBeNotified,
                          fontSize: 13.5,
                          uppercase: true,
                          action: () {}),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
