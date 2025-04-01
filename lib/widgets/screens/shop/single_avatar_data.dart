import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SingleAvatarData extends StatelessWidget {
  final double width;
  final Map avatar;
  final Function action;
  final bool loading;
  const SingleAvatarData(
      {super.key,
      required this.width,
      required this.avatar,
      required this.action,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar['endDate'] != null && avatar['endDate'].isNotEmpty
            ? WhiteGlassBackground(
                darkenBackground: true,
                padding: const EdgeInsets.all(0),
                body: Row(
                  children: [
                    TextWidget(
                      title: AppLocalizations.of(context)!.ends_on,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    TextWidget(
                      title: avatar['endDate'],
                      alwaysEnglish: true,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ))
            : Container(),
        SizedBox(
            width: width > 1280
                ? width * 0.1
                : width > 1024
                    ? width * 0.2
                    : width > 450
                        ? width * 0.3
                        : width * 0.6,
            child: PurchaseButton(
              price: avatar['price'].toString(),
              buttonText: AppLocalizations.of(context)!.buyNow,
              action: () {
                action();
              },
              loading: loading,
            )),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
