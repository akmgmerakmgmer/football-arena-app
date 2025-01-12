import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget_blured.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/home/coins_button.dart';
import 'package:in_zone_app/widgets/screens/home/video_ad_button.dart';

class ModalContainer {
  static modal(BuildContext context, Widget widget, String title,
      {dynamic closeCallBack}) {
    showDialog(
        context: context,
        builder: (ctx) => DialogWidgetBlured(
              title: title,
              widget: SingleChildScrollView(child: widget),
              closeCallBack: () {
                if (closeCallBack != null) {
                  closeCallBack();
                }
              },
            ));
  }

  static updateModal(BuildContext context, Widget widget, String title) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => PopScope(
              onPopInvoked: (bool didPop) {},
              child: AlertDialog(
                backgroundColor: Colors.black,
                title: TextWidget(
                  title: title,
                  fontSize: 18,
                ),
                content: SingleChildScrollView(child: widget),
              ),
            ));
  }

  static choosePlayOptionModal(
      BuildContext context, LocaleProvider localeProvider, mode,
      {isOnline = false,callback}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: AppLocalizations.of(context)!.choose_option_to_play,
            description:
                AppLocalizations.of(context)!.choose_option_description,
            widget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoAdButton(
                  mode: mode,
                  localeProvider: localeProvider,
                  isOnline: isOnline,
                ),
                const SizedBox(
                  width: 16,
                ),
                CoinsButton(
                  mode: mode,
                  localeProvider: localeProvider,
                  isOnline: isOnline,
                  callback: callback,
                )
              ],
            )));
  }
}
