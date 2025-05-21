import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/home/events.dart';
import 'package:in_zone_app/widgets/screens/home/home_challenges.dart';
import 'package:in_zone_app/widgets/screens/home/question_mods.dart';

class PlayAlone extends StatelessWidget {
  const PlayAlone({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: const PagesAssetBackground(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Events(),
            QuestionMods(),
            HomeChallenges(),
          ],
        ),
      ),
    );
  }
}
