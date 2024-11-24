import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar_loading_card.dart';

class BuyAvatars extends StatelessWidget {
  final List avatars;
  final bool loading;
  const BuyAvatars({super.key, required this.avatars, required this.loading});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Container(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          children: [
            const UserCoins(),
            const SizedBox(
              height: 16,
            ),
            loading
                ? const SingleAvatarLoadingCard()
                : GridContainer(
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
