import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoinsButton extends StatelessWidget {
  final String mode;
  final LocaleProvider localeProvider;
  final bool isOnline;
  final dynamic callback;
  const CoinsButton(
      {super.key,
      required this.mode,
      required this.localeProvider,
      this.isOnline = false,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IntrinsicHeight(
        child: MainButton(
            radius: 10,
            buttonText: '',
            isWidget: true,
            widget: Column(
              children: [
                TextWidget(
                  title: AppLocalizations.of(context)!.playNow,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: '100',
                      alwaysEnglish: true,
                      fontSize: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Coin(
                      width: 20,
                    )
                  ],
                ),
              ],
            ),
            action: () {
              if (context.mounted) {
                GeneralMethods()
                    .playWithCoins(context, localeProvider, mode, isOnline);
              }
              if (callback != null) {
                Navigator.pop(context);
                callback();
              }
            }),
      ),
    );
  }
}
