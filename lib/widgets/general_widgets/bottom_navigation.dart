import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    String currentPath = ModalRoute.of(context)?.settings.name ?? '/';
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    List navigationRoutes = [
      user.isNotEmpty
          ? {
              "text": AppLocalizations.of(context)!.profile,
              "icon": Icons.person,
              "action": () {
                Navigator.pushNamed(context, '/profile');
              },
              "selected": currentPath == '/profile'
            }
          : {
              "text": AppLocalizations.of(context)!.login_word,
              "icon": Icons.login,
              "action": () {
                Navigator.pushNamed(context, '/signup');
              },
              "selected": currentPath == '/signup' || currentPath == '/login'
            },
      {
        "text": AppLocalizations.of(context)!.play_online,
        "icon": Icons.emoji_events,
        "action": () {
          Navigator.pushNamed(context, '/main-online-screen');
        },
        "selected": currentPath == '/main-online-screen'
      },
      {
        "text": AppLocalizations.of(context)!.events,
        "icon": Icons.sports_soccer,
        "action": () {
          Navigator.pushNamed(context, '/play-alone');
        },
        "selected": currentPath == '/' || currentPath == '/play-alone',
      },
      {
        "text": AppLocalizations.of(context)!.navigationRankings,
        "icon": Icons.leaderboard,
        "action": () {
          Navigator.pushNamed(context, '/rankings');
        },
        "selected": currentPath == '/rankings'
      },
      {
        "text": AppLocalizations.of(context)!.shop,
        "icon": Icons.shopping_bag,
        "action": () {
          Navigator.pushNamed(context, '/shop');
        },
        "selected": currentPath == '/shop'
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
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: route['selected']
                                ? [
                                    BoxShadow(
                                      color: Theme.of(context).primaryColor
                                          .withOpacity(0.1), // White glow color
                                      spreadRadius: 0, // Adjust for glow size
                                      blurRadius:
                                          50, // Adjust for softness of the glow
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            route['icon'],
                            color: route['selected']
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            size: 36,
                          ),
                        ),
                        TextWidget(
                          title: route['text'],
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: route['selected']
                              ? Theme.of(context).primaryColor
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
