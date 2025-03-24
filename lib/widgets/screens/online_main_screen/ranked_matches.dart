import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/carousel_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RankedMatches extends StatelessWidget {
  const RankedMatches({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    navigateToRankedMatches() {
      if (GeneralMethods().isUserExists(context)) {
        Navigator.pushNamed(context, '/main-online');
      } else {
        Navigator.pushNamed(context, '/signup');
      }
    }

    List rankedMatches = [
      {
        "image": "assets/images/ranked_match.jpg",
        "action": navigateToRankedMatches,
        "color": Colors.white.withOpacity(0.2)
      },
    ];
    return CarouselContainer(
        title: AppLocalizations.of(context)!.ranked_matches,
        desc: AppLocalizations.of(context)!.ranked_desc,
        locale: localeProvider.locale,
        data: rankedMatches);
  }
}
