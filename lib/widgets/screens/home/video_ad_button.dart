import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/video_reward_ad.dart';

class VideoAdButton extends StatelessWidget {
  final String mode;
  final LocaleProvider localeProvider;
  final bool isOnline;
  const VideoAdButton(
      {super.key,
      required this.mode,
      required this.localeProvider,
      this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    final SocketMethods socketMethods = SocketMethods();
    return Expanded(
      child: IntrinsicHeight(
          child: MainButton(
              radius: 10,
              buttonText: '',
              isWidget: true,
              widget: VideoRewardAd(
                  body: Column(
                    children: [
                      TextWidget(
                        title: AppLocalizations.of(context)!.playNow,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Icon(
                        Icons.video_camera_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                  rewardMethod: () {
                    if (isOnline && context.mounted) {
                      socketMethods.joinRoom(context, localeProvider,
                          questionMode: mode);
                    } else {
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
                    }
                  }),
              action: () {})),
    );
  }
}
