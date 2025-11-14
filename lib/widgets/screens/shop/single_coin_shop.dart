import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/buttons/shop_button.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SingleCoinShop extends StatefulWidget {
  final Map coin;
  final bool isBestValue;
  const SingleCoinShop({super.key, required this.coin, this.isBestValue = false});

  @override
  State<SingleCoinShop> createState() => _SingleCoinShopState();
}

class _SingleCoinShopState extends State<SingleCoinShop> {
  bool loading = false;
  Future<void> buyCoins(amount, quantity) async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/signup');
    } else {
      setState(() {
        loading = true;
      });
      Map payload = {
        "username": user['username'],
        "userId": user['_id'],
        "amount": amount,
        "phoneNumber": user['number'],
        "itemBought": 'coins',
        "itemQuantity": quantity
      };
      PostApi('card-payment', payload, (res) {
        ExternalUrl().launchNewUrl('${res['path']}');
        setState(() {
          loading = false;
        });
      }).post(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).primaryColor.withOpacity(0.15),
                  Colors.black.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.isBestValue 
                    ? Colors.amber.withOpacity(0.6)
                    : Theme.of(context).primaryColor.withOpacity(0.4),
                width: widget.isBestValue ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isBestValue
                      ? Colors.amber.withOpacity(0.4)
                      : Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Coin Icon
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Transform.scale(
                      scale: 2.5,
                      child: const Coin(),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Quantity
                  TextWidget(
                    title: widget.coin['numberOfCoins'].toString(),
                    alwaysEnglish: true,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  
                  // Title
                  TextWidget(
                    title: locale == 'en'
                        ? widget.coin['title']['en']
                        : widget.coin['title']['ar'],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Description
                  TextWidget(
                    title: locale == 'en'
                        ? widget.coin['description']['en']
                        : widget.coin['description']['ar'],
                    fontSize: 11,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Buy Button
                  ShopButton(
                    buttonText: AppLocalizations.of(context)!.buyNow,
                    action: () => buyCoins(widget.coin['price'], widget.coin['numberOfCoins']),
                    loading: loading,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          title: widget.coin['price'].toString(),
                          alwaysEnglish: true,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        TextWidget(
                          title: AppLocalizations.of(context)!.currency,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Best Value Badge
          if (widget.isBestValue)
            Positioned(
              top: -5,
              right: locale == 'en' ? -5 : null,
              left: locale == 'ar' ? -5 : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.amber, Colors.orange],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    const TextWidget(
                      title: 'Best Value',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      uppercase: true,
                    ),
                  ],
                ),
              ),
            ),
        ],
    );
  }
}
