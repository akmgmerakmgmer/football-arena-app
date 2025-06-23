import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_prizes.dart';
import 'package:in_zone_app/widgets/screens/event_details/single_side.dart';
import 'package:provider/provider.dart';

class ChooseTeam extends StatefulWidget {
  final Map event;
  final String locale;
  const ChooseTeam({
    super.key,
    required this.event,
    required this.locale,
  });

  @override
  State<ChooseTeam> createState() => _ChooseTeamState();
}

class _ChooseTeamState extends State<ChooseTeam> {
  bool buttonLoading = false;
  String selectedValue = '';

  void teamEvent() {}

  enterEvent() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.containsKey('username')) {
      // if (user['coins'] < widget.event['price']) {
      //   return SnackbarMessage().snackbar(
      //       context, AppLocalizations.of(context)!.not_enough_coins,
      //       label: AppLocalizations.of(context)!.buy_coins,
      //       error: true, action: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //     Navigator.pushNamed(context, '/shop');
      //   });
      // } else {
      //   Map eventPayload = {
      //     'eventId': widget.event['_id'],
      //     'endDate': widget.event['endDate'],
      //     'price': widget.event['price']
      //   };
      //   if (widget.event['isSinglePlayer'] != true &&
      //       widget.event['isMultiplayer'] != true) {
      //     if (selectedValue == '') {
      //       return SnackbarMessage().snackbar(
      //           context, AppLocalizations.of(context)!.chooseYourTeam,
      //           label: AppLocalizations.of(context)!.chooseYourTeamFirst,
      //           error: true, action: () {
      //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //         Navigator.pushNamed(context, '/shop');
      //       });
      //     } else {
      //       eventPayload['sideId'] = selectedValue;
      //     }
      //   }
      //   setState(() {
      //     buttonLoading = true;
      //   });
      //   PutApi('add-event/${user['_id']}', eventPayload, (res) {
      //     Provider.of<LocaleProvider>(context, listen: false).setUser(res);
      //     setState(() {
      //       buttonLoading = false;
      //     });
      //   }).put(context);
      // }
      Map eventPayload = {
        'eventId': widget.event['_id'],
        'endDate': widget.event['endDate'],
        'price': 0
      };
      if (widget.event['isSinglePlayer'] != true &&
          widget.event['isMultiplayer'] != true) {
        if (selectedValue == '') {
          return SnackbarMessage().snackbar(
              context, AppLocalizations.of(context)!.chooseYourTeam,
              label: AppLocalizations.of(context)!.chooseYourTeamFirst,
              error: true, action: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pushNamed(context, '/shop');
          });
        } else {
          eventPayload['sideId'] = selectedValue;
        }
      }
      setState(() {
        buttonLoading = true;
      });
      PutApi('add-event/${user['_id']}', eventPayload, (res) {
        Provider.of<LocaleProvider>(context, listen: false).setUser(res);
        setState(() {
          buttonLoading = false;
        });
      }).put(context);
    } else {
      Navigator.pushNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagesAssetBackground(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventImage(
            event: widget.event,
            locale: widget.locale,
          ),
          const SizedBox(
            height: 16,
          ),
          EventPrizes(
              prizes: widget.event['prizes'],
              isSinglePlayer: widget.event['isSinglePlayer']),
          const SizedBox(
            height: 4,
          ),
          TextWidget(
            title: widget.event['description'][widget.locale] ?? '',
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.85),
          ),
          const SizedBox(
            height: 12,
          ),
          widget.event['isSinglePlayer'] != true &&
                  widget.event['isMultiplayer'] != true
              ? Column(
                  children: widget.event['sides']
                      .map<Widget>((side) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedValue = side['_id'];
                              });
                            },
                            child: SingleSide(
                                selected: side['_id'] == selectedValue,
                                title: widget.locale == 'ar'
                                    ? '${AppLocalizations.of(context)!.team} ${side['nameAr']}'
                                    : '${AppLocalizations.of(context)!.team} ${side['nameEn']}'),
                          ))
                      .toList(),
                )
              : Container(),
          const SizedBox(
            height: 8,
          ),
          PurchaseButton(
              buttonText: widget.event['isSinglePlayer']
                  ? AppLocalizations.of(context)!.enter_event
                  : AppLocalizations.of(context)!.choose,
              action: enterEvent,
              loading: buttonLoading,
              price: '0')
        ],
      ),
    );
  }
}
