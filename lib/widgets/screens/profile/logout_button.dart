import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              TextWidget(
                title: AppLocalizations.of(context)!.logout,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          content: TextWidget(
            title: 'Are you sure you want to logout?',
            fontSize: 16,
            color: Colors.grey.shade300,
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: TextWidget(
                title: 'Cancel',
                fontSize: 15,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            // Confirm Logout Button
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.pushReplacementNamed(context, '/');
                Auth().logout(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: TextWidget(
                title: AppLocalizations.of(dialogContext)!.logout,
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: () => _showLogoutDialog(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.red.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red.shade400,
                size: 18,
              ),
              const SizedBox(width: 8),
              TextWidget(
                title: AppLocalizations.of(context)!.logout,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
