import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/header/free_coins_button.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';
import 'package:in_zone_app/widgets/header/quick_actions_bar.dart';
import 'package:in_zone_app/widgets/header/user_info_card.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  
  @override
  Widget build(BuildContext context) {
    String locale = GeneralMethods().getLocale(context);
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    Map user = localeProvider.user;
    final bool userExists = GeneralMethods().isUserExists(context);
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.15),
            Theme.of(context).primaryColor.withOpacity(0.05),
            Colors.black.withOpacity(0.3),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 20,
        vertical: isMobile ? 10 : 12,
      ),
      child: Column(
        children: [
          // User Info Card - Full Width (if user exists)
          if (userExists)
            UserInfoCard(
              user: user,
              locale: locale,
            ),
          
          // Second Row - Free Coins and Quick Actions
          if (userExists) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left - Free Coins Button
                FreeCoinsButton(
                  localeProvider: localeProvider,
                  locale: locale,
                ),
                
                // Right - Quick Actions
                QuickActionsBar(locale: locale),
              ],
            ),
          ],
          
          // Login Button (if user doesn't exist)
          if (!userExists)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const NeonIcon(icon: Icons.login, size: 18),
                        const SizedBox(width: 8),
                        TextWidget(
                          title: AppLocalizations.of(context)!.login_word,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Quick Actions
                QuickActionsBar(locale: locale),
              ],
            ),
        ],
      ),
    );
  }
}
