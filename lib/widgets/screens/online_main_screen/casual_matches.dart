import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/carousel_container.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CasualMatches extends StatelessWidget {
  const CasualMatches({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    enterCasualMatch() {
      if (GeneralMethods().isUserExists(context)) {
        ModalContainer.bottomSheetHostGame(context, localeProvider,
            isCasual: true);
      } else {
        Navigator.pushNamed(context, '/signup');
      }
    }

    List rankedMatches = [
      {
        "image": "assets/images/casual_match.jpg",
        "action": enterCasualMatch,
        // Engagement features
        "titleIcon": Icons.sports_esports,
        "quickMatchPromise": localeProvider.locale == 'en' 
            ? "Match in 30s" 
            : "مباراة في 30 ث",
      },
    ];
    return CarouselContainer(
      title: AppLocalizations.of(context)!.casual_matches,
      desc: AppLocalizations.of(context)!.casual_desc,
      data: rankedMatches,
      locale: localeProvider.locale,
    );
  }
}
