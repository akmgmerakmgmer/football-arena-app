import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/shop_button.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SingleTheme extends StatefulWidget {
  final Map theme;
  const SingleTheme({
    super.key,
    required this.theme,
  });

  @override
  State<SingleTheme> createState() => _SingleThemeState();
}

class _SingleThemeState extends State<SingleTheme> {
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
      PutApi('buy-theme/${user['_id']}', {"theme": widget.theme}, (res) {
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

  @override
  Widget build(BuildContext context) {
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
                // Theme Image
                Positioned.fill(
                  child: CachedImage(
                    image: widget.theme['image'],
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
                
                // Preview Button (Top Right)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: '/questions'),
                          builder: (context) => Questions(
                            themePreview: widget.theme['image'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.9),
                            Theme.of(context).primaryColor.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 20,
                      ),
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
                                title: widget.theme['price'].toString(),
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
