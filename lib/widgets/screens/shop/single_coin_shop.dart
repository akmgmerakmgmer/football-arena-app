import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SingleCoinShop extends StatefulWidget {
  final Map coin;
  const SingleCoinShop({super.key, required this.coin});

  @override
  State<SingleCoinShop> createState() => _SingleCoinShopState();
}

class _SingleCoinShopState extends State<SingleCoinShop> {
  bool loading = false;
  Future<void> buyCoins(amount, quantity) async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/login');
    } else {
      setState(() {
        loading = true;
      });
      Map payload = {
        "username": user['username'],
        "amount": amount * 100,
        "phoneNumber": user['number'],
        "itemBought": 'coins',
        "itemQuantity": quantity
      };
      PostApi('card-payment', payload, (res) {
        ExternalUrl().launchNewUrl(
            'https://accept.paymob.com/api/acceptance/iframes/859270?payment_token=${res['paymentKey']}');
        setState(() {
          loading = false;
        });
      }).post(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width > 1280
        ? defaultWidth * 1 / 4
        : MediaQuery.of(context).size.width > 1024
            ? defaultWidth * 1 / 3
            : MediaQuery.of(context).size.width > 450
                ? defaultWidth * 1 / 2
                : defaultWidth;
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            width: width,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedImage(
                image: widget.coin['image'],
                height: 450,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.black.withOpacity(0.6),
          ),
          width: width,
          height: 450,
        ),
        Positioned(
          bottom: 15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    fit: BoxFit.cover,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title: locale == 'en'
                            ? widget.coin['title']['en']
                            : widget.coin['title']['ar'],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: TextWidget(
                          title: locale == 'en'
                              ? widget.coin['description']['en']
                              : widget.coin['description']['ar'],
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  width: width * 0.8,
                  margin: const EdgeInsets.all(12.0),
                  child: PurchaseButton(
                    currency: true,
                    price: widget.coin['price'].toString(),
                    buttonText: AppLocalizations.of(context)!.buyNow,
                    action: () {
                      buyCoins(
                          widget.coin['price'], widget.coin['numberOfCoins']);
                    },
                    loading: loading,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
