import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/drawer/drawer_item.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isUserExists = false;

  void logoutMethod() async {
    String currentPath = ModalRoute.of(context)?.settings.name ?? '/';
    if (currentPath == '/profile' || currentPath == '/events') {
      Navigator.pushNamed(context, '/');
    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', '');
    // ignore: use_build_context_synchronously
    Provider.of<LocaleProvider>(context, listen: false).setUser({});
    setState(() {
      isUserExists = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isUserExists = Provider.of<LocaleProvider>(context, listen: false)
        .user
        .containsKey('username');
    String currentPath = ModalRoute.of(context)?.settings.name ?? '/';
    return Drawer(
      backgroundColor: Theme.of(context).splashColor,
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          isUserExists
              ? DrawerItem(
                  text:
                      '${AppLocalizations.of(context)!.welcome} ${Provider.of<LocaleProvider>(context, listen: false).user['username']}',
                  icon: Icons.account_circle,
                  textSize: 18,
                  iconSize: 30,
                  bottomPadding: 0,
                  isTitle: true,
                  action: () {},
                )
              : Container(),
          isUserExists
              ? Divider(
                  color: Colors.grey.shade700,
                )
              : Container(),
          DrawerItem(
            text: AppLocalizations.of(context)!.home,
            icon: Icons.home,
            action: () {
              Navigator.pushNamed(context, '/');
            },
            selected: currentPath == '/',
          ),
          // DrawerItem(
          //   text: AppLocalizations.of(context)!.about,
          //   icon: Icons.book,
          //   action: () {},
          // ),
          DrawerItem(
            text: AppLocalizations.of(context)!.rankings,
            icon: Icons.view_list,
            action: () {
              Navigator.pushNamed(context, '/rankings');
            },
            selected: currentPath == '/rankings',
          ),
          DrawerItem(
            text: AppLocalizations.of(context)!.challengesWord,
            icon: Icons.webhook,
            action: () {
              Navigator.pushNamed(context, '/challenges');
            },
            selected: currentPath == '/challenges',
          ),
          // DrawerItem(
          //   text: AppLocalizations.of(context)!.challenges,
          //   icon: Icons.webhook,
          //   action: () {},
          // ),
          // DrawerItem(
          //   text: AppLocalizations.of(context)!.prizes,
          //   icon: Icons.attach_money,
          //   action: () {},
          // ),
          // DrawerItem(
          //   text: AppLocalizations.of(context)!.bestOffers,
          //   icon: Icons.discount,
          //   action: () {
          //     Navigator.pushNamed(context, '/best-offers');
          //   },
          //   selected: currentPath == '/best-offers',
          // ),
          DrawerItem(
            text: AppLocalizations.of(context)!.shop,
            icon: Icons.shopping_bag,
            action: () {
              Navigator.pushNamed(context, '/shop');
            },
            selected: currentPath == '/shop',
          ),
          isUserExists
              ? DrawerItem(
                  text: AppLocalizations.of(context)!.accountProfile,
                  icon: Icons.person,
                  action: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  selected: currentPath == '/profile',
                )
              : Container(),
          isUserExists
              ? currentPath != '/profile'
                  ? DrawerItem(
                      text: AppLocalizations.of(context)!.logout,
                      icon: Icons.logout,
                      action: logoutMethod)
                  : Container()
              : DrawerItem(
                  text: AppLocalizations.of(context)!.login,
                  icon: Icons.login,
                  action: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  selected: currentPath == '/login',
                ),
          DrawerItem(
            text: AppLocalizations.of(context)!.createAccount,
            icon: Icons.login,
            action: () {
              Navigator.pushNamed(context, '/signup');
            },
            selected: currentPath == '/signup',
          ),
          DrawerItem(
            text: 'English',
            icon: Icons.language,
            action: () {
              GeneralMethods().changeLanguage(context);
            },
          ),
          DrawerItem(
            text: 'عربي',
            icon: Icons.language,
            action: () {
              GeneralMethods().changeLanguage(context);
            },
          ),
        ],
      ),
    );
  }
}
