import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge_segment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Challenges extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    List playersChallenges = Provider.of<LocaleProvider>(context, listen: false)
        .challenges['playersChallenges'];
    List teamsChallenges = Provider.of<LocaleProvider>(context, listen: false)
        .challenges['teamsChallenge'];
    List nationalTeamsChallenges =
        Provider.of<LocaleProvider>(context, listen: false)
            .challenges['nationalTeamsChallenge'];

    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.playersChallenge,
                  data: playersChallenges),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.teamsChallenge,
                  data: teamsChallenges),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.nationalTeamsChallenge,
                  data: nationalTeamsChallenges),
            ],
          ),
        ));
  }
}
