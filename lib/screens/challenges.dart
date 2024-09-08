import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
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
  Map challenges = {};
  bool loading = false;

  Future<void> fetchChallenges() async {
    if (Provider.of<LocaleProvider>(context, listen: false)
        .challenges
        .isEmpty) {
      setState(() {
        loading = true;
      });
      await FetchApi('challenges', (challenges) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setChallenges(challenges);
        // ignore: use_build_context_synchronously
      }).fetch(context);
    }
    challenges =
        // ignore: use_build_context_synchronously
        Provider.of<LocaleProvider>(context, listen: false).challenges;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchChallenges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ChallengeSegment(
                title: AppLocalizations.of(context)!.playersChallenge,
                data: challenges.isEmpty ? [] : challenges['playersChallenges'],
                loading: loading,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.teamsChallenge,
                  data: challenges.isEmpty ? [] : challenges['teamsChallenge'],
                  loading: loading),
              const SizedBox(
                height: 16.0,
              ),
              ChallengeSegment(
                  title: AppLocalizations.of(context)!.nationalTeamsChallenge,
                  data: challenges.isEmpty
                      ? []
                      : challenges['nationalTeamsChallenge'],
                  loading: loading),
            ],
          ),
        ));
  }
}
