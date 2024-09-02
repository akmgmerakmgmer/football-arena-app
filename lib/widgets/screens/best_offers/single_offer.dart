import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleOffer extends StatelessWidget {
  final Map offer;
  final String lang;
  const SingleOffer({super.key, required this.offer, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              offer['image'],
              fit: BoxFit.cover,
              height: 250,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Column(
            children: [
              Container(
                color: Theme.of(context).primaryColorDark,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: offer['company'],
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextWidget(
                      title: lang == 'ar'
                          ? offer['headline']['ar']
                          : offer['headline']['en'],
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextWidget(
                      title: lang == 'ar'
                          ? offer['description']['ar'].length > 150
                              ? '${offer['description']['ar'].substring(0, 150)}...'
                              : offer['description']['ar']
                          : offer['description']['en'].length > 150
                              ? '${offer['description']['en'].substring(0, 150)}...'
                              : offer['description']['en'],
                      color: Colors.grey.shade300,
                      fontSize: 12.5,
                    ),
                  ],
                ),
              ),
              MainButton(
                  buttonText: AppLocalizations.of(context)!.checkOffer,
                  radius: 10,
                  offersPage: true,
                  fontSize: 14,
                  letterSpacing: 1,
                  action: () {
                    ExternalUrl().launchNewUrl(offer['directionLink']);
                  }),
              const SizedBox(
                height: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}
