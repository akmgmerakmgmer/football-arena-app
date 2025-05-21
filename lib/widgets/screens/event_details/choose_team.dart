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

  chooseValue() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.containsKey('username')) {
      if (user['coins'] < widget.event['price']) {
        return SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.not_enough_coins,
            label: AppLocalizations.of(context)!.buy_coins,
            error: true, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/shop');
        });
      } else {
        if (selectedValue != '') {
          setState(() {
            buttonLoading = true;
          });
          Map eventPayload = {
            'eventId': widget.event['_id'],
            'sideId': selectedValue,
            'endDate': widget.event['endDate'],
            'price': widget.event['price']
          };
          PutApi('add-event/${user['_id']}', eventPayload, (res) {
            Provider.of<LocaleProvider>(context, listen: false).setUser(res);
            setState(() {
              buttonLoading = false;
            });
          }).put(context);
        }
      }
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
          EventPrizes(prizes: widget.event['prizes']),
          Container(
              margin: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 12),
              child: TextWidget(
                title: AppLocalizations.of(context)!.chooseYourTeam,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          Column(
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
          ),
          const SizedBox(
            height: 8,
          ),
          PurchaseButton(
              buttonText: AppLocalizations.of(context)!.choose,
              action: chooseValue,
              loading: buttonLoading,
              price: '${widget.event['price']}')
        ],
      ),
    );
  }
}
