import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/shop_button.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            SizedBox(
              width: width,
              child: CachedImage(
                image: widget.perk['backgroundImage'],
                height: 450,
              ),
            ),
            
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
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
            left: 15,
            right: 15,
            child: Column(
              children: [
                // Perk Info
                Row(
                  children: [
                    // Perk Icon with glow
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: CachedImage(
                        image: widget.perk['image'],
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: locale == 'en'
                                ? widget.perk['title']['en']
                                : widget.perk['title']['ar'],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 4),
                          TextWidget(
                            title: locale == 'en'
                                ? widget.perk['description']['en']
                                : widget.perk['description']['ar'],
                            fontSize: 13,
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Quantity Selector
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease Button
                      GestureDetector(
                        onTap: decreaseQuantity,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: quantity == 1
                                ? Colors.grey.withOpacity(0.3)
                                : Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      // Quantity Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextWidget(
                          title: quantity.toString(),
                          number: true,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      // Increase Button
                      GestureDetector(
                        onTap: addQuantity,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: quantity == 10
                                ? Colors.grey.withOpacity(0.3)
                                : Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Buy Button
                SizedBox(
                  width: width > 1280
                      ? width * 0.5
                      : width > 1024
                          ? width * 0.6
                          : width > 450
                              ? width * 0.7
                              : width * 0.85,
                  child: ShopButton(
                    buttonText: AppLocalizations.of(context)!.buyNow,
                    action: buyPerk,
                    loading: loading,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          title: (quantity * widget.perk['price']).toString(),
                          alwaysEnglish: true,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        const Coin(width: 20),
                        if (quantity > 1) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextWidget(
                              title: 'x$quantity',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              alwaysEnglish: true,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
