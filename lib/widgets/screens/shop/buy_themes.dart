import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar_loading_card.dart';
import 'package:in_zone_app/widgets/screens/shop/single_theme.dart';

class BuyThemes extends StatelessWidget {
  final List themes;
  final bool loading;
  const BuyThemes({super.key, required this.themes, required this.loading});

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
                    widget: themes
                        .map((theme) => SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: SingleTheme(
                                theme: theme,
                              ),
                            ))
                        .toList())
          ],
        ),
      ),
    );
  }
}
