import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/user_perks_quantity.dart';
import 'package:provider/provider.dart';

class SinglePerkShop extends StatefulWidget {
  final Map perk;
  const SinglePerkShop({super.key, required this.perk});

  @override
  State<SinglePerkShop> createState() => _SinglePerkShopState();
}

class _SinglePerkShopState extends State<SinglePerkShop> {
  bool loading = false;
  int quantity = 1;

  void addQuantity() {
    if (quantity == 10) {
      return;
    }
    setState(() {
      quantity = quantity + 1;
    });
  }

  void decreaseQuantity() {
    if (quantity == 1) {
      return;
    }
    setState(() {
      quantity = quantity - 1;
    });
  }

  Future<void> buyPerk() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/signup');
    } else {
      setState(() {
        loading = true;
      });
      Map payload = {
        'perkId': widget.perk['_id'],
        'quantity': quantity,
      };
      PutApi('buy-perks/${user['_id']}', payload, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.congratsText,
            label: AppLocalizations.of(context)!.checkYourAccount, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/profile');
        });
        setState(() {
          loading = false;
        });
      }, errorCallback: (err) {
        String message =
            Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                ? err['message']['ar']
                : err['message']['en'];
        SnackbarMessage().snackbar(context, message, error: true);
        setState(() {
          loading = false;
        });
      }).put(context);
    }
  }

  getPerkQuantity() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      return 0;
    }
    List currentPerk = user['perks']
        .where((item) => item['id']['_id'] == widget.perk['_id'])
        .toList();
    if (currentPerk.isNotEmpty) {
      return currentPerk[0]['quantity'];
    }
    return 0;
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
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedImage(
                image: widget.perk['backgroundImage'],
                height: 450,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.black.withOpacity(0.6),
            ),
            width: MediaQuery.of(context).size.width,
            height: 450,
          ),
          user.isNotEmpty
              ? Positioned(
                  top: 15,
                  left: 10,
                  child: UserPerksQuantity(quantity: getPerkQuantity()))
              : Container(),
          Positioned(
            bottom: 15,
            width: width * 0.9,
            child: Column(
              children: [
                Row(
                  children: [
                    CachedImage(
                      image: widget.perk['image'],
                      width: 50,
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
                              ? widget.perk['title']['en']
                              : widget.perk['title']['ar'],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: TextWidget(
                            title: locale == 'en'
                                ? widget.perk['description']['en']
                                : widget.perk['description']['ar'],
                            fontSize: 14,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                BlurBackgroundContainer(
                    border: 100,
                    padding: 8,
                    body: SizedBox(
                      width: width > 1280
                          ? width * 0.2
                          : width > 1024
                              ? width * 0.3
                              : width > 450
                                  ? width * 0.4
                                  : width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.ltr,
                        children: [
                          GestureDetector(
                            onTap: decreaseQuantity,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 26,
                                )),
                          ),
                          TextWidget(
                            title: quantity.toString(),
                            number: true,
                            fontSize: 16,
                          ),
                          GestureDetector(
                            onTap: addQuantity,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 26,
                                )),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: width > 1280
                        ? width * 0.1
                        : width > 1024
                            ? width * 0.2
                            : width > 450
                                ? width * 0.3
                                : width * 0.6,
                    child: PurchaseButton(
                      price: (quantity * widget.perk['price']).toString(),
                      buttonText: AppLocalizations.of(context)!.buyNow,
                      action: () {
                        buyPerk();
                      },
                      loading: loading,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
