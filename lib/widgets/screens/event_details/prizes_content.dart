import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/event_details/image_prize.dart';
import 'package:in_zone_app/widgets/screens/event_details/coin_prize.dart';
import 'package:provider/provider.dart';

class PrizesContent extends StatelessWidget {
  final List prizes;
  const PrizesContent({super.key, required this.prizes});

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    Widget prizeWidget(prizeType, numberOfCoins, image, theme,
        {message = const {"en": "", "ar": ""}}) {
      switch (prizeType) {
        case "coins":
          return CoinPrize(
            numberOfCoins: numberOfCoins,
            message: message,
            locale: locale,
          );
        case "avatar":
          return ImagePrize(image: image, prizeType: prizeType);
        case "theme":
          return ImagePrize(
            image: theme,
            prizeType: prizeType,
            topMargin: true,
          );
        default:
          return Container();
      }
    }

    return Column(
      children: prizes
          .map((prize) => prizeWidget(prize['prizeType'], prize['coins'],
              prize['avatar'], prize['theme'],
              message: prize['message'] ?? {"en": "", "ar": ""}))
          .toList(),
    );
  }
}
