import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserCoins extends StatelessWidget {
  const UserCoins({super.key});

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;

    return user.isEmpty
        ? Container()
        : Align(
            alignment:
                Provider.of<LocaleProvider>(context, listen: false).locale ==
                        'en'
                    ? Alignment.topLeft
                    : Alignment.topRight,
            child: MainButtonNoWidth(
              buttonText: '',
              action: () {},
              isWidget: true,
              radius: 12,
              widget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      title:
                          '${AppLocalizations.of(context)!.youHave} ${Provider.of<LocaleProvider>(context, listen: false).user['coins']}'),
                  const SizedBox(
                    width: 3,
                  ),
                  Image.asset(
                    'assets/images/coin.png',
                    width: 25,
                  ),
                ],
              ),
            ),
          );
  }
}
