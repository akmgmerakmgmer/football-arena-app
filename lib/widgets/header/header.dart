import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/containers/polygon_painter.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  playNow(context) {
    if (!GeneralMethods().isUserExists(context)) {
      return Navigator.pushNamed(
        context,
        '/login',
      );
    }
    Navigator.pushNamed(
      context,
      '/questions',
    );
  }

  changeLang(context) {
    if (GeneralMethods().getLocale(context) == 'ar') {
      return GeneralMethods().changeLanguage(context, 'en');
    }
    GeneralMethods().changeLanguage(context, 'ar');
  }

  @override
  Widget build(BuildContext context) {
    String locale = GeneralMethods().getLocale(context);
    Map user = Provider.of<LocaleProvider>(context, listen: true).user;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GeneralMethods().isUserExists(context)
                ? Column(
                    children: [
                      const Coin(width: 20,),
                      SizedBox(
                        height: locale == 'ar' ? 2 : 4,
                      ),
                      TextWidget(
                        title: user['coins'].toString(),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        alwaysEnglish: true,
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/login',
                    ),
                    child: Column(
                      children: [
                        const NeonIcon(icon: Icons.language),
                        SizedBox(
                          height: locale == 'ar' ? 2 : 4,
                        ),
                        TextWidget(
                          title: AppLocalizations.of(context)!.login_word,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => playNow(context),
                child: CustomPaint(
                  size: const Size(200, 45), // Adjust size as needed
                  painter: PolygonPainter(),
                ),
              ),
              GestureDetector(
                onTap: () => playNow(context),
                child: TextWidget(
                  title: AppLocalizations.of(context)!.playNow,
                  uppercase: true,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => changeLang(context),
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
          ),
        ],
      ),
    );
  }
}
