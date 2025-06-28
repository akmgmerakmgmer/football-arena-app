import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/home/home_challenges.dart';
import 'package:in_zone_app/widgets/screens/home/home_single_event.dart';
import 'package:in_zone_app/widgets/screens/home/question_mods.dart';
import 'package:provider/provider.dart';

class HomeUpdated extends StatelessWidget {
  const HomeUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: PagesAssetBackground(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSingleEvent(localeProvider: localeProvider),
            QuestionMods(),
            HomeChallenges(),
          ],
        ),
      ),
    );
  }
}
