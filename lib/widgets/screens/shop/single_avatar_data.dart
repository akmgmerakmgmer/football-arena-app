import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/ends_on.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';

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
    return Stack(
      children: [
        Positioned(
            top: 10,
            left: 10,
            child: NeonWhiteText(
                letterSpacing: 1.1,
                word:
                    '${AppLocalizations.of(context)!.limited_quantity} ${avatar['quantity'] ?? 0} ${AppLocalizations.of(context)!.left}',
                fontSize: 14,
                shadow: NeonBoxShadow().blueNeon(context))),
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Column(
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
          ),
        ),
      ],
    );
  }
}
