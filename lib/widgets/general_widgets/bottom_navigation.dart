import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    String currentPath = ModalRoute.of(context)?.settings.name ?? '/';
    List navigationRoutes = [
      {
        "text": AppLocalizations.of(context)!.challengesWord,
        "icon": Icons.local_fire_department,
        "action": () {
          Navigator.pushNamed(context, '/challenges');
        },
        "selected": currentPath == '/challenges'
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
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        border: Border(
          top: BorderSide(
            width: 1, 
            color: Colors.grey.shade900,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navigationRoutes.asMap().entries.map((entry) {
          final route = entry.value;
          final isSelected = route['selected'];
          
          return Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                route['action']();
              },
              splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
              highlightColor: Colors.transparent,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Active indicator bar
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: isSelected ? 32 : 0,
                        height: 3,
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColor.withOpacity(0.6),
                                  ],
                                )
                              : null,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      
                      // Icon with glow
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 12,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          route['icon'],
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade400,
                          size: 26,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Label with animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextWidget(
                          title: route['text'],
                          fontSize: isSelected ? 12 : 11,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
