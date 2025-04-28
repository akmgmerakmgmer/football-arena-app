import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/ends_on.dart';

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
            ? AnimatedEndsOn(endDate: avatar['endDate'])
            : Container(),
        SizedBox(
            width: width > 1280
                ? width * 0.16
                : width > 1024
                    ? width * 0.2
                    : width > 600
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
