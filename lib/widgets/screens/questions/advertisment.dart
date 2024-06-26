import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/black_modal_container.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Advertisment extends StatelessWidget {
  final String image;
  final int seconds;
  final void Function() skipAdMethod;
  final void Function() adClicked;
  const Advertisment(
      {super.key,
      required this.image,
      required this.seconds,
      required this.skipAdMethod,
      required this.adClicked});

  @override
  Widget build(BuildContext context) {
    return BlackModalContainer(
      body: Stack(
        children: [
          GestureDetector(
            onTap: adClicked,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: skipAdMethod,
              child: BlurBackgroundContainer(
                border: 100,
                body: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: TextWidget(
                      title: seconds <= 0
                          ? AppLocalizations.of(context)!.skipAd
                          : '${AppLocalizations.of(context)!.skipAdIn} $seconds ${AppLocalizations.of(context)!.seconds}'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
