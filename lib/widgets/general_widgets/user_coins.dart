import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserCoins extends StatelessWidget {
  const UserCoins({super.key});

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: true).user;

    return user.isEmpty
        ? Container()
        : Align(
            alignment:
                Provider.of<LocaleProvider>(context, listen: false).locale ==
                        'en'
                    ? Alignment.topLeft
                    : Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: MainButtonNoWidth(
                buttonText: '',
                action: () {},
                isWidget: true,
                radius: 12,
                widget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        title: AppLocalizations.of(context)!.youHave),
                    const SizedBox(
                      width: 3,
                    ),
                    TextWidget(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        alwaysEnglish: true,
                        title:
                            '${Provider.of<LocaleProvider>(context, listen: false).user['coins']}'),
                    const SizedBox(
                      width: 3,
                    ),
                    const Coin(
                      width: 22,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
