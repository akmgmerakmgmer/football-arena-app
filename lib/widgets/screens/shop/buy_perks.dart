import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/shop_loading_cards.dart';
import 'package:in_zone_app/widgets/screens/shop/single_perk_shop.dart';

class BuyPerks extends StatelessWidget {
  final List perks;
  final bool loading;
  final VoidCallback? onBuyMoreTap;
  
  const BuyPerks({
    super.key,
    required this.perks,
    required this.loading,
    this.onBuyMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Container(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          children: [
            UserCoins(onBuyMoreTap: onBuyMoreTap),
            const SizedBox(height: 16),
            loading
                ? const ShopLoadingCards()
                : GridContainer(
                    widget: perks
                        .map((perk) => SinglePerkShop(
                              perk: perk,
                            ))
                        .toList())
          ],
        ),
      ),
    );
  }
}
