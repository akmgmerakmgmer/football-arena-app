import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/containers/home_section_containers.dart';
import 'package:in_zone_app/widgets/general_widgets/descriptions.dart';
import 'package:in_zone_app/widgets/general_widgets/titles.dart';
import 'package:in_zone_app/widgets/screens/home/single_challenge.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpcomingChallenges extends StatelessWidget {
  UpcomingChallenges({super.key});
  List<Map> challenges = [
    {
      'challengeEn': 'Uefa Champions League',
      'challengeAr': 'دوري ابطال اوروبا',
      'background':
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1713219667/nl63hujc9sp0hgc4jaoc.jpg'
    },
    {
      'challengeEn': 'Premier League',
      'challengeAr': 'الدوري الانجليزي',
      'background':
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1713219648/y1mg1ojbzo9r7xx2plsc.webp'
    },
    {
      'challengeEn': 'La Liga',
      'challengeAr': 'الدوري الاسباني',
      'background':
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1713219622/pt9hmv1xe6aw5yhuekeq.jpg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return HomeSectionContainers(
        backgroundColor: Theme.of(context).primaryColorDark,
        children: [
          Titles(title: AppLocalizations.of(context)!.challenges),
          const SizedBox(
            height: 16,
          ),
          Descriptions(desc: AppLocalizations.of(context)!.challengesDesc),
          const SizedBox(
            height: 16,
          ),
          GridContainer(
              widget: challenges
                  .map((challenge) => SingleChallenge(
                        challengeValue: challenge['challengeEn'],
                        image: challenge['background'],
                        title:
                            Provider.of<LocaleProvider>(context, listen: false)
                                        .locale ==
                                    'ar'
                                ? challenge['challengeAr']
                                : challenge['challengeEn'],
                      ))
                  .toList())
        ]);
  }
}
