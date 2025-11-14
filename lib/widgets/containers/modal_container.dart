import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget_blured.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/home/coins_button.dart';
import 'package:in_zone_app/widgets/screens/home/video_ad_button.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/code_input_form.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/room_data.dart';

class ModalContainer {
  static modal(BuildContext context, Widget widget, String title,
      {dynamic closeCallBack, dynamic action, bool loading = false}) {
    // showAnimatedDialog(context, title: title, widget: widget);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: title,
            loading: loading,
            widget: SingleChildScrollView(child: widget),
            closeCallBack: () {
              if (closeCallBack != null) {
                closeCallBack();
              }
            },
            action: action));
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
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: AppLocalizations.of(context)!.choose_option_to_play,
            widget: RoomData(isCasual: isCasual, hostRoom: hostRoom)));
  }

  static codeInputModal(BuildContext context, LocaleProvider localeProvider) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DialogWidgetBlured(
            title: AppLocalizations.of(context)!.match_code,
            description: AppLocalizations.of(context)!.enter_code,
            widget: const CodeInputForm()));
  }
}

void showModalBottomSheetContainer(BuildContext context, Widget body) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final double topPadding =
          mediaQuery.padding.top + 16; // Add extra space from top

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 1.0,
          minChildSize: 1.0,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1a237e).withOpacity(0.95),
                    const Color(0xFF0d47a1).withOpacity(0.98),
                    Colors.black.withOpacity(0.98),
                  ],
                ),
                border: Border.all(
                  color: Colors.cyan.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: PagesAssetBackground(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: topPadding), // Add space from top
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.6),
                              Colors.red.withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.5),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Expanded(child: body),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
