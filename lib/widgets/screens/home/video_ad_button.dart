import 'package:flutter/material.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class VideoAdButton extends StatelessWidget {
  final String mode;
  final LocaleProvider localeProvider;
  final bool isOnline;
  final bool hostRoom;
  final bool isCasual;
  const VideoAdButton(
      {super.key,
      required this.mode,
      required this.localeProvider,
      this.isOnline = false,
      this.hostRoom = false,
      this.isCasual = false});

  @override
  Widget build(BuildContext context) {
    final SocketMethods socketMethods = SocketMethods();
    return Expanded(
      child: MainButton(
          radius: 10,
          buttonText: '',
          isWidget: true,
          blueColor: true,
          widget: Column(
            children: [
              TextWidget(
                title: AppLocalizations.of(context)!.playNow,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  const Icon(
                    Icons.video_camera_back,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  TextWidget(
                    title: AppLocalizations.of(context)!.ad,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                  )
                ],
              )
            ],
          ),
          action: () {
            AdMethods().showInterstitialAd(() {
              if (isOnline && context.mounted) {
                Future.delayed(const Duration(seconds: 4), () {
                  socketMethods.joinRoom(context, localeProvider,
                      questionMode: mode,
                      hostRoom: hostRoom,
                      isCasual: isCasual);
                });
              } else {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: '/questions'),
                      builder: (context) => Questions(
                        questionMode: mode,
                        userId: localeProvider.user['_id'],
                      ),
                    ),
                  );
                });
              }
            }, context);
          }),
    );
  }
}
