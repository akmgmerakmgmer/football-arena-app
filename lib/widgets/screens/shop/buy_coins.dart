import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/shop_loading_cards.dart';
import 'package:in_zone_app/widgets/screens/shop/single_coin_shop.dart';

class BuyCoins extends StatelessWidget {
  final List coins;
  final bool loading;
  final VoidCallback? onBuyMoreTap;
  
  const BuyCoins({
    super.key,
    required this.coins,
    required this.loading,
    this.onBuyMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    // Find the best value (highest coin count)
    int bestValueIndex = 0;
    if (coins.isNotEmpty) {
      int maxCoins = 0;
      for (int i = 0; i < coins.length; i++) {
        if (coins[i]['numberOfCoins'] > maxCoins) {
          maxCoins = coins[i]['numberOfCoins'];
          bestValueIndex = i;
        }
      }
    }

    return FadeTransitionContainer(
      body: Container(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          children: [
            UserCoins(onBuyMoreTap: onBuyMoreTap),
            const SizedBox(height: 20),
            loading
                ? const ShopLoadingCards()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      return SingleCoinShop(
                        coin: coins[index],
                        isBestValue: index == bestValueIndex && coins.length > 1,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
