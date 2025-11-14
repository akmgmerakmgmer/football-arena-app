import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/best_offers/single_offer.dart';
import 'package:provider/provider.dart';

class BestOffers extends StatelessWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    List bestOffers = Provider.of<LocaleProvider>(context, listen: false)
        .advertisments['bestOffers'];
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleWithBorder(title: AppLocalizations.of(context)!.bestOffers),
              const SizedBox(
                height: 16,
              ),
              GridContainer(
                  widget: bestOffers
                      .map((offer) => SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleOffer(
                                offer: offer,
                                lang: Provider.of<LocaleProvider>(context,
                                        listen: false)
                                    .locale),
                          ))
                      .toList())
            ],
          ),
        ));
  }
}
