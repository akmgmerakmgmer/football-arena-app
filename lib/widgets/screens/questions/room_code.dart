import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class RoomCode extends StatelessWidget {
  final String code;
  const RoomCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlurBackgroundContainer(
              whitenBackground: true,
              padding: 16,
              body: TextWidget(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  title: '${AppLocalizations.of(context)!.room_code} $code')),
        ));
  }
}
