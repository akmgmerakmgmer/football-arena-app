import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/double_grid_container.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:in_zone_app/widgets/screens/main_online/rank_nav_links.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RankNavs extends StatelessWidget {
  final String locale;
  final Map user;
  RankNavs({super.key, required this.locale, required this.user});

  final List navs = [
    {
      'title': {
        'en': "Season Results",
        "ar": "نتائج الموسم",
      },
      "action": (context, prizes) {
        Navigator.pushNamed(context, '/results');
      },
    },
    {
      'title': {
        'en': "Promotion Prizes",
        "ar": "جوائز الترقية",
      },
      "action": (context, prizes) {
        ModalContainer.modal(
            context,
            PrizesContent(prizes: prizes),
            AppLocalizations.of(context)!.prizes);
      },
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DoubleGridContainer(
      widget: navs
          .map<Widget>((nav) => RankNavLinks(
              action: () {
                nav['action'](context, user['rank']['prizes']);
              },
              locale: locale,
              title: nav['title'][locale]))
          .toList(),
    );
  }
}
