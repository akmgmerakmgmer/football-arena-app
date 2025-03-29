import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/utilities/game_data.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget_blured.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/home/coins_button.dart';
import 'package:in_zone_app/widgets/screens/home/video_ad_button.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/code_input_form.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/single_option.dart';

class ModalContainer {
  static modal(BuildContext context, Widget widget, String title,
      {dynamic closeCallBack}) {
    // showAnimatedDialog(context, title: title, widget: widget);
    showDialog(
        context: context,
        barrierDismissible: false,
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
      {isOnline = false,
      callback,
      showDesc = true,
      hostRoom = false,
      isCasual = false}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: AppLocalizations.of(context)!.choose_option_to_play,
            description: showDesc
                ? AppLocalizations.of(context)!.choose_option_description
                : '',
            widget: Row(
              children: [
                VideoAdButton(
                  mode: mode,
                  localeProvider: localeProvider,
                  isOnline: isOnline,
                  hostRoom: hostRoom,
                  isCasual: isCasual,
                ),
                const SizedBox(
                  width: 16,
                ),
                CoinsButton(
                  mode: mode,
                  localeProvider: localeProvider,
                  isOnline: isOnline,
                  callback: callback,
                  buttonText: AppLocalizations.of(context)!.playNow,
                  hostRoom: hostRoom,
                  isCasual: isCasual,
                )
              ],
            )));
  }

  static rateOurApp(BuildContext context, LocaleProvider localeProvider) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: AppLocalizations.of(context)!.rate_our_app,
            description: AppLocalizations.of(context)!.rate_our_app_desc,
            widget: MainButton(
                fontSize: 13,
                buttonText: AppLocalizations.of(context)!.rate_app,
                action: () {
                  Navigator.of(context).pop();
                  Map user = localeProvider.user;
                  ExternalUrl().launchNewUrl(
                      'https://play.google.com/store/apps/details?id=soccer.in_zone_gaming_app');
                  PutApi('users/${user['_id']}', {"app_rated": true},
                      (value) => {localeProvider.setUser(value)}).put(context);
                })));
  }

  static bottomSheetHostGame(
      BuildContext context, LocaleProvider localeProvider,
      {hostRoom = false, isCasual = false}) {
    showModalBottomSheetContainer(
        context,
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: GameData.modes
                  .map((option) => SingleOption(
                        option: option,
                        locale: localeProvider.locale,
                        hostRoom: hostRoom,
                        isCasual: isCasual,
                      ))
                  .toList(),
            )));
  }

  static codeInputModal(BuildContext context, LocaleProvider localeProvider) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidget(
            title: AppLocalizations.of(context)!.match_code,
            description: AppLocalizations.of(context)!.enter_code,
            widget: const CodeInputForm()));
  }
}

void showModalBottomSheetContainer(BuildContext context, Widget body) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full height
    backgroundColor: Colors.transparent, // Transparent background for margin
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16), // Optional rounded corners
        child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 1.0,
          minChildSize: 1.0,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.black, // Your modal background color
              child: Column(
                children: [
                  Align(
                    alignment:
                        Alignment.topLeft, // Position X button to the top-right
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () =>
                            Navigator.pop(context), // Close the modal
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                      child: body), // Display your content below the button
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
