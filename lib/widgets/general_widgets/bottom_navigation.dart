import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    String currentPath = ModalRoute.of(context)?.settings.name ?? '/';
    List navigationRoutes = [
      {
        "text": AppLocalizations.of(context)!.navigationHome,
        "icon": Icons.home,
        "action": () {
          Navigator.pushNamed(context, '/home');
        },
        "selected": currentPath == '/' || currentPath == '/home',
      },
      {
        "text": AppLocalizations.of(context)!.navigationRankings,
        "icon": Icons.view_list,
        "action": () {
          Navigator.pushNamed(context, '/rankings');
        },
        "selected": currentPath == '/rankings'
      },
      {
        "text": AppLocalizations.of(context)!.challengesWord,
        "icon": Icons.webhook,
        "action": () {
          Navigator.pushNamed(context, '/challenges');
        },
        "selected": currentPath == '/challenges'
      },
      {
        "text": AppLocalizations.of(context)!.shop,
        "icon": Icons.shopping_bag,
        "action": () {
          Navigator.pushNamed(context, '/shop');
        },
        "selected": currentPath == '/shop'
      },
      {
        "text": AppLocalizations.of(context)!.navigationBestOffers,
        "icon": Icons.discount,
        "action": () {
          Navigator.pushNamed(context, '/best-offers');
        },
        "selected": currentPath == '/best-offers'
      },
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade900))),
      child: Row(
        children: navigationRoutes
            .map((route) => GestureDetector(
                  onTap: () => {route['action']()},
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Column(
                      children: [
                        Icon(
                          route['icon'],
                          color: route['selected']
                              ? Colors.red.shade500
                              : Colors.grey.shade300,
                        ),
                        TextWidget(
                          title: route['text'],
                          fontSize: 12,
                          color: route['selected']
                              ? Colors.red.shade500
                              : Colors.grey.shade300,
                        )
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
