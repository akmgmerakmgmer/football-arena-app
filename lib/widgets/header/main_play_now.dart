import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/containers/polygon_painter.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPlayNow extends StatelessWidget {
  const MainPlayNow({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => playNow(context),
          child: CustomPaint(
            size: const Size(200, 50), // Adjust size as needed
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
    );
  }
}
