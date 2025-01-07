import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';

class ChangeLang extends StatelessWidget {
  final String locale;
  const ChangeLang({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => GeneralMethods().changeLanguage(context),
        child: Column(
          children: [
            const NeonIcon(icon: Icons.language),
            SizedBox(
              height: locale == 'ar' ? 4 : 2,
            ),
            TextWidget(
              title: locale == 'ar' ? 'English' : 'عربي',
              fontSize: locale == 'ar' ? 14 : 12,
              fontWeight: FontWeight.w600,
              alwaysEnglish: locale == 'ar' ? true : false,
              alwaysArabic: locale == 'ar' ? false : true,
            ),
          ],
        ),
      ),
    );
  }
}
