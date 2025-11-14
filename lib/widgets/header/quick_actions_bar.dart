import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';

class QuickActionsBar extends StatelessWidget {
  final String locale;
  
  const QuickActionsBar({
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Profile Button
        _buildActionButton(
          context,
          icon: Icons.person,
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          tooltip: locale == 'en' ? 'Profile' : 'الملف الشخصي',
        ),
        
        const SizedBox(width: 8),
        
        // Shop Button
        _buildActionButton(
          context,
          icon: Icons.shopping_bag,
          onTap: () {
            Navigator.pushNamed(context, '/shop');
          },
          tooltip: locale == 'en' ? 'Shop' : 'المتجر',
        ),
        
        const SizedBox(width: 8),
        
        // Language Toggle Button
        _buildActionButton(
          context,
          icon: Icons.language,
          onTap: () {
            GeneralMethods().changeLanguage(context);
          },
          tooltip: locale == 'en' ? 'العربية' : 'English',
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    Widget? badge,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              if (badge != null)
                Positioned(
                  top: -4,
                  right: -4,
                  child: badge,
                ),
            ],
          ),
        ),
      ),
    );
  }


}
