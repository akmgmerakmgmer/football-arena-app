import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleMode extends StatelessWidget {
  final Map singleMode;
  const SingleMode({
    super.key,
    required this.singleMode,
  });

  bool isPlayedToday(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    if (user.isNotEmpty && user.containsKey('username')) {
      List currentMode = user['questionModes']
          .where((userMode) => userMode['modeName'] == singleMode['mode'])
          .toList();
      if (currentMode.isNotEmpty &&
          currentMode[0]['modeName'] == singleMode['mode'] &&
          currentMode[0]['lastPlayedDate'] == formattedDate) {
        return true;
      }
      return false;
    }
    return false;
  }

  playWithCoins(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.containsKey('username')) {
      if (user['coins'] < 100) {
        return SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.not_enough_coins,
            label: AppLocalizations.of(context)!.buy_coins,
            error: true, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/shop');
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Questions(
              questionMode: singleMode['mode'],
              price: 100,
              userId: Provider.of<LocaleProvider>(context, listen: false)
                  .user['_id'],
            ),
          ),
        );
      }
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  playMode(context) {
    if (Provider.of<LocaleProvider>(context, listen: false)
        .user
        .containsKey('username')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Questions(
            questionMode: singleMode['mode'],
            userId:
                Provider.of<LocaleProvider>(context, listen: false).user['_id'],
          ),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(singleMode['image']),
              )),
              width: 225,
              height: 420,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 225,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      title:
                          locale == 'ar' ? singleMode['ar'] : singleMode['en'],
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextWidget(
                      title: locale == 'ar'
                          ? singleMode['descriptionAr']
                          : singleMode['descriptionEn'],
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    isPlayedToday(context)
                        ? PurchaseButton(
                            buttonText: AppLocalizations.of(context)!.playNow,
                            action: () => playWithCoins(context),
                            price: '100')
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            constraints: const BoxConstraints(maxWidth: 200),
                            child: MainButton(
                                buttonText:
                                    AppLocalizations.of(context)!.playNow,
                                fontSize: 12.5,
                                uppercase: true,
                                letterSpacing: 1.1,
                                isChallengesPage: true,
                                radius: 10,
                                action: () => playMode(context)),
                          )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
