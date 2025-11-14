import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/asset_image_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SingleOption extends StatefulWidget {
  final Map option;
  final String locale;
  final bool hostRoom;
  final bool isCasual;
  const SingleOption({
    super.key,
    required this.option,
    required this.locale,
    required this.hostRoom,
    required this.isCasual,
  });

  @override
  State<SingleOption> createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  bool loading = false;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    if (mounted) {
      LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      _socketMethods.joinRoomSuccesListener(context, localeProvider);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    return BlurContainer(
        child: Container(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).splashColor.withOpacity(0.65),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetImageWidget(
                image: widget.option['image'],
                radius: 100,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: widget.option[widget.locale],
                      fontSize: 16,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextWidget(
                      title: widget.locale == 'en'
                          ? widget.option['descriptionEn']
                          : widget.option['descriptionAr'],
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: MainButton(
                buttonText: AppLocalizations.of(context)!.selectMode,
                radius: 4,
                padding: const EdgeInsets.all(8),
                fontSize: 12,
                uppercase: true,
                loading: loading,
                action: () => {
                      setState(() {
                        loading = true;
                      }),
                      GeneralMethods().joinGameWithAds(context, localeProvider,
                          mode: widget.option['mode'],
                          hostRoom: widget.hostRoom,
                          isCasual: widget.isCasual)
                    }),
          ),
        ],
      ),
    ));
  }
}
