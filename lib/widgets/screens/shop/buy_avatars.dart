import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar.dart';

class BuyAvatars extends StatelessWidget {
  final List avatars;
  const BuyAvatars({super.key, required this.avatars});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TitleWithBorder(
                title: AppLocalizations.of(context)!.buyMoreAvatars),
            const SizedBox(
              height: 16,
            ),
            const UserCoins(),
            const SizedBox(
              height: 16,
            ),
            GridContainer(
                widget: avatars
                    .map((avatar) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SingleAvatar(
                            avatar: avatar,
                          ),
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }
}
