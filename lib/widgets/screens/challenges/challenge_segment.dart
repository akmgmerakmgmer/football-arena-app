import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge_loading_cards.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengeSegment extends StatelessWidget {
  final String title;
  final List data;
  final bool loading;
  const ChallengeSegment(
      {super.key,
      required this.title,
      required this.data,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithBorder(title: title),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: loading
              ? const ChallengeLoadingCards()
              : Row(
                  children: data
                      .map((item) => Challenge(
                          mode: item['_id'],
                          image: item['image'],
                          title: Provider.of<LocaleProvider>(context,
                                          listen: false)
                                      .locale ==
                                  'en'
                              ? item['nameEn']
                              : item['nameAr'],
                          description:
                              '${AppLocalizations.of(context)!.questionsAbout} ${Provider.of<LocaleProvider>(context, listen: false).locale == 'en' ? item['nameEn'] : item['nameAr']}'))
                      .toList(),
                ),
        )
      ],
    );
  }
}
