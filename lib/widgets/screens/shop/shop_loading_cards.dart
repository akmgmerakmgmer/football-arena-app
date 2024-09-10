import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/screens/shop/single_shop_loading_card.dart';

class ShopLoadingCards extends StatelessWidget {
  const ShopLoadingCards({super.key});
  @override
  Widget build(BuildContext context) {
    List numberOfIterations = [1, 2, 3, 4];
    double width = MediaQuery.of(context).size.width;
    return GridContainer(
        widget: numberOfIterations
            .map((item) => SizedBox(
                width: width, child: const SingleShopLoadingCard()))
            .toList());
  }
}
