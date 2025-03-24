import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/carousel_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FriendMatches extends StatelessWidget {
  const FriendMatches({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    void hostMatch() {
      if (GeneralMethods().isUserExists(context)) {
        ModalContainer.bottomSheetHostGame(context, localeProvider,
            hostRoom: true);
      } else {
        Navigator.pushNamed(context, '/signup');
      }
    }

    void joinMatch() {
      if (GeneralMethods().isUserExists(context)) {
        ModalContainer.codeInputModal(context, localeProvider);
      } else {
        Navigator.pushNamed(context, '/signup');
      }
    }

    List rankedMatches = [
      {
        "image": "assets/images/host_match.jpg",
        "action": hostMatch,
        "title": {'en': "Create a Match", 'ar': "انشأ مباراة"},
        "desc": {
          'en': "Create a match code for your friend to join your match",
          'ar': "أنشئ رمز سري لصديقك لتحديه في مباراة."
        }
      },
      {
        "image": "assets/images/join_match.jpg",
        "action": joinMatch,
        "title": {'en': "Join a Match", 'ar': "ادخل مباراة"},
        "desc": {
          'en': "Join a match with your friend's match code",
          'ar':
              "انضم إلى مباراة باستخدام الرمز السري للمباراة التي انشأها صديقك."
        }
      },
    ];
    return CarouselContainer(
        title: AppLocalizations.of(context)!.play_with_your_friends,
        desc: AppLocalizations.of(context)!.friends_desc,
        locale: localeProvider.locale,
        data: rankedMatches);
  }
}
