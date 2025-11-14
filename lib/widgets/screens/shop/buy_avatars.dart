import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/general_widgets/user_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar_loading_card.dart';

class BuyAvatars extends StatelessWidget {
  final List avatars;
  final bool loading;
  final VoidCallback? onBuyMoreTap;
  
  const BuyAvatars({
    super.key,
    required this.avatars,
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
            const SizedBox(height: 20),
            loading
                ? const SingleAvatarLoadingCard()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: avatars.length,
                    itemBuilder: (context, index) {
                      return SingleAvatar(avatar: avatars[index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
