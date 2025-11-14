import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge_segment.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key});

  @override
  Widget build(BuildContext context) {
    Map challenges =
        Provider.of<LocaleProvider>(context, listen: false).challenges;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: PagesAssetBackground(
          child: Column(
            children: [
              ChallengeSegment(
                title: AppLocalizations.of(context)!.playersChallenge,
                data: challenges.isEmpty ? [] : challenges['playersChallenges'],
                loading: false,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.teamsChallenge,
                  data: challenges.isEmpty ? [] : challenges['teamsChallenge'],
                  loading: false),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.nationalTeamsChallenge,
                  data: challenges.isEmpty
                      ? []
                      : challenges['nationalTeamsChallenge'],
                  loading: false),
            ],
          ),
        ));
  }
}
