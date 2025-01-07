import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/header/change_lang.dart';
import 'package:in_zone_app/widgets/header/header_coin.dart';
import 'package:in_zone_app/widgets/header/main_play_now.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    String locale = GeneralMethods().getLocale(context);
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    Map user = localeProvider.user;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderCoin(
            locale: locale,
            user: user,
            localeProvider: localeProvider,
          ),
          const MainPlayNow(),
          ChangeLang(locale: locale)
        ],
      ),
    );
  }
}
