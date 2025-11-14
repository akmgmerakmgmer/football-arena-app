import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/shop_button.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SingleAvatar extends StatefulWidget {
  final Map avatar;
  const SingleAvatar({
    super.key,
    required this.avatar,
  });

  @override
  State<SingleAvatar> createState() => _SingleAvatarState();
}

class _SingleAvatarState extends State<SingleAvatar> {
  bool loading = false;
  bool isHovered = false;

  Future<void> onClick() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/signup');
    } else {
      setState(() {
        loading = true;
      });
      PutApi('buy-avatar/${user['_id']}', {"avatar": widget.avatar}, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.congratsAvatar,
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

  @override
  Widget build(BuildContext context) {
    bool hasEndDate = widget.avatar['endDate'] != null && widget.avatar['endDate'].isNotEmpty;
    int quantity = widget.avatar['quantity'] ?? 0;
    
    return GestureDetector(
      onTap: loading ? null : onClick,
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Colors.black.withOpacity(0.8),
              ],
            ),
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
              children: [
                // Avatar Image
                Positioned.fill(
                  child: CachedImage(
                    image: widget.avatar['image'],
                  ),
                ),
                
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                
                // Limited Quantity Badge (Top)
                if (quantity > 0 && quantity < 10)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.redAccent],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          TextWidget(
                            title: '$quantity ${AppLocalizations.of(context)!.left}',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // End Date Badge (Top Right)
                if (hasEndDate)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              color: Colors.white.withOpacity(0.9), size: 12),
                          const SizedBox(width: 4),
                          TextWidget(
                            title: widget.avatar['endDate'],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // Bottom Section - Price & Buy
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Price Display
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(
                                title: widget.avatar['price'].toString(),
                                alwaysEnglish: true,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              const Coin(width: 20),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Buy Button
                        ShopButton(
                          buttonText: AppLocalizations.of(context)!.buyNow,
                          action: onClick,
                          loading: loading,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
